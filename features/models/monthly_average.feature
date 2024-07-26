Feature: Result

    Scenario: Creating Daily Result Stat
      When I create a new Monthly Average
        | date | subject | monthly_avg_low | monthly_avg_high | monthly_result_count_used | total |
        | 2022-04-15| Science | 12 | 88 | 19 | 890 |

      Then It should have stored the MonthlyAverage
        | date | subject | monthly_avg_low | monthly_avg_high | monthly_result_count_used | total |
        | 2022-04-15| Science | 12 | 88 | 19 | 890 |