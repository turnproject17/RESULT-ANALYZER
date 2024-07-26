When('I create a new Monthly Average') do |table|
  hash_data = table.hashes
  @monthly_average = MonthlyAverage.create(hash_data)
end

Then('It should have stored the MonthlyAverage') do |data|
  hash_data = data.hashes.first
  @monthly_average = MonthlyAverage.last

  @monthly_average.monthly_avg_low == hash_data[:monthly_avg_low].to_f &&
  @monthly_average.monthly_avg_high == hash_data[:monthly_avg_high] .to_f
end


When('Setup result data for month') do 
  @results = Result.create([
    { subject: "Science", marks: "90", timestamp: "2024-07-15 12:01:34.678" }, 
    { subject: "Science", marks: "95", timestamp: "2024-07-15 12:01:34.678" },
    { subject: "Science", marks: "17", timestamp: "2024-07-14 12:01:34.678" },
    { subject: "Science", marks: "12", timestamp: "2024-07-13 12:01:34.678" },
    { subject: "Science", marks: "12", timestamp: "2024-07-11 12:01:34.678" },
    { subject: "Science", marks: "15", timestamp: "2024-07-12 12:01:34.678" },
    { subject: "Science", marks: "11", timestamp: "2024-07-12 12:01:34.678" },
    { subject: "Science", marks: "9", timestamp: "2024-07-12 12:01:34.678" },
    { subject: "Science", marks: "91", timestamp: "2024-07-12 12:01:34.678" },
    { subject: "Science", marks: "91", timestamp: "2024-07-19 12:01:34.678" }
  ])
  Result.all.collect{|result| result.timestamp.to_date.to_s}.uniq.each do |date|
    @daily_aggregator = Aggregators::Daily.new(date)
    @daily_aggregator.calculate
  end
end

And('Run Aggregators::Monthly calculator') do 
  @monthly_aggregator = Aggregators::Monthly.new("2024-07-15")
  @monthly_aggregator.calculate
end

Then('It should match monthly_avg_low monthly_avg_high monthly_result_count_used') do 
  @monthly_average =  MonthlyAverage.last
  @monthly_average.monthly_avg_low == 28.0 &&
  @monthly_average.monthly_avg_high == 45.4 &&
  @monthly_average.monthly_result_count_used == 9
end

Then('It should not raise duplicate row error for month') do 
  @daily_aggregator.error_message.include?('Date has already been taken')
end


And('Run DailyResultAggregatorJob') do 
  DailyResultAggregatorJob.perform_now
end

Then('It should not create month data') do 
  puts "did not create MonthlyAverage because today's date is not comes under criteria"
  MonthlyAverage.count == 0
end

