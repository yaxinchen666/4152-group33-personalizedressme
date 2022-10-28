Feature: sign in and log out of user

  As a user
  So that I can manage my account
  I want to sign in and log out

Background: users in database

  Given the following users exist:
  | user_name | password |
  | test_a    | a1       |
  | test_b    | b2       |

Scenario: sign in
  When I go to the home page
  And I follow "SignIn"
  Then I should be on the signin page
  And I fill in "Username" with "test_a"
  And I fill in "Password" with "a1"
  And I press "Sign in"
  Then I should be on the home page
  And I should see "test_a"

Scenario: fail to sign in
  When I go to the signin page
  And I fill in "Username" with "test_b"
  And I fill in "Password" with "aaaa"
  And I press "Sign in"
  Then I should see "Incorrect username or password"

Scenario: sign in and log out
  When I go to the signin page
  And I fill in "Username" with "test_a"
  And I fill in "Password" with "a1"
  And I press "Sign in"
  Then I should be on the home page
  When I follow "test_a"
  Then I should be on the profile page
  When I press "Log out"
  Then I should be on the home page
  And I should see "SignIn"

Scenario: turn to sign up when signing in
  When I go to the signin page
  And I follow "Sign up"
  Then I should be on signup page
