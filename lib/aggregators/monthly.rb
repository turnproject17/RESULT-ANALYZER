module Aggregators
  class Monthly
    attr_accessor :date, :start_date, :end_date, :error_message, :data
    def initialize(date = nil)
      @date = date&.to_date.presence || Date.today
      @start_date = @date - 5.days
      @end_date = @date
      @data = []
      @error_message = ""
    end

    def calculate
      if get_window
        get_data.each do |daily_result_stat|
          @average = MonthlyAverage.new(daily_result_stat)
          unless @average.save
            raise "#{@average.errors.full_messages.to_sentence} - #{@date}"
          end
        end
      end
    rescue Exception =>e
      @error_message = e.message
    end

    private

    def sql_query
      sql = <<-SQL 
        Select 
          '#{date}' as date,
          subject as subject,
          AVG(daily_low) as monthly_avg_low,
          AVG(daily_high) as monthly_avg_high,
          Sum(result_count) as monthly_result_count_used

        from daily_result_stats
        where
          date >= \'#{start_date}\'
          and date <= \'#{end_date}\'
        group by subject;
      SQL
    end

    def get_data
      @data = ActiveRecord::Base.connection.exec_query(sql_query).to_a
      raise "No data available for #{@start_date} - #{@end_date}" if @data.blank?
      @data
    end

    def get_window
      if total_result_count_between < 200
        @start_date -= 1.day
        # puts "-----------#{@start_date} #{@end_date} -----------"
        return true if (@end_date == @start_date.beginning_of_month) || (@start_date + 1.month == @end_date)
        get_window
      end
    end

    def total_result_count_between
      DailyResultStat.where('date <= ? and date >= ?', "#{end_date}", "#{start_date}").sum(:result_count)
    end
  end
end
