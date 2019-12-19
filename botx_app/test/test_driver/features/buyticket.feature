Feature: buyTicket

    Scenario: The event page should open
        Given a user that does not have a ticket
        When the user opens the app
        Then the user can access the registration link through the app