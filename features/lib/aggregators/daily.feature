Feature: Aggregators::Daily

  Scenario: Generate Daily Result Stat and validate data
    When Setup result data
    And Run Aggregators::Daily calculator
    Then It should have daily_high daily_low result_count as per expectation
      
  Scenario: Validation on Generate Daily Result Stat multiple
    When Setup result data
    And Run Aggregators::Daily calculator
    And Run Aggregators::Daily calculator
    Then It should not raise duplicate row error
      