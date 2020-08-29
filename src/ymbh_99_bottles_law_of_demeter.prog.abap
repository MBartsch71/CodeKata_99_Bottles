REPORT ymbh_99_bottles_law_of_demeter.




CLASS toy DEFINITION.
  PUBLIC SECTION.
    METHODS durability
      RETURNING
        VALUE(durability) TYPE string.
ENDCLASS.

CLASS toy IMPLEMENTATION.

  METHOD durability.
    durability = '1 hour'.
  ENDMETHOD.

ENDCLASS.

CLASS pet DEFINITION.
  PUBLIC SECTION.
    METHODS durability_of_preferred_toy
      RETURNING
        VALUE(pref_toy_durability) TYPE string.

ENDCLASS.

CLASS pet IMPLEMENTATION.

  METHOD durability_of_preferred_toy.
    pref_toy_durability = NEW toy( )->durability( ).
  ENDMETHOD.

ENDCLASS.

CLASS friend DEFINITION.

  PUBLIC SECTION.
    METHODS playdate_time_limit
      RETURNING
        VALUE(durability_of_pet_pref_toy) TYPE string.

ENDCLASS.

CLASS friend IMPLEMENTATION.

  METHOD playdate_time_limit.
    durability_of_pet_pref_toy = NEW pet( )->durability_of_preferred_toy( ).
  ENDMETHOD.

ENDCLASS.

CLASS foo DEFINITION.
  PUBLIC SECTION.
    METHODS playdate_time_limit
      RETURNING
        VALUE(friends_playdate_time_limit) TYPE string.
ENDCLASS.

CLASS foo IMPLEMENTATION.

  METHOD playdate_time_limit.
    friends_playdate_time_limit = NEW friend(  )->playdate_time_limit(  ).
  ENDMETHOD.

ENDCLASS.
