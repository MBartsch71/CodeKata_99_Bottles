REPORT ymbh_99_bottles_chapter9.

INTERFACE verse_template.
  METHODS lyrics
    RETURNING
      VALUE(lyrics) TYPE stringtab.
ENDINTERFACE.

CLASS lcl_bottle_number DEFINITION.
  PUBLIC SECTION.
    DATA number TYPE i.

    CLASS-METHODS for
      IMPORTING
        number               TYPE i
      RETURNING
        VALUE(bottle_number) TYPE REF TO lcl_bottle_number.

    METHODS constructor
      IMPORTING
        number TYPE i.

    METHODS container
      RETURNING
        VALUE(container) TYPE string.

    METHODS pronoun
      RETURNING
        VALUE(pronoun) TYPE string.

    METHODS quantity
      RETURNING
        VALUE(quantity) TYPE string.

    METHODS action
      RETURNING
        VALUE(action) TYPE string.

    METHODS successor
      RETURNING
        VALUE(bottle_number) TYPE REF TO lcl_bottle_number.

    METHODS to_string
      RETURNING
        VALUE(string) TYPE string.


ENDCLASS.

CLASS lcl_bottle_number_0 DEFINITION
                          INHERITING FROM lcl_bottle_number.
  PUBLIC SECTION.
    METHODS quantity  REDEFINITION.
    METHODS action    REDEFINITION.
    METHODS successor REDEFINITION.

ENDCLASS.

CLASS lcl_bottle_number_1 DEFINITION
                          INHERITING FROM lcl_bottle_number.
  PUBLIC SECTION.
    METHODS container REDEFINITION.
    METHODS pronoun   REDEFINITION.
ENDCLASS.

CLASS lcl_bottle_number_6 DEFINITION
                          INHERITING FROM lcl_bottle_number.
  PUBLIC SECTION.
    METHODS quantity REDEFINITION.
    METHODS container REDEFINITION.
ENDCLASS.


CLASS lcl_bottle_number IMPLEMENTATION.

  METHOD constructor.
    me->number = number.
  ENDMETHOD.

  METHOD action.
    action = |Take { pronoun( ) } down and pass it around,|.
  ENDMETHOD.

  METHOD container.
    container = |bottles|.
  ENDMETHOD.

  METHOD pronoun.
    pronoun = |one|.
  ENDMETHOD.

  METHOD quantity.
    quantity = condense( CONV string( me->number ) ).
  ENDMETHOD.

  METHOD successor.
    bottle_number = lcl_bottle_number=>for( number - 1 ).
  ENDMETHOD.

  METHOD to_string.
    string = |{ quantity( ) } { container( ) }|.
  ENDMETHOD.

  METHOD for.
    bottle_number = SWITCH #( number WHEN 0 THEN NEW lcl_bottle_number_0( number )
                                     WHEN 1 THEN NEW lcl_bottle_number_1( number )
                                     WHEN 6 THEN NEW lcl_bottle_number_6( number )
                                     ELSE NEW lcl_bottle_number( number ) ).
  ENDMETHOD.

ENDCLASS.


CLASS lcl_bottle_number_0 IMPLEMENTATION.

  METHOD quantity.
    quantity = |no more|.
  ENDMETHOD.

  METHOD action.
    action = |Go to the store and buy some more,|.
  ENDMETHOD.

  METHOD successor.
    bottle_number = lcl_bottle_number=>for( 99 ).
  ENDMETHOD.

ENDCLASS.


CLASS lcl_bottle_number_1 IMPLEMENTATION.

  METHOD container.
    container = |bottle|.
  ENDMETHOD.

  METHOD pronoun.
    pronoun = |it|.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_bottle_number_6 IMPLEMENTATION.

  METHOD container.
    container = |six-pack|.
  ENDMETHOD.

  METHOD quantity.
    quantity = condense( CONV string( 1 ) ).
  ENDMETHOD.

ENDCLASS.


