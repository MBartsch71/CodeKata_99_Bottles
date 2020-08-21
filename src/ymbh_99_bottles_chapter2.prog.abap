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
    verse = value stringtab( ( |99 bottles of beer on the wall, 99 bottles of beer| )
                             ( |Take one down and pass it around, 98 bottles of beer on the wall.| ) ).
  ENDMETHOD.

ENDCLASS.



CLASS ltc_99_bottles DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS the_first_verse FOR TESTING.

ENDCLASS.


CLASS ltc_99_bottles IMPLEMENTATION.


  METHOD the_first_verse.
    cl_abap_unit_assert=>assert_equals(
        exp = VALUE stringtab( ( |99 bottles of beer on the wall, 99 bottles of beer| )
                               ( |Take one down and pass it around, 98 bottles of beer on the wall.| ) )
        act = NEW lcl_99_bottles( )->verse( 99 ) ).
  ENDMETHOD.

ENDCLASS.
