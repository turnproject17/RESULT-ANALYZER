Feature: Result

    Scenario: Creating result data
      When I create a new result data
        | subject | Science |
        | marks | 90 | 
        | timestamp | 2022-04-15 12:01:34.678 |
      Then I should have stored the result data
        | subject | Science |
        | marks | 90 | 
        | timestamp | 2022-04-15 12:01:34.678 |
