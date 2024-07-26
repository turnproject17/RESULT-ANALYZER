When('I create a new Daily Result Stat') do |table|
  hash_data = table.hashes
  @result = DailyResultStat.create(hash_data)
end

Then('I should have stored the Daily Result Stat') do |data|
  hash_data = data.hashes.first
  @result = DailyResultStat.last

  @result.daily_low == hash_data[:daily_low].to_f &&
  @result.daily_high == hash_data[:daily_high] .to_f
end


When('Setup result data') do 
  @results = Result.create([
    { subject: "Science", marks: "90", timestamp: "2024-07-15 12:01:34.678" }, 
    { subject: "Science", marks: "95", timestamp: "2024-07-15 12:01:34.678" }
  ])
end

And('Run Aggregators::Daily calculator') do 
  @daily_aggregator = Aggregators::Daily.new("2024-07-15")
  @daily_aggregator.calculate
end

Then('It should have stored the Daily Result Stat') do 
  @daily_aggregator.error_message == " "
end

Then('It should have daily_high daily_low result_count as per expectation') do 
  @daily_result_stat =  DailyResultStat.last
  @daily_result_stat.daily_low == 90.0 &&
  @daily_result_stat.daily_high == 95.0 &&
  @daily_result_stat.result_count == 2
end

Then('It should not raise duplicate row error') do 
  @daily_aggregator.error_message.include?('Date has already been taken')
end
