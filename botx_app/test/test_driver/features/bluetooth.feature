Feature: bluetooth

  Scenario: Should be turned on
    Given a user that has a ticket
    When the user logs in
    Then the user is required to turn on the bluetooth