CLASS bottle_verse DEFINITION.
  PUBLIC SECTION.
    INTERFACES verse_template.

    CLASS-METHODS lyrics
      IMPORTING
        number               TYPE i
      RETURNING
        VALUE(bottle_number) TYPE stringtab.

    METHODS constructor
      IMPORTING
        bottle_number TYPE REF TO lcl_bottle_number.

  PRIVATE SECTION.
    DATA bottle_number TYPE REF TO lcl_bottle_number.

    METHODS capitalize
      IMPORTING
        input         TYPE string
      RETURNING
        VALUE(output) TYPE string.
ENDCLASS.

CLASS bottle_verse IMPLEMENTATION.

  METHOD lyrics.
    bottle_number = NEW bottle_verse( lcl_bottle_number=>for( number ) )->verse_template~lyrics( ).
  ENDMETHOD.

  METHOD constructor.
    me->bottle_number = bottle_number.
  ENDMETHOD.

  METHOD verse_template~lyrics.
*    DATA(bottle_number) = lcl_bottle_number=>for( me->number ).

    lyrics = VALUE stringtab( ( |{ capitalize( bottle_number->to_string( ) ) } of beer on the wall, | &&
                               |{ bottle_number->to_string( ) } of beer.| )
                             ( |{ bottle_number->action( ) } | &&
                               |{ bottle_number->successor( )->to_string( ) } of beer on the wall.| ) ).
  ENDMETHOD.

  METHOD capitalize.
    DATA(first_char) = input(1).
    IF strlen( input ) > 1.
      DATA(rest) = substring( val = input off = 1 len = strlen( input ) - 1 ).
    ENDIF.
    output = |{ first_char CASE = UPPER }{ rest }|.
  ENDMETHOD.



ENDCLASS.


CLASS countdown_song DEFINITION FINAL.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        verse_template TYPE REF TO verse_template OPTIONAL.

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
        number       TYPE i
      RETURNING
        VALUE(verse) TYPE stringtab.

    METHODS capitalize
      IMPORTING
        input         TYPE string
      RETURNING
        VALUE(output) TYPE string.

  PRIVATE SECTION.
    DATA verse_template TYPE REF TO object.

ENDCLASS.

CLASS countdown_song IMPLEMENTATION.

  METHOD constructor.
    me->verse_template = COND #( WHEN verse_template IS BOUND THEN verse_template
                                 ELSE NEW bottle_verse( lcl_bottle_number=>for( 99 ) ) ).
  ENDMETHOD.

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
    verse = bottle_verse=>lyrics( number ).
  ENDMETHOD.

  METHOD capitalize.
    DATA(first_char) = input(1).
    IF strlen( input ) > 1.
      DATA(rest) = substring( val = input off = 1 len = strlen( input ) - 1 ).
    ENDIF.
    output = |{ first_char CASE = UPPER }{ rest }|.
  ENDMETHOD.

ENDCLASS.


CLASS ltc_99_bottles DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS a_couple_verses FOR TESTING.
    METHODS a_few_verses    FOR TESTING.
    METHODS the_whole_song  FOR TESTING.

ENDCLASS.


