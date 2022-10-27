CLASS lhc_Root DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    TYPES: tt_criticality TYPE STANDARD TABLE OF /dmo/fsa_critlty WITH DEFAULT KEY.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Root RESULT result.

    METHODS changeCriticality FOR MODIFY
      IMPORTING keys FOR ACTION Root~changeCriticality RESULT result.

    METHODS changeProgress FOR MODIFY
      IMPORTING keys FOR ACTION Root~changeProgress RESULT result.

    METHODS setIntegerValue FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Root~setIntegerValue.

    METHODS generateOtherData FOR DETERMINE ON SAVE
      IMPORTING keys FOR Root~generateOtherData.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Root RESULT result.

    METHODS get_all_criticality
      RETURNING VALUE(rt_criticality) TYPE tt_criticality.

ENDCLASS.

CLASS lhc_Root IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD changeCriticality.
    DATA(lt_criticality) = get_all_criticality( ).

    MODIFY ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        UPDATE
          FIELDS ( CriticalityCode FieldWithCriticality )
          WITH VALUE #( FOR key IN keys
                          ( %tky = key-%tky
                            CriticalityCode  = key-%param-criticality_code
                            FieldWithCriticality = lt_criticality[ code = key-%param-criticality_code ]-name ) )
      FAILED failed
      REPORTED reported.

    READ ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(roots).

    result = VALUE #( FOR root IN roots
                        ( %tky   = root-%tky
                          %param = root ) ).
  ENDMETHOD.

  METHOD changeProgress.
    MODIFY ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        UPDATE
          FIELDS ( IntegerValue )
          WITH VALUE #( FOR key IN keys
                          ( %tky = key-%tky
                            IntegerValue  = key-%param-progress ) )
      FAILED failed
      REPORTED reported.

    READ ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(roots).

    result = VALUE #( FOR root IN roots
                        ( %tky   = root-%tky
                          %param = root ) ).
  ENDMETHOD.

  METHOD setIntegerValue.
    READ ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        FIELDS ( ProgressIntegerValue )
        WITH CORRESPONDING #( keys )
      RESULT DATA(roots).

    MODIFY ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        UPDATE
          FIELDS ( IntegerValue )
          WITH VALUE #( FOR root IN roots
                          ( %tky = root-%tky
                            IntegerValue  = root-ProgressIntegerValue
                            %control-IntegerValue = if_abap_behv=>mk-on ) )
      FAILED DATA(upd_failed)
      REPORTED DATA(upd_reported).

    reported = CORRESPONDING #( DEEP upd_reported ).
  ENDMETHOD.

  METHOD generateOtherData.
*   Get criticality
    DATA(lt_criticality) = get_all_criticality( ).

    READ ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        FIELDS ( CriticalityCode )
        WITH CORRESPONDING #( keys )
      RESULT DATA(roots).

*   Generate chart data
    DATA(ls_dimension) = 2.

    SELECT * FROM /DMO/FSA_R_ChartTP
      INTO TABLE @DATA(lt_chart)
        UP TO 5 ROWS. "#EC CI_NOORDER "#EC CI_NOWHERE

    CHECK lt_chart IS NOT INITIAL.

    LOOP AT lt_chart ASSIGNING FIELD-SYMBOL(<fs_chart>).
      <fs_chart>-Dimensions = ls_dimension.
      ls_dimension = ls_dimension + 2.
      CLEAR: <fs_chart>-Id, <fs_chart>-ParentId.
    ENDLOOP.

*   modify
    MODIFY ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        UPDATE
          FIELDS ( FieldWithCriticality )
          WITH VALUE #( FOR root IN roots ( %tky = root-%tky
                                            FieldWithCriticality = lt_criticality[ code = root-CriticalityCode ]-name
                                            %control-FieldWithCriticality = if_abap_behv=>mk-on ) )
        CREATE BY \_Chart
        AUTO FILL CID WITH VALUE #( FOR root IN roots ( %tky = root-%tky
                                                        %target = CORRESPONDING #( lt_chart CHANGING CONTROL ) ) ).
  ENDMETHOD.

  METHOD get_all_criticality.
    SELECT *
      FROM /dmo/fsa_critlty
      INTO TABLE @rt_criticality. "#EC CI_NOWHERE
  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        FIELDS ( DeleteHidden ) WITH CORRESPONDING #( keys )
      RESULT DATA(roots)
      FAILED failed.

    result =
      VALUE #(
        FOR root IN roots
          LET is_deletable =   COND #( WHEN root-DeleteHidden  = abap_true
                                        THEN if_abap_behv=>fc-o-disabled
                                        ELSE if_abap_behv=>fc-o-enabled  )
          IN ( %tky      = root-%tky
               %delete  = is_deletable )
      ).
  ENDMETHOD.

ENDCLASS.

CLASS lhc_Chart DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS updateChart FOR MODIFY
      IMPORTING keys FOR ACTION Chart~updateChart.

ENDCLASS.

CLASS lhc_Chart IMPLEMENTATION.

  METHOD updateChart.
  ENDMETHOD.

ENDCLASS.
