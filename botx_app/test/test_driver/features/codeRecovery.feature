Feature:codeRecovery

    Scenario: The user should receive an email
        Given a user that has bought a ticket
        When i forget my code
        Then i receive an email with my code
