Feature: Search Hotels

  Background:
    Given I navigate to TUI home page
    And I click on allow cookies button

  Scenario Outline: Verify that user landed on TUI site based on country selection
    When I select "<country>" from the location
    Then I verify that user is redirected to respective "<country>" site
    And I verify that default search page is displayed
    Examples:
      | country  |
      | Espain   |
      | Portugal |
      | Brasil   |

  Scenario: Verify that user able to filter hotels based on the query parameter
    When I select "Espain" from the location
    And I enter destination as "Roma" in search field
    When I select the location from the suggestion list
    And I collect the current date
    When I select future date range one month from the current date
    And I click on pax icon
    When I select "3 adults" from the pax
    And I select "1 childs" from the pax
    When I select child age
    When I click on apply button from pax selection
    And I click on search button
    And I verify that hotels listed for the selected date and pax range
    When I click on reservation button on the first hotel
    And I switch to the "child" tab
    Then I verify that selected hotel reservation page opened
    And I verify the price displayed for the selected hotel
