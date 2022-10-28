Feature: sign up for a user

  As a new user for our website, (s)he wants to sign up

Background:

  Given the following users exist:
  | user_name    | password    |
  | alice        | abcdes78890 |

Scenario: Sign up for a new user
  When I go to the home page
  And I follow "SignUp"
  Then I should be on the signup page
  And I fill in "Username" with "bob_brown"
  And I fill in "Password" with "jk9472he"
  And I press "Sign up"
  Then I should be on the signin page
  And I should see "Sign up success."

Scenario: Sign up for an existing user
  When I go to the home page
  And I follow "SignUp"
  Then I should be on the signup page
  And I fill in "Username" with "alice"
  And I fill in "Password" with "jk9472he"
  And I press "Sign up"
  Then I should be on the signup page
  And I should see "Username exists."
