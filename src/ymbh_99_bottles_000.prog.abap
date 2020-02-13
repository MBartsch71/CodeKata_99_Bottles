REPORT ymbh_99_bottles_000.

CLASS lcl_bottles DEFINITION FINAL.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_amount TYPE i.

    METHODS build_lines
      IMPORTING
        iv_count        TYPE i OPTIONAL
      RETURNING
        VALUE(rt_lines) TYPE stringtab.

    METHODS build_refill_line
      IMPORTING
        iv_counter     TYPE i
      RETURNING
        VALUE(rv_line) TYPE string.

  PRIVATE SECTION.

    DATA mv_amount  TYPE i.
    DATA mv_counter TYPE i.

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

ENDCLASS.

CLASS lcl_bottles IMPLEMENTATION.

  METHOD constructor.
    mv_amount = iv_amount.
  ENDMETHOD.

  METHOD build_beer_bottle_line.
    MESSAGE i001(ymbh_99_bottles) WITH convert_counter( iv_counter )
                                       verify_plural( iv_counter )
                                  INTO rv_line.
  ENDMETHOD.

  METHOD build_take_down_line.
    MESSAGE i002(ymbh_99_bottles) WITH convert_counter( iv_counter )
                                       verify_plural( iv_counter )
                                  INTO rv_line.
  ENDMETHOD.

  METHOD build_refill_line.
    MESSAGE i003(ymbh_99_bottles) WITH convert_counter( iv_counter )
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

  METHOD build_lines.

    IF iv_count < mv_amount.
      rt_lines = build_lines( iv_count + 1 ).
    ENDIF.

    IF iv_count > 0.
      rt_lines = VALUE stringtab( BASE rt_lines ( build_beer_bottle_line( iv_count ) )
                                                ( build_take_down_line( iv_count - 1 ) ) ).
    ELSE.
      rt_lines = value #( base rt_lines ( build_beer_bottle_line( mv_counter ) )
                                        ( build_refill_line( mv_amount ) ) ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS ltc_99_bottles DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA mo_cut TYPE REF TO lcl_bottles.

    METHODS setup.
    METHODS build_2_lines_from_3_bottles   FOR TESTING.

ENDCLASS.

CLASS ltc_99_bottles IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( 3 ).
  ENDMETHOD.

  METHOD build_2_lines_from_3_bottles.
    DATA(lt_check_table) = VALUE stringtab( ( |3 bottles of beer on the wall. 3 bottles of beer.| )
                                            ( |Take one down and pass it around. 2 bottles of beer on the wall.| )
                                            ( |2 bottles of beer on the wall. 2 bottles of beer.| )
                                            ( |Take one down and pass it around. 1 bottle of beer on the wall.| )
                                            ( |1 bottle of beer on the wall. 1 bottle of beer.| )
                                            ( |Take one down and pass it around. No more bottles of beer on the wall.| )
                                            ( |No more bottles of beer on the wall. No more bottles of beer.| )
                                            ( |Go to the store and buy some more. 3 bottles of beer on the wall.| ) ).
    cl_abap_unit_assert=>assert_equals(
        msg = 'The returned table should match the check table'
        exp = lt_check_table
        act = mo_cut->build_lines( ) ).
  ENDMETHOD.

ENDCLASS.
