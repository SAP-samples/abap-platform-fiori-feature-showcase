CLASS lhc_Root DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS createChildFromRoot FOR MODIFY
      IMPORTING keys FOR ACTION Root~createChildFromRoot RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Root RESULT result.

ENDCLASS.

CLASS lhc_Root IMPLEMENTATION.

  METHOD createChildFromRoot.
    READ ENTITIES OF /DMO/FSA_R_RootTP
      ENTITY Root
        FIELDS ( StringProperty ) WITH CORRESPONDING #( keys )
        RESULT DATA(roots)
      ENTITY Root BY \_Child
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(children)
      FAILED DATA(read_failed).

    MODIFY ENTITIES OF /DMO/FSA_R_RootTP
      ENTITY Root
        CREATE BY \_Child
          AUTO FILL CID WITH VALUE #( FOR root IN roots ( %tky = root-%tky
                                                          %target = VALUE #( ( %is_draft = root-%is_draft
                                                                               StringProperty = |{ root-StringProperty } Child { lines( children ) + 1 }|  ##NO_TEXT
                                                                               FieldWithPercent = '10.00'
                                                                               %control-stringproperty = if_abap_behv=>mk-on
                                                                               %control-fieldwithpercent = if_abap_behv=>mk-on ) ) ) )
        EXECUTE increaseTimesChildCreated
          FROM CORRESPONDING #( roots )
        MAPPED DATA(upd_mapped)
        FAILED DATA(upd_failed)
        REPORTED DATA(upd_reported).

    result = VALUE #( FOR root IN roots
                        ( %tky    = CORRESPONDING #( root-%tky )
                          %param  = CORRESPONDING #( upd_mapped-child[ 1 ] ) ) ).

    LOOP AT roots ASSIGNING FIELD-SYMBOL(<root>).
      APPEND VALUE #( %tky  = CORRESPONDING #( <root>-%tky )
                      %msg  = new_message( id       = '/DMO/CM_FSA'
                                           number   = 004
                                           severity = if_abap_behv_message=>severity-success ) ) TO reported-root.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF /DMO/FSA_R_RootTP
      ENTITY Root
        FIELDS ( UpdateHidden ) WITH CORRESPONDING #( keys )
      RESULT DATA(roots).

    result =
      VALUE #(
        FOR root IN roots
          LET is_updatable =  COND #( WHEN root-UpdateHidden  = abap_true
                                        THEN if_abap_behv=>fc-o-disabled
                                        ELSE if_abap_behv=>fc-o-enabled  )
          IN ( %tky                         = CORRESPONDING #( root-%tky )
               %action-createChildFromRoot  = is_updatable )
      ).
  ENDMETHOD.

ENDCLASS.
