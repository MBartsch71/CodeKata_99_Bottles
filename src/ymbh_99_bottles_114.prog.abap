REPORT ymbh_99_bottles_114.

CLASS lcl_bottles DEFINITION.

  PUBLIC SECTION.
    METHODS song
      RETURNING
        VALUE(rt_song) TYPE stringtab.

    METHODS verses
      IMPORTING
        iv_starting     TYPE i
        iv_ending       TYPE i
      RETURNING
        VALUE(rt_lines) TYPE stringtab.

    METHODS verse
      IMPORTING
        iv_verse_number TYPE i
      RETURNING
        VALUE(rt_lines) TYPE stringtab.

ENDCLASS.

CLASS lcl_bottles IMPLEMENTATION.

  METHOD song.
    rt_song = verses( iv_starting = 99
                      iv_ending   = 0 ).
  ENDMETHOD.

  METHOD verses.
    DATA(lv_verse) = iv_starting.
    WHILE lv_verse >= iv_ending.
      APPEND LINES OF verse( lv_verse ) TO rt_lines.
      lv_verse = lv_verse - 1.
    ENDWHILE.
  ENDMETHOD.

  METHOD verse.
    rt_lines = SWITCH #( iv_verse_number
                            WHEN 0 THEN VALUE #( ( |No more bottles of beer on the wall, no more bottles of beer.| )
                                                 ( |Go to the store and buy some more, 99 bottles of beer on the wall.| ) )
                            WHEN 1 THEN VALUE #( ( |1 bottle of beer on the wall, 1 bottle of beer.| )
                                                 ( |Take it down and pass it around, no more bottles of beer on the wall.| ) )
                            WHEN 2 THEN VALUE #( ( |2 bottles of beer on the wall, 2 bottles of beer.| )
                                                 ( |Take one down and pass it around, 1 bottle of beer on the wall.| ) )
                            ELSE VALUE #( ( |{ iv_verse_number } bottles of beer on the wall, { iv_verse_number } bottles of beer.| )
                                          ( |Take one down and pass it around, { iv_verse_number - 1 } bottles of beer on the wall.| ) )
                       ).
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
