REPORT ymbh_99_bottles_000.

CLASS lcl_bottles DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS build_beer_bottle_line
      IMPORTING
        iv_counter     TYPE i
      RETURNING
        VALUE(rv_line) TYPE string.

    METHODS build_take_down_line
      IMPORTING
        iv_counter     TYPE i
      RETURNING
        VALUE(rv_line) TYPE string.


  PRIVATE SECTION.
    METHODS convert_counter
      IMPORTING
        iv_counter        TYPE i
      RETURNING
        VALUE(rv_counter) TYPE string.
    METHODS verify_plural
      IMPORTING
        iv_counter       TYPE i
      RETURNING
        VALUE(rv_plural) TYPE text1.

ENDCLASS.

CLASS lcl_bottles IMPLEMENTATION.

  METHOD build_beer_bottle_line.
    MESSAGE i001(ymbh_99_bottles) WITH convert_Counter( iv_counter )
                                       verify_plural( iv_counter )
                                  INTO rv_line.
  ENDMETHOD.

  METHOD build_take_down_line.
    MESSAGE i002(ymbh_99_bottles) WITH convert_counter( iv_counter )
                                       verify_plural( iv_counter )
                                  INTO rv_line.
  ENDMETHOD.

  METHOD convert_counter.
    rv_counter = SWITCH #( iv_counter WHEN 0 THEN |No more|
                                      ELSE iv_counter ).
  ENDMETHOD.

  METHOD verify_plural.
    rv_plural = SWITCH #( iv_counter WHEN 1 THEN ''
                                     ELSE 's' ).
  ENDMETHOD.

ENDCLASS.


CLASS ltc_99_bottles DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS build_plural_line_with_counter FOR TESTING.
    METHODS build_take_down_line_normal    FOR TESTING.
    METHODS build_take_down_line_for_1     FOR TESTING.
    METHODS build_singular_line_with_count FOR TESTING.

ENDCLASS.


CLASS ltc_99_bottles IMPLEMENTATION.

  METHOD build_plural_line_with_counter.
    DATA(lo_cut) = NEW lcl_bottles( ).
    cl_abap_unit_assert=>assert_equals(
        msg = 'The returned line should match the expected line.'
        exp = |15 bottles of beer on the wall. 15 bottles of beer.|
        act = lo_cut->build_beer_bottle_line( 15 ) ).
  ENDMETHOD.

  METHOD build_take_down_line_normal.
    DATA(lo_cut) = NEW lcl_bottles( ).
    cl_abap_unit_assert=>assert_equals(
        msg = 'The returned line should match the expected line.'
        exp = |Take one down and pass it around. 14 bottles of beer.|
        act = lo_cut->build_take_down_line( 14 ) ).
  ENDMETHOD.

  METHOD build_singular_line_with_count.
    DATA(lo_cut) = NEW lcl_bottles( ).
    cl_abap_unit_assert=>assert_equals(
        msg = 'The returned line should match the expected line.'
        exp = |1 bottle of beer on the wall. 1 bottle of beer.|
        act = lo_cut->build_beer_bottle_line( 1 ) ).
  ENDMETHOD.

  METHOD build_take_down_line_for_1.
    DATA(lo_cut) = NEW lcl_bottles( ).
    cl_abap_unit_assert=>assert_equals(
        msg = 'The returned line should match the expected line.'
        exp = |Take one down and pass it around. No more bottles of beer.|
        act = lo_cut->build_take_down_line( 0 ) ).
  ENDMETHOD.

ENDCLASS.
