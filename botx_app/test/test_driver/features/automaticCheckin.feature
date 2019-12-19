Feature: automaticCheckin

  Scenario: Should be checked in
    Given a logged in user
    When the user arrives at FEUP (the beacon is detected)
    Then the user is automatically checked-in