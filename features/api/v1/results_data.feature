Feature: ResultsData API

    Scenario: Creating Daily Result Stat Api
      When I send a POST request to results_data api with the following:
        | subject | Science |
        | marks | 90 | 
        | timestamp | 2022-04-15 12:01:34.678 |

      Then the response status should be ok
