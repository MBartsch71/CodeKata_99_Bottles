REPORT ymbh_99_bottles_111.

CLASS lcl_bottles DEFINITION.

  PUBLIC SECTION.
    METHODS song
      RETURNING
        VALUE(rt_song) TYPE stringtab.

  PRIVATE SECTION.

    METHODS verses
      IMPORTING
        iv_hi            TYPE i
        iv_low           TYPE i
      RETURNING
        VALUE(rt_verses) TYPE stringtab.

    METHODS verse
      IMPORTING
        iv_number       TYPE i
      RETURNING
        VALUE(rt_verse) TYPE stringtab.

ENDCLASS.

CLASS lcl_bottles IMPLEMENTATION.

  METHOD song.
    rt_song = verses( iv_hi = 99  iv_low = 0 ).
  ENDMETHOD.

  METHOD verses.
    DATA(lv_counter) = iv_hi.
    WHILE lv_counter >= 0.
      APPEND LINES OF verse( lv_counter ) TO rt_verses.
      lv_counter = lv_counter - 1.
    ENDWHILE.
  ENDMETHOD.

  METHOD verse.
    DATA lv_s TYPE c LENGTH 1.

    IF iv_number = 0.
      rt_verse = VALUE #( BASE rt_verse ( |No more bottles of beer on the wall. No more bottles of beer| ) ).
    ELSE.
      lv_s = SWITCH #( iv_number WHEN 1 THEN ''
                                 ELSE 's' ).
      rt_verse = VALUE #( BASE rt_verse ( |{ iv_number } bottle{ lv_s } of beer on the wall, { iv_number } bottle{ lv_s } of beer.| ) ).
    ENDIF.

    IF iv_number > 0..
      DATA(lv_down) = SWITCH #( iv_number WHEN 1 THEN |it|
                                          ELSE |one| ).
      rt_verse = VALUE #( BASE rt_verse ( |Take { lv_down } down and pass it around.| ) ).
    ELSE.
      rt_verse = VALUE #( BASE rt_verse ( |Go to the store and buy some more| ) ).
    ENDIF.

    IF iv_number - 1 < 0.
      rt_verse = VALUE #( BASE rt_verse ( |99 bottles of beer on the wall.| ) ).
    ELSEIF iv_number - 1 = 0.
      rt_verse = VALUE #( BASE rt_verse ( |No more bottles of beer on the wall.| ) ).
    ELSE.
      lv_s = SWITCH #( iv_number - 1 WHEN 1 THEN ''
                                 ELSE 's' ).
      rt_verse = VALUE #( BASE rt_verse ( |{ iv_number - 1 } bottle{ lv_s } of beer on the wall.| ) ).
    ENDIF.
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

  DATA(lo_main) = NEW lcl_main(  ).
  lo_main->run( ).
