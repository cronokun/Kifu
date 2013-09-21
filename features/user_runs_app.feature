Feature: user runs application

  As a go player
  I want to run application
  So that it could print a kifu for me

  Scenario: run application w/o arguments
    Given application is not run yet
    When I run `kifu`
    Then the output should contain:
    """
    Read a Go game from SGF file and print the kifu record as ASCII text, HTML or PDF file.

    Commands:
      kifu help       # show some help
      kifu info FILE  # print basic game info
    """
