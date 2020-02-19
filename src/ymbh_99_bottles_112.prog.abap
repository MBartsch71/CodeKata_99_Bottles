REPORT ymbh_99_bottles_112.

CLASS lcl_verse DEFINITION.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_verse_number TYPE i
        it_lyrics       TYPE stringtab.

    METHODS text
      RETURNING
        VALUE(rt_lyrics) TYPE stringtab.

    DATA mv_verse_number TYPE i.
    DATA mt_lyrics TYPE stringtab.

ENDCLASS.

CLASS lcl_verse IMPLEMENTATION.

  METHOD constructor.
    mv_verse_number = iv_verse_number.
    mt_lyrics = it_lyrics.
  ENDMETHOD.

  METHOD text.
    rt_lyrics = mt_lyrics.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_bottles DEFINITION.

  PUBLIC SECTION.

    METHODS song
      RETURNING
        VALUE(rt_lines) TYPE stringtab.

  PRIVATE SECTION.

    METHODS no_more
      RETURNING
        VALUE(rt_lines) TYPE stringtab.

    METHODS last_one
      RETURNING
        VALUE(rt_lines) TYPE stringtab.

    METHODS penultimate
      RETURNING
        VALUE(rt_lines) TYPE stringtab.

    METHODS default
      IMPORTING
        iv_number       TYPE i
      RETURNING
        VALUE(rt_lines) TYPE stringtab.

    METHODS verses
      IMPORTING
        iv_number_of_lines TYPE i
      RETURNING
        VALUE(rt_lines)    TYPE stringtab.

    METHODS verse
      IMPORTING
        iv_verse_number TYPE i
      RETURNING
        VALUE(ro_verse) TYPE REF TO lcl_verse.

    METHODS verse_for
      IMPORTING
        iv_verse_number TYPE i
      RETURNING
        VALUE(rt_lines) TYPE stringtab.

ENDCLASS.

CLASS lcl_bottles IMPLEMENTATION.

  METHOD no_more.
    rt_lines = VALUE #( ( |No more bottles of beer on the wall, no more bottles of beer.| )
                        ( |Go to the store and buy some more, 99 bottles of beer on the wall.| ) ).
  ENDMETHOD.

  METHOD last_one.
    rt_lines = VALUE #( ( |1 bottle of beer on the wall, 1 bottle of beer.| )
                        ( |Take it down and pass it around, No more bottles of beer on the wall.| ) ).
  ENDMETHOD.

  METHOD penultimate.
    rt_lines = VALUE #( ( |2 bottles of beer on the wall, 2 bottles of beer.| )
                        ( |Take one down and pass it around, 1 bottle of beer on the wall.| ) ).
  ENDMETHOD.

  METHOD default.
    rt_lines = VALUE #( ( |{ iv_number } bottles of beer on the wall, { iv_number } bottles of beer.| )
                        ( |Take one down and pass it around, { iv_number - 1 } bottles of beer on the wall.| ) ).
  ENDMETHOD.

  METHOD song.
    rt_lines = verses( 99 ).
  ENDMETHOD.

  METHOD verses.
    DATA lv_verse TYPE i.
    lv_verse = iv_number_of_lines.
    DO iv_number_of_lines TIMES.
      APPEND LINES OF verse_for( lv_verse ) TO rt_lines.
      lv_verse = lv_verse - 1.
    ENDDO.
  ENDMETHOD.

  METHOD verse.
    ro_verse = SWITCH #( iv_verse_number
                            WHEN 0 THEN NEW lcl_verse( iv_verse_number = iv_verse_number
                                                       it_lyrics = no_more( ) )
                            WHEN 1 THEN NEW lcl_verse( iv_verse_number = iv_verse_number
                                                       it_lyrics       = last_one( ) )
                            WHEN 2 THEN NEW lcl_verse( iv_verse_number = iv_verse_number
                                                       it_lyrics       = penultimate( ) )
                            ELSE NEW lcl_verse( iv_verse_number = iv_verse_number
                                                it_lyrics       = default( iv_verse_number ) ) ).
  ENDMETHOD.

  METHOD verse_for.
    rt_lines = verse( iv_verse_number )->text( ).
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA(lo_bottles) = NEW lcl_bottles(  ).
  cl_demo_output=>display( lo_bottles->song( ) ).
