module Aggregators
  class Daily
    attr_accessor :date, :start_time, :end_time, :error_message
    def initialize(date = nil)
      @date = date&.to_date.presence || Date.today.beginning_of_month
      @start_time = @date.beginning_of_day
      @end_time = @date.end_of_day
      @data = []
      @error_message = ""
    end

    def calculate
      get_data.each do |daily_result_stat|
        @daily = DailyResultStat.new(daily_result_stat)
        unless @daily.save
          raise "#{@daily.errors.full_messages.to_sentence} - #{@date}"
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
          Max(marks) as daily_high,
          Min(marks) as daily_low,
          Sum(marks) as total,
          Count(marks) as result_count

          from results
          where
            timestamp >= \'#{start_time}\'
            and timestamp <= \'#{end_time}\'
          group by subject;
      SQL
    end

    def get_data
      @data = ActiveRecord::Base.connection.exec_query(sql_query).to_a
      raise "No data received for #{Date.today}" if @data.blank?
      @data
    end
  end
end
