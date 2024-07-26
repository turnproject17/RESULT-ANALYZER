Feature: Aggregators::Monthly

  Scenario: Generate Monthly Result validate data
    When Setup result data for month
    And Run Aggregators::Monthly calculator
    Then It should match monthly_avg_low monthly_avg_high monthly_result_count_used
  
  Scenario: Validation on Generate Monthly Average multiple
    When Setup result data for month
    And Run Aggregators::Monthly calculator
    And Run Aggregators::Monthly calculator
    Then It should not raise duplicate row error for month
  
  Scenario: Not Run monthly aggregator if Monday of week of third Wednesday
    When Setup result data for month
    And Run DailyResultAggregatorJob
    Then It should not create month data
  