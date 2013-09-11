Feature: print game info

  Print only information about the game without printing kifu.

  @wip
  Scenario: print basic game info
    Given application is not run yet
    When I run `kifu info spec/fixtures/show_simple_info.sgf`
    Then the output should contain:
    """
    Yasui Chitetsu vs Honinbo Dosaku
    --------------------------------

    Hikaru no Go chap 001, manga only

    White: Yasui Chitetsu (n/a)
    Black: Honinbo Dosaku (n/a)
    White wins by 4 points
    """
