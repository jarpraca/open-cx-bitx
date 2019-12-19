Feature: notification

    Scenario: The user should receive a notification
        Given a logged in user
        When the user gets automatically checked-in
        Then the user is notified