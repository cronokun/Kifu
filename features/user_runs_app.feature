Feature: user runs application

  As a go player
  I want to run application
  So that it could print a kifu for me

  Scenario: run application w/o arguments
    Given application is not run yet
    When I run `kifu`
    Then the output should contain "Usage: kifu command [arguments...] [options...]"
