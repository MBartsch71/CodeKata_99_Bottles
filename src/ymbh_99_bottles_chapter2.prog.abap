REPORT ymbh_99_bottles_chapter2.

CLASS lcl_99_bottles DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS verse
      IMPORTING
        verse_number TYPE i
      RETURNING
        VALUE(verse) TYPE stringtab.

ENDCLASS.

CLASS lcl_99_bottles IMPLEMENTATION.

  METHOD verse.
    verse = COND #( WHEN verse_number = 2
                         THEN VALUE stringtab( ( |2 bottles of beer on the wall, 2 bottles of beer| )
                                               ( |Take one down and pass it around, 1 bottle of beer on the wall.| ) )
                    ELSE VALUE stringtab( ( |{ verse_number } bottles of beer on the wall, { verse_number } bottles of beer| )
                                          ( |Take one down and pass it around, { verse_number - 1 } bottles of beer on the wall.| )  ) ).
  ENDMETHOD.
ENDCLASS.



CLASS ltc_99_bottles DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS the_first_verse FOR TESTING.
    METHODS another_verse   FOR TESTING.
    METHODS verse_2         FOR TESTING.

ENDCLASS.


CLASS ltc_99_bottles IMPLEMENTATION.

  METHOD the_first_verse.
    cl_abap_unit_assert=>assert_equals(
        exp = VALUE stringtab( ( |99 bottles of beer on the wall, 99 bottles of beer| )
                               ( |Take one down and pass it around, 98 bottles of beer on the wall.| ) )
        act = NEW lcl_99_bottles( )->verse( 99 ) ).
  ENDMETHOD.

  METHOD another_verse.
    cl_abap_unit_assert=>assert_equals(
           exp = VALUE stringtab( ( |3 bottles of beer on the wall, 3 bottles of beer| )
                                  ( |Take one down and pass it around, 2 bottles of beer on the wall.| ) )
           act = NEW lcl_99_bottles( )->verse( 3 ) ).
  ENDMETHOD.

  METHOD verse_2.
    cl_abap_unit_assert=>assert_equals(
               exp = VALUE stringtab( ( |2 bottles of beer on the wall, 2 bottles of beer| )
                                      ( |Take one down and pass it around, 1 bottle of beer on the wall.| ) )
               act = NEW lcl_99_bottles( )->verse( 2 ) ).
  ENDMETHOD.

ENDCLASS.