CLASS ltc_99_bottles IMPLEMENTATION.

  METHOD a_couple_verses.
    cl_abap_unit_assert=>assert_equals(
        exp = VALUE stringtab( ( |99 bottles of beer on the wall, 99 bottles of beer.| )
                               ( |Take one down and pass it around, 98 bottles of beer on the wall.| )
                               ( |98 bottles of beer on the wall, 98 bottles of beer.| )
                               ( |Take one down and pass it around, 97 bottles of beer on the wall.| ) )
        act = NEW countdown_song( )->verses( start_verse = 99
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
       act = NEW countdown_song( )->verses( start_verse = 2
                                            end_verse   = 0 ) ).
  ENDMETHOD.

  METHOD the_whole_song.
    cl_abap_unit_assert=>assert_equals(
       exp = VALUE stringtab( ( |99 bottles of beer on the wall, 99 bottles of beer.| ) ( |Take one down and pass it around, 98 bottles of beer on the wall.| )
                              ( |98 bottles of beer on the wall, 98 bottles of beer.| ) ( |Take one down and pass it around, 97 bottles of beer on the wall.| )
                              ( |97 bottles of beer on the wall, 97 bottles of beer.| ) ( |Take one down and pass it around, 96 bottles of beer on the wall.| )
                              ( |96 bottles of beer on the wall, 96 bottles of beer.| ) ( |Take one down and pass it around, 95 bottles of beer on the wall.| )
                              ( |95 bottles of beer on the wall, 95 bottles of beer.| ) ( |Take one down and pass it around, 94 bottles of beer on the wall.| )
                              ( |94 bottles of beer on the wall, 94 bottles of beer.| ) ( |Take one down and pass it around, 93 bottles of beer on the wall.| )
                              ( |93 bottles of beer on the wall, 93 bottles of beer.| ) ( |Take one down and pass it around, 92 bottles of beer on the wall.| )
                              ( |92 bottles of beer on the wall, 92 bottles of beer.| ) ( |Take one down and pass it around, 91 bottles of beer on the wall.| )
                              ( |91 bottles of beer on the wall, 91 bottles of beer.| ) ( |Take one down and pass it around, 90 bottles of beer on the wall.| )
                              ( |90 bottles of beer on the wall, 90 bottles of beer.| ) ( |Take one down and pass it around, 89 bottles of beer on the wall.| )
                              ( |89 bottles of beer on the wall, 89 bottles of beer.| ) ( |Take one down and pass it around, 88 bottles of beer on the wall.| )
                              ( |88 bottles of beer on the wall, 88 bottles of beer.| ) ( |Take one down and pass it around, 87 bottles of beer on the wall.| )
                              ( |87 bottles of beer on the wall, 87 bottles of beer.| ) ( |Take one down and pass it around, 86 bottles of beer on the wall.| )
                              ( |86 bottles of beer on the wall, 86 bottles of beer.| ) ( |Take one down and pass it around, 85 bottles of beer on the wall.| )
                              ( |85 bottles of beer on the wall, 85 bottles of beer.| ) ( |Take one down and pass it around, 84 bottles of beer on the wall.| )
                              ( |84 bottles of beer on the wall, 84 bottles of beer.| ) ( |Take one down and pass it around, 83 bottles of beer on the wall.| )
                              ( |83 bottles of beer on the wall, 83 bottles of beer.| ) ( |Take one down and pass it around, 82 bottles of beer on the wall.| )
                              ( |82 bottles of beer on the wall, 82 bottles of beer.| ) ( |Take one down and pass it around, 81 bottles of beer on the wall.| )
                              ( |81 bottles of beer on the wall, 81 bottles of beer.| ) ( |Take one down and pass it around, 80 bottles of beer on the wall.| )
                              ( |80 bottles of beer on the wall, 80 bottles of beer.| ) ( |Take one down and pass it around, 79 bottles of beer on the wall.| )
                              ( |79 bottles of beer on the wall, 79 bottles of beer.| ) ( |Take one down and pass it around, 78 bottles of beer on the wall.| )
                              ( |78 bottles of beer on the wall, 78 bottles of beer.| ) ( |Take one down and pass it around, 77 bottles of beer on the wall.| )
                              ( |77 bottles of beer on the wall, 77 bottles of beer.| ) ( |Take one down and pass it around, 76 bottles of beer on the wall.| )
                              ( |76 bottles of beer on the wall, 76 bottles of beer.| ) ( |Take one down and pass it around, 75 bottles of beer on the wall.| )
                              ( |75 bottles of beer on the wall, 75 bottles of beer.| ) ( |Take one down and pass it around, 74 bottles of beer on the wall.| )
                              ( |74 bottles of beer on the wall, 74 bottles of beer.| ) ( |Take one down and pass it around, 73 bottles of beer on the wall.| )
                              ( |73 bottles of beer on the wall, 73 bottles of beer.| ) ( |Take one down and pass it around, 72 bottles of beer on the wall.| )
                              ( |72 bottles of beer on the wall, 72 bottles of beer.| ) ( |Take one down and pass it around, 71 bottles of beer on the wall.| )
                              ( |71 bottles of beer on the wall, 71 bottles of beer.| ) ( |Take one down and pass it around, 70 bottles of beer on the wall.| )
                              ( |70 bottles of beer on the wall, 70 bottles of beer.| ) ( |Take one down and pass it around, 69 bottles of beer on the wall.| )
                              ( |69 bottles of beer on the wall, 69 bottles of beer.| ) ( |Take one down and pass it around, 68 bottles of beer on the wall.| )
                              ( |68 bottles of beer on the wall, 68 bottles of beer.| ) ( |Take one down and pass it around, 67 bottles of beer on the wall.| )
                              ( |67 bottles of beer on the wall, 67 bottles of beer.| ) ( |Take one down and pass it around, 66 bottles of beer on the wall.| )
                              ( |66 bottles of beer on the wall, 66 bottles of beer.| ) ( |Take one down and pass it around, 65 bottles of beer on the wall.| )
                              ( |65 bottles of beer on the wall, 65 bottles of beer.| ) ( |Take one down and pass it around, 64 bottles of beer on the wall.| )
                              ( |64 bottles of beer on the wall, 64 bottles of beer.| ) ( |Take one down and pass it around, 63 bottles of beer on the wall.| )
                              ( |63 bottles of beer on the wall, 63 bottles of beer.| ) ( |Take one down and pass it around, 62 bottles of beer on the wall.| )
                              ( |62 bottles of beer on the wall, 62 bottles of beer.| ) ( |Take one down and pass it around, 61 bottles of beer on the wall.| )
                              ( |61 bottles of beer on the wall, 61 bottles of beer.| ) ( |Take one down and pass it around, 60 bottles of beer on the wall.| )
                              ( |60 bottles of beer on the wall, 60 bottles of beer.| ) ( |Take one down and pass it around, 59 bottles of beer on the wall.| )
                              ( |59 bottles of beer on the wall, 59 bottles of beer.| ) ( |Take one down and pass it around, 58 bottles of beer on the wall.| )
                              ( |58 bottles of beer on the wall, 58 bottles of beer.| ) ( |Take one down and pass it around, 57 bottles of beer on the wall.| )
                              ( |57 bottles of beer on the wall, 57 bottles of beer.| ) ( |Take one down and pass it around, 56 bottles of beer on the wall.| )
                              ( |56 bottles of beer on the wall, 56 bottles of beer.| ) ( |Take one down and pass it around, 55 bottles of beer on the wall.| )
                              ( |55 bottles of beer on the wall, 55 bottles of beer.| ) ( |Take one down and pass it around, 54 bottles of beer on the wall.| )
                              ( |54 bottles of beer on the wall, 54 bottles of beer.| ) ( |Take one down and pass it around, 53 bottles of beer on the wall.| )
                              ( |53 bottles of beer on the wall, 53 bottles of beer.| ) ( |Take one down and pass it around, 52 bottles of beer on the wall.| )
                              ( |52 bottles of beer on the wall, 52 bottles of beer.| ) ( |Take one down and pass it around, 51 bottles of beer on the wall.| )
                              ( |51 bottles of beer on the wall, 51 bottles of beer.| ) ( |Take one down and pass it around, 50 bottles of beer on the wall.| )
                              ( |50 bottles of beer on the wall, 50 bottles of beer.| ) ( |Take one down and pass it around, 49 bottles of beer on the wall.| )
                              ( |49 bottles of beer on the wall, 49 bottles of beer.| ) ( |Take one down and pass it around, 48 bottles of beer on the wall.| )
                              ( |48 bottles of beer on the wall, 48 bottles of beer.| ) ( |Take one down and pass it around, 47 bottles of beer on the wall.| )
                              ( |47 bottles of beer on the wall, 47 bottles of beer.| ) ( |Take one down and pass it around, 46 bottles of beer on the wall.| )
                              ( |46 bottles of beer on the wall, 46 bottles of beer.| ) ( |Take one down and pass it around, 45 bottles of beer on the wall.| )
                              ( |45 bottles of beer on the wall, 45 bottles of beer.| ) ( |Take one down and pass it around, 44 bottles of beer on the wall.| )
                              ( |44 bottles of beer on the wall, 44 bottles of beer.| ) ( |Take one down and pass it around, 43 bottles of beer on the wall.| )
                              ( |43 bottles of beer on the wall, 43 bottles of beer.| ) ( |Take one down and pass it around, 42 bottles of beer on the wall.| )
                              ( |42 bottles of beer on the wall, 42 bottles of beer.| ) ( |Take one down and pass it around, 41 bottles of beer on the wall.| )
                              ( |41 bottles of beer on the wall, 41 bottles of beer.| ) ( |Take one down and pass it around, 40 bottles of beer on the wall.| )
                              ( |40 bottles of beer on the wall, 40 bottles of beer.| ) ( |Take one down and pass it around, 39 bottles of beer on the wall.| )
                              ( |39 bottles of beer on the wall, 39 bottles of beer.| ) ( |Take one down and pass it around, 38 bottles of beer on the wall.| )
                              ( |38 bottles of beer on the wall, 38 bottles of beer.| ) ( |Take one down and pass it around, 37 bottles of beer on the wall.| )
                              ( |37 bottles of beer on the wall, 37 bottles of beer.| ) ( |Take one down and pass it around, 36 bottles of beer on the wall.| )
                              ( |36 bottles of beer on the wall, 36 bottles of beer.| ) ( |Take one down and pass it around, 35 bottles of beer on the wall.| )
                              ( |35 bottles of beer on the wall, 35 bottles of beer.| ) ( |Take one down and pass it around, 34 bottles of beer on the wall.| )
                              ( |34 bottles of beer on the wall, 34 bottles of beer.| ) ( |Take one down and pass it around, 33 bottles of beer on the wall.| )
                              ( |33 bottles of beer on the wall, 33 bottles of beer.| ) ( |Take one down and pass it around, 32 bottles of beer on the wall.| )
                              ( |32 bottles of beer on the wall, 32 bottles of beer.| ) ( |Take one down and pass it around, 31 bottles of beer on the wall.| )
                              ( |31 bottles of beer on the wall, 31 bottles of beer.| ) ( |Take one down and pass it around, 30 bottles of beer on the wall.| )
                              ( |30 bottles of beer on the wall, 30 bottles of beer.| ) ( |Take one down and pass it around, 29 bottles of beer on the wall.| )
                              ( |29 bottles of beer on the wall, 29 bottles of beer.| ) ( |Take one down and pass it around, 28 bottles of beer on the wall.| )
                              ( |28 bottles of beer on the wall, 28 bottles of beer.| ) ( |Take one down and pass it around, 27 bottles of beer on the wall.| )
                              ( |27 bottles of beer on the wall, 27 bottles of beer.| ) ( |Take one down and pass it around, 26 bottles of beer on the wall.| )
                              ( |26 bottles of beer on the wall, 26 bottles of beer.| ) ( |Take one down and pass it around, 25 bottles of beer on the wall.| )
                              ( |25 bottles of beer on the wall, 25 bottles of beer.| ) ( |Take one down and pass it around, 24 bottles of beer on the wall.| )
                              ( |24 bottles of beer on the wall, 24 bottles of beer.| ) ( |Take one down and pass it around, 23 bottles of beer on the wall.| )
                              ( |23 bottles of beer on the wall, 23 bottles of beer.| ) ( |Take one down and pass it around, 22 bottles of beer on the wall.| )
                              ( |22 bottles of beer on the wall, 22 bottles of beer.| ) ( |Take one down and pass it around, 21 bottles of beer on the wall.| )
                              ( |21 bottles of beer on the wall, 21 bottles of beer.| ) ( |Take one down and pass it around, 20 bottles of beer on the wall.| )
                              ( |20 bottles of beer on the wall, 20 bottles of beer.| ) ( |Take one down and pass it around, 19 bottles of beer on the wall.| )
                              ( |19 bottles of beer on the wall, 19 bottles of beer.| ) ( |Take one down and pass it around, 18 bottles of beer on the wall.| )
                              ( |18 bottles of beer on the wall, 18 bottles of beer.| ) ( |Take one down and pass it around, 17 bottles of beer on the wall.| )
                              ( |17 bottles of beer on the wall, 17 bottles of beer.| ) ( |Take one down and pass it around, 16 bottles of beer on the wall.| )
                              ( |16 bottles of beer on the wall, 16 bottles of beer.| ) ( |Take one down and pass it around, 15 bottles of beer on the wall.| )
                              ( |15 bottles of beer on the wall, 15 bottles of beer.| ) ( |Take one down and pass it around, 14 bottles of beer on the wall.| )
                              ( |14 bottles of beer on the wall, 14 bottles of beer.| ) ( |Take one down and pass it around, 13 bottles of beer on the wall.| )
                              ( |13 bottles of beer on the wall, 13 bottles of beer.| ) ( |Take one down and pass it around, 12 bottles of beer on the wall.| )
                              ( |12 bottles of beer on the wall, 12 bottles of beer.| ) ( |Take one down and pass it around, 11 bottles of beer on the wall.| )
                              ( |11 bottles of beer on the wall, 11 bottles of beer.| ) ( |Take one down and pass it around, 10 bottles of beer on the wall.| )
                              ( |10 bottles of beer on the wall, 10 bottles of beer.| ) ( |Take one down and pass it around, 9 bottles of beer on the wall.| )
                              ( |9 bottles of beer on the wall, 9 bottles of beer.| )   ( |Take one down and pass it around, 8 bottles of beer on the wall.| )
                              ( |8 bottles of beer on the wall, 8 bottles of beer.| )   ( |Take one down and pass it around, 7 bottles of beer on the wall.| )
                              ( |7 bottles of beer on the wall, 7 bottles of beer.| )   ( |Take one down and pass it around, 1 six-pack of beer on the wall.| )
                              ( |1 six-pack of beer on the wall, 1 six-pack of beer.| ) ( |Take one down and pass it around, 5 bottles of beer on the wall.| )
                              ( |5 bottles of beer on the wall, 5 bottles of beer.| )   ( |Take one down and pass it around, 4 bottles of beer on the wall.| )
                              ( |4 bottles of beer on the wall, 4 bottles of beer.| )   ( |Take one down and pass it around, 3 bottles of beer on the wall.| )
                              ( |3 bottles of beer on the wall, 3 bottles of beer.| )   ( |Take one down and pass it around, 2 bottles of beer on the wall.| )
                              ( |2 bottles of beer on the wall, 2 bottles of beer.| )   ( |Take one down and pass it around, 1 bottle of beer on the wall.| )
                              ( |1 bottle of beer on the wall, 1 bottle of beer.| )     ( |Take it down and pass it around, no more bottles of beer on the wall.| )
                              ( |No more bottles of beer on the wall, no more bottles of beer.| ) ( |Go to the store and buy some more, 99 bottles of beer on the wall.| ) )
       act = NEW countdown_song( )->song( ) ).
  ENDMETHOD.

ENDCLASS.

CLASS ltc_bottle_number DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS return_correct_bottle_numbers FOR TESTING.
ENDCLASS.


CLASS ltc_bottle_number IMPLEMENTATION.

  METHOD return_correct_bottle_numbers.
    cl_abap_unit_assert=>assert_true( act = xsdbool( lcl_bottle_number=>for( 0 ) IS INSTANCE OF lcl_bottle_number_0 ) ).
    cl_abap_unit_assert=>assert_true( act = xsdbool( lcl_bottle_number=>for( 1 ) IS INSTANCE OF lcl_bottle_number_1 ) ).
    cl_abap_unit_assert=>assert_true( act = xsdbool( lcl_bottle_number=>for( 6 ) IS INSTANCE OF lcl_bottle_number_6 ) ).

    cl_abap_unit_assert=>assert_true( act = xsdbool( lcl_bottle_number=>for( 3 ) IS INSTANCE OF lcl_bottle_number ) ).
    cl_abap_unit_assert=>assert_true( act = xsdbool( lcl_bottle_number=>for( 7 ) IS INSTANCE OF lcl_bottle_number ) ).
    cl_abap_unit_assert=>assert_true( act = xsdbool( lcl_bottle_number=>for( 43 ) IS INSTANCE OF lcl_bottle_number ) ).

  ENDMETHOD.

ENDCLASS.

CLASS ltc_bottle_verse DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS verse_general_rule_upper_bound FOR TESTING.
    METHODS verse_general_rule_lower_bound FOR TESTING.
    METHODS verse_7                        FOR TESTING.
    METHODS verse_6                        FOR TESTING.
    METHODS verse_2                        FOR TESTING.
    METHODS verse_1                        FOR TESTING.
    METHODS verse_0                        FOR TESTING.
ENDCLASS.


CLASS ltc_bottle_verse IMPLEMENTATION.

  METHOD verse_general_rule_upper_bound.
    cl_abap_unit_assert=>assert_equals(
        exp = VALUE stringtab( ( |99 bottles of beer on the wall, 99 bottles of beer.|  )
                               ( |Take one down and pass it around, 98 bottles of beer on the wall.| ) )
        act = bottle_verse=>lyrics( 99 ) ).
  ENDMETHOD.

  METHOD verse_general_rule_lower_bound.
    cl_abap_unit_assert=>assert_equals(
           exp = VALUE stringtab( ( |3 bottles of beer on the wall, 3 bottles of beer.| )
                                  ( |Take one down and pass it around, 2 bottles of beer on the wall.| ) )
           act = bottle_verse=>lyrics( 3 ) ).
  ENDMETHOD.

  METHOD verse_7.
    cl_abap_unit_assert=>assert_equals(
               exp = VALUE stringtab( ( |7 bottles of beer on the wall, 7 bottles of beer.| )
                                      ( |Take one down and pass it around, 1 six-pack of beer on the wall.| ) )
               act = bottle_verse=>lyrics( 7 ) ).
  ENDMETHOD.

  METHOD verse_6.
    cl_abap_unit_assert=>assert_equals(
               exp = VALUE stringtab( ( |1 six-pack of beer on the wall, 1 six-pack of beer.| )
                                      ( |Take one down and pass it around, 5 bottles of beer on the wall.| ) )
               act = bottle_verse=>lyrics( 6 ) ).
  ENDMETHOD.

  METHOD verse_2.
    cl_abap_unit_assert=>assert_equals(
               exp = VALUE stringtab( ( |2 bottles of beer on the wall, 2 bottles of beer.| )
                                      ( |Take one down and pass it around, 1 bottle of beer on the wall.| ) )
               act = bottle_verse=>lyrics( 2 ) ).
  ENDMETHOD.

  METHOD verse_1.
    cl_abap_unit_assert=>assert_equals(
            exp = VALUE stringtab( ( |1 bottle of beer on the wall, 1 bottle of beer.| )
                                   ( |Take it down and pass it around, no more bottles of beer on the wall.| ) )
            act = bottle_verse=>lyrics( 1 ) ).
  ENDMETHOD.

  METHOD verse_0.
    cl_abap_unit_assert=>assert_equals(
            exp = VALUE stringtab( ( |No more bottles of beer on the wall, no more bottles of beer.| )
                                   ( |Go to the store and buy some more, 99 bottles of beer on the wall.| ) )
            act = bottle_verse=>lyrics( 0 ) ).
  ENDMETHOD.

ENDCLASS.
