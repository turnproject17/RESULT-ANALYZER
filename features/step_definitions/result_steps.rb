When('I create a new result data') do |table|
  hash_data = table.rows_hash
  @result = Result.create(hash_data)
end

Then('I should have stored the result data') do |data|
  hash_data = data.rows_hash
  @result = Result.last
  @result.subject == hash_data[:subject] &&
  @result.marks == hash_data[:marks] 
end


When('I send a POST request to results_data api with the following:') do |table|
  page.driver.post('/api/v1/results_data', {result_data: table.rows_hash})
end

Then('the response status should be ok') do
  page.status_code == 200
end
