# RESULT-ANALYZER

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  '2.5.7'
* Rails version
  '6.0.6'

* System dependencies

* Configuration

* Database creation
  **rails db:create**
* Database initialization
  **rails db:migrate**
* How to run the test suite
  **cucumber**
* Services (job queues, cache servers, search engines, etc.)
  **DailyResultAggregatorJob** # for daily aggregator
* Reesult data Api
  * endpoint: /api/v1/results_data
  *** parameter:  {
    "result_data": {
        "subject": "Science",
        "timestamp": "2022-04-15 12:01:34.678",
        "marks": 123
    }
}  **
* Deployment instructions

* ...
# RESULT-ANALYZER
