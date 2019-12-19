Feature:login

    Scenario: The user should be logged in
        Given a user with a ticket
        When the user tries to access the app
        Then the user is required to insert the code
        And the user should be redirected to the beacon interaction screen