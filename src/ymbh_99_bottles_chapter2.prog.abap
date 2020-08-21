REPORT ymbh_99_bottles_chapter2.

CLASS lcl_99_bottles DEFINITION FINAL.

  PUBLIC SECTION.

    METHODS song
      RETURNING
        VALUE(song) TYPE stringtab.

    METHODS verses
      IMPORTING
        start_verse   TYPE i
        end_verse     TYPE i
      RETURNING
        VALUE(verses) TYPE stringtab.

    METHODS verse
      IMPORTING
        verse_number TYPE i
      RETURNING
        VALUE(verse) TYPE stringtab.

ENDCLASS.

CLASS lcl_99_bottles IMPLEMENTATION.

  METHOD song.
    song = verses( start_verse = 99
                   end_verse   = 0 ).
  ENDMETHOD.

  METHOD verses.
    DATA(counter) = start_verse.
    WHILE counter >= end_verse.
      APPEND LINES OF verse( counter ) TO verses.
      counter = counter - 1.
    ENDWHILE.
  ENDMETHOD.

  METHOD verse.
    verse = SWITCH #( verse_number
                        WHEN 0 THEN VALUE stringtab( ( |No more bottles of beer on the wall, no more bottles of beer.| )
                                                     ( |Go to the store and buy some more, 99 bottles of beer on the wall.| ) )
                        WHEN 1 THEN VALUE stringtab( ( |1 bottle of beer on the wall, 1 bottle of beer.| )
                                                     ( |Take it down and pass it around, no more bottles of beer on the wall.| ) )
                        WHEN 2 THEN VALUE stringtab( ( |2 bottles of beer on the wall, 2 bottles of beer.| )
                                                     ( |Take one down and pass it around, 1 bottle of beer on the wall.| ) )
                        ELSE VALUE stringtab( ( |{ verse_number } bottles of beer on the wall, { verse_number } bottles of beer.| )
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
    METHODS verse_1         FOR TESTING.
    METHODS verse_0         FOR TESTING.
    METHODS a_couple_verses FOR TESTING.
    METHODS a_few_verses    FOR TESTING.

ENDCLASS.


CLASS ltc_99_bottles IMPLEMENTATION.

  METHOD the_first_verse.
    cl_abap_unit_assert=>assert_equals(
        exp = VALUE stringtab( ( |99 bottles of beer on the wall, 99 bottles of beer.| )
                               ( |Take one down and pass it around, 98 bottles of beer on the wall.| ) )
        act = NEW lcl_99_bottles( )->verse( 99 ) ).
  ENDMETHOD.

  METHOD another_verse.
    cl_abap_unit_assert=>assert_equals(
           exp = VALUE stringtab( ( |3 bottles of beer on the wall, 3 bottles of beer.| )
                                  ( |Take one down and pass it around, 2 bottles of beer on the wall.| ) )
           act = NEW lcl_99_bottles( )->verse( 3 ) ).
  ENDMETHOD.

  METHOD verse_2.
    cl_abap_unit_assert=>assert_equals(
               exp = VALUE stringtab( ( |2 bottles of beer on the wall, 2 bottles of beer.| )
                                      ( |Take one down and pass it around, 1 bottle of beer on the wall.| ) )
               act = NEW lcl_99_bottles( )->verse( 2 ) ).
  ENDMETHOD.

  METHOD verse_1.
    cl_abap_unit_assert=>assert_equals(
            exp = VALUE stringtab( ( |1 bottle of beer on the wall, 1 bottle of beer.| )
                                   ( |Take it down and pass it around, no more bottles of beer on the wall.| ) )
            act = NEW lcl_99_bottles( )->verse( 1 ) ).
  ENDMETHOD.

  METHOD verse_0.
    cl_abap_unit_assert=>assert_equals(
            exp = VALUE stringtab( ( |No more bottles of beer on the wall, no more bottles of beer.| )
                                   ( |Go to the store and buy some more, 99 bottles of beer on the wall.| ) )
            act = NEW lcl_99_bottles( )->verse( 0 ) ).
  ENDMETHOD.

  METHOD a_couple_verses.
    cl_abap_unit_assert=>assert_equals(
        exp = VALUE stringtab( ( |99 bottles of beer on the wall, 99 bottles of beer.| )
                               ( |Take one down and pass it around, 98 bottles of beer on the wall.| )
                               ( |98 bottles of beer on the wall, 98 bottles of beer.| )
                               ( |Take one down and pass it around, 97 bottles of beer on the wall.| ) )
        act = NEW lcl_99_bottles( )->verses( start_verse = 99
                                             end_verse   = 98 ) ).
  ENDMETHOD.

  METHOD a_few_verses.
    cl_abap_unit_assert=>assert_equals(
       exp = VALUE stringtab( ( |2 bottles of beer on the wall, 2 bottles of beer.| )
                              ( |Take one down and pass it around, 1 bottle of beer on the wall.| )
                              ( |1 bottle of beer on the wall, 1 bottle of beer.| )
                              ( |Take it down and pass it around, no more bottles of beer on the wall.| )
                              ( |No more bottles of beer on the wall, no more bottles of beer.| )
                              ( |Go to the store and buy some more, 99 bottles of beer on the wall.| ) )
       act = NEW lcl_99_bottles( )->verses( start_verse = 2
                                            end_verse   = 0 ) ).
  ENDMETHOD.

ENDCLASS.
