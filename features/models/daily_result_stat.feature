Feature: Result

    Scenario: Creating Daily Result Stat
      When I create a new Daily Result Stat
        | date | subject | daily_low | daily_high | result_count |
        | 2022-04-15| Science | 12 | 88 | 220 |

      Then I should have stored the Daily Result Stat
        | date | subject | daily_low | daily_high | result_count |
        | 2022-04-15| Science | 12 | 88 | 220 |
