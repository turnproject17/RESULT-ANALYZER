class DailyResultAggregatorJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later
    run_daily_result_calculation
    if is_today_monday_of_third_wednesday?
      run_monthly_result_calculation
    end
  end

  private

  def run_daily_result_calculation
    @daily_aggregator = Aggregators::Daily.new
    if @daily_aggregator.calculate
      puts "Daily aggregation is completed"
    else
      puts "#{@daily_aggregator.error_message}"
    end
  end

  def run_monthly_result_calculation
    @monthly_aggregator = Aggregators::Monthly.new
    if @monthly_aggregator.calculate
      puts "Monthly aggregation is completed"
    else
      puts "#{@monthly_aggregator.error_message}"
    end
  end

  def is_today_monday_of_third_wednesday?
    date_begin = Date.today.beginning_of_month
    date_end = Date.today.end_of_day
    all_wednesdays = [*date_begin..date_end].select(&:wednesday?)
    return Date.today.monday? && (all_wednesdays[3] == Date.today.next_occurring(:wednesday))
  end
end
