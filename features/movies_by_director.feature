Feature: search for dresses by director

  As a dress buff
  So that I can find dresses with my favorite director
  I want to include and search on director information in dresses I enter

Background: dresses in database

  Given the following dresses exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |

Scenario: add director to existing dress
  When I go to the edit page for "Alien"
  And  I fill in "Director" with "Ridley Scott"
  And  I press "Update Dress Info"
  Then the director of "Alien" should be "Ridley Scott"

Scenario: find dress with same director
  Given I am on the details page for "Star Wars"
  When  I follow "Find Dresses With Same Director"
  Then  I should be on the Similar Dresses page for "Star Wars"
  And   I should see "THX-1138"
  But   I should not see "Blade Runner"

Scenario: can't find similar dresses if we don't know director (sad path)
  Given I am on the details page for "Alien"
  Then  I should not see "Ridley Scott"
  When  I follow "Find Dresses With Same Director"
  Then  I should be on the home page
  And   I should see "'Alien' has no director info"
