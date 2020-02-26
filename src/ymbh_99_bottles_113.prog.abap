REPORT ymbh_99_bottles_113.

CLASS lcl_round DEFINITION.
  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_bottles TYPE i.

    METHODS to_s
      RETURNING
        VALUE(rt_lines) TYPE stringtab.

    METHODS challenge
      RETURNING
        VALUE(rv_line) TYPE string.

    METHODS response
      RETURNING
        VALUE(rv_line) TYPE string.

  PRIVATE SECTION.
    DATA mv_bottles TYPE i.
    METHODS bottles_of_beer
      RETURNING
        VALUE(rv_line) TYPE string.
    METHODS on_wall
      RETURNING
        VALUE(rv_line) TYPE string.
    METHODS pluralized_bottle_form
      RETURNING
        VALUE(rv_expression) TYPE string.
    METHODS beer
      RETURNING
        VALUE(rv_expression) TYPE string.
    METHODS last_beer
      RETURNING
        VALUE(rv_result) TYPE abap_bool.
    METHODS anglicized_bottle_count
      RETURNING
        VALUE(rv_expression) TYPE string.
    METHODS all_out
      RETURNING
        VALUE(rv_result) TYPE abap_bool.
    METHODS go_to_the_store_or_take_1_down
      RETURNING
        VALUE(rv_line) TYPE string.
    METHODS buy_new_beer
      RETURNING
        VALUE(rv_expression) TYPE string.
    METHODS drink_beer
      RETURNING
        VALUE(rv_expression) TYPE string.
    METHODS it_or_one
      RETURNING
        VALUE(rv_expression) TYPE string.

ENDCLASS.

CLASS lcl_round IMPLEMENTATION.

  METHOD constructor.
    mv_bottles = iv_bottles.
  ENDMETHOD.

  METHOD to_s.
    rt_lines = VALUE #( ( challenge( ) )
                        ( response( ) ) ).
  ENDMETHOD.

  METHOD challenge.
    rv_line = |{ bottles_of_beer( ) } { on_wall( ) }, { bottles_of_beer( ) }.|.
  ENDMETHOD.

  METHOD response.
    rv_line = |{ go_to_the_store_or_take_1_down( ) }, { bottles_of_beer( ) } { on_wall( ) }.|.
  ENDMETHOD.

  METHOD bottles_of_beer.
    rv_line = |{ anglicized_bottle_count( ) } { pluralized_bottle_form( ) } of { beer( ) }|.
  ENDMETHOD.

  METHOD beer.
    rv_expression = |beer|.
  ENDMETHOD.

  METHOD on_wall.
    rv_line = |on the wall|.
  ENDMETHOD.

  METHOD pluralized_bottle_form.
    rv_expression = SWITCH #( last_beer( ) WHEN abap_true THEN |bottle|
                                           ELSE |bottles| ).
  ENDMETHOD.

  METHOD anglicized_bottle_count.
    rv_expression = SWITCH #( all_out( ) WHEN abap_true THEN |No more|
                                         ELSE mv_bottles ).
  ENDMETHOD.

  METHOD go_to_the_store_or_take_1_down.
    rv_line = SWITCH #( all_out( ) WHEN abap_true THEN buy_new_beer( )
                                   ELSE drink_beer( ) ).
  ENDMETHOD.

  METHOD buy_new_beer.
    mv_bottles = 99.
    rv_expression = |Go to the store and buy some more|.
  ENDMETHOD.

  METHOD drink_beer.
    rv_expression = |Take { it_or_one( ) } down and pass it around|.
    mv_bottles = mv_bottles - 1.
  ENDMETHOD.

  METHOD it_or_one.
    rv_expression = SWITCH #( last_beer( ) WHEN abap_true THEN |it|
                                           ELSE |one| ).
  ENDMETHOD.

  METHOD all_out.
    rv_result = SWITCH #( mv_bottles WHEN 0 THEN abap_true
                                     ELSE abap_false ).
  ENDMETHOD.

  METHOD last_beer.
    rv_result = SWITCH #( mv_bottles WHEN 1 THEN abap_true
                                     ELSE abap_false ).
  ENDMETHOD.

ENDCLASS.

CLASS lcl_bottles DEFINITION.

  PUBLIC SECTION.
    METHODS song
      RETURNING
        VALUE(rt_song) TYPE stringtab.

    METHODS verses
      IMPORTING
        iv_bottles_at_start TYPE i
        iv_bottles_at_end   TYPE i
      RETURNING
        VALUE(rt_lines)     TYPE stringtab.

    METHODS verse
      IMPORTING
        iv_bottles      TYPE i
      RETURNING
        VALUE(rt_lines) TYPE stringtab.

ENDCLASS.

CLASS lcl_bottles IMPLEMENTATION.

  METHOD song.
    rt_song = verses( iv_bottles_at_start = 99
                      iv_bottles_at_end   = 0 ).
  ENDMETHOD.

  METHOD verses.
    DATA(lv_bottles) = iv_bottles_at_start.
    WHILE lv_bottles >= iv_bottles_at_end.
      APPEND LINES OF verse( lv_bottles ) TO rt_lines.
      lv_bottles = lv_bottles - 1.
    ENDWHILE.
  ENDMETHOD.

  METHOD verse.
    DATA(lo_round) = NEW lcl_round( iv_bottles ).
    rt_lines = lo_round->to_s( ).
  ENDMETHOD.

ENDCLASS.

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    METHODS run.
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.

  METHOD run.
    DATA(lo_bottles) = NEW lcl_bottles( ).
    cl_demo_output=>display( lo_bottles->song( ) ).
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  DATA(lo_main) = NEW lcl_main( ).
  lo_main->run( ).
