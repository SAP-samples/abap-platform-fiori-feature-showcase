CLASS lhc_grandchild DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS calculategrandchildpieces FOR DETERMINE ON MODIFY
      IMPORTING keys FOR grandchild~calculategrandchildpieces.

ENDCLASS.

CLASS lhc_grandchild IMPLEMENTATION.

  METHOD calculateGrandchildPieces.
    READ ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Grandchild
        FIELDS ( RootID GrandchildPieces )
        WITH CORRESPONDING #( keys )
      RESULT DATA(grandchildren)
      ENTITY Grandchild BY \_Root
        FIELDS ( TotalGrandchildPieces )
        WITH CORRESPONDING #( keys )
      RESULT DATA(roots).

    LOOP AT roots ASSIGNING FIELD-SYMBOL(<fs_root>).
      DATA(lv_value) = VALUE #( grandchildren[ RootID = <fs_root>-id ]-GrandchildPieces OPTIONAL ).

      IF lv_value IS NOT INITIAL.
        <fs_root>-TotalGrandchildPieces += lv_value.
      ENDIF.
    ENDLOOP.

    MODIFY ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        UPDATE
          FIELDS ( TotalGrandchildPieces )
          WITH VALUE #( FOR root IN roots
                          ( %tky                  = root-%tky
                            TotalGrandchildPieces       = root-TotalGrandchildPieces ) )
      REPORTED DATA(mod_reported).

    reported = CORRESPONDING #( DEEP mod_reported ).
  ENDMETHOD.

ENDCLASS.

CLASS lhc_child DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS calculateTotalPieces FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Child~calculateTotalPieces.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Child RESULT result.

ENDCLASS.

CLASS lhc_child IMPLEMENTATION.

  METHOD calculateTotalPieces.
    READ ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Child BY \_Root
        FIELDS ( ID  )
        WITH CORRESPONDING #(  keys  )
      RESULT DATA(roots).

    MODIFY ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        EXECUTE calcTotalPieces
          FROM CORRESPONDING #( roots ).

  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Child
        FIELDS ( BooleanProperty )
        WITH CORRESPONDING #(  keys  )
      RESULT DATA(children).

    result = VALUE #( FOR child IN children
                        ( %tky      = child-%tky
                          %delete   = COND #( WHEN child-BooleanProperty  = abap_true
                                                THEN if_abap_behv=>fc-o-enabled
                                                ELSE if_abap_behv=>fc-o-disabled  )
                         ) ).
  ENDMETHOD.

ENDCLASS.

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

    METHODS resetTimesChildCreated FOR MODIFY
      IMPORTING keys FOR ACTION Root~resetTimesChildCreated.

    METHODS calcTotalPieces FOR MODIFY
      IMPORTING keys FOR ACTION Root~calcTotalPieces.

    METHODS increaseTimesChildCreated FOR MODIFY
      IMPORTING keys FOR ACTION Root~increaseTimesChildCreated.

    METHODS validateValidTo FOR VALIDATE ON SAVE
      IMPORTING keys FOR Root~validateValidTo.

    METHODS get_all_criticality
      RETURNING VALUE(rt_criticality) TYPE tt_criticality.

    METHODS validatePercentage FOR VALIDATE ON SAVE
      IMPORTING keys FOR Child~validatePercentage.

    METHODS copyInstance FOR MODIFY
      IMPORTING keys FOR ACTION Root~copyInstance.

    METHODS setTime FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Root~setTime.

    METHODS overwriteTimezone FOR MODIFY
      IMPORTING keys FOR ACTION Root~overwriteTimezone.
    METHODS validateTimezone FOR VALIDATE ON SAVE
      IMPORTING keys FOR Root~validateTimezone.

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
                          ( %tky                  = key-%tky
                            CriticalityCode       = key-%param-criticality_code
                            FieldWithCriticality  = lt_criticality[ code = key-%param-criticality_code ]-name ) )
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
        FIELDS ( IntegerValue )
        WITH CORRESPONDING #( keys )
      RESULT DATA(roots).

    MODIFY ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        UPDATE
          FIELDS ( ProgressIntegerValue RadialIntegerValue )
          WITH VALUE #( FOR root IN roots
                          ( %tky                          = root-%tky
                            ProgressIntegerValue          = root-IntegerValue
                            RadialIntegerValue            = root-IntegerValue
                            %control-ProgressIntegerValue = if_abap_behv=>mk-on
                            %control-RadialIntegerValue   = if_abap_behv=>mk-on ) )
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
      RESULT DATA(roots)
      ENTITY Root BY \_Chart
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(charts).

    CHECK charts IS INITIAL.

*   Generate chart data
    DATA(ls_dimension) = 2.

    SELECT * FROM /DMO/FSA_R_ChartTP
      INTO TABLE @DATA(lt_chart)
        UP TO 5 ROWS. "#EC CI_NOORDER "#EC CI_NOWHERE

    CHECK lt_chart IS NOT INITIAL.

    LOOP AT lt_chart ASSIGNING FIELD-SYMBOL(<fs_chart>).
      <fs_chart>-Dimensions = ls_dimension.
      ls_dimension += 2.
      CLEAR: <fs_chart>-Id, <fs_chart>-ParentId.
    ENDLOOP.

*   modify
    MODIFY ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        UPDATE
          FIELDS ( FieldWithCriticality TimesChildCreated )
          WITH VALUE #( FOR root IN roots
                          ( %tky                          = root-%tky
                            FieldWithCriticality          = lt_criticality[ code = root-CriticalityCode ]-name
                            %control-FieldWithCriticality = if_abap_behv=>mk-on ) )
        CREATE BY \_Chart
          AUTO FILL CID WITH VALUE #( FOR root IN roots
                                        ( %tky = root-%tky
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
        FIELDS ( UpdateHidden DeleteHidden TimesChildCreated ) WITH CORRESPONDING #( keys )
      RESULT DATA(roots)
      FAILED failed.

    result = VALUE #( FOR root IN roots
                        ( %tky = root-%tky
                          %update                         = COND #( WHEN root-UpdateHidden  = abap_true
                                                                      THEN if_abap_behv=>fc-o-disabled
                                                                       ELSE if_abap_behv=>fc-o-enabled  )
                          %delete                         = COND #( WHEN root-DeleteHidden  = abap_true
                                                                      THEN if_abap_behv=>fc-o-disabled
                                                                       ELSE if_abap_behv=>fc-o-enabled  )
                          %field-TimesChildCreated        = if_abap_behv=>fc-f-read_only
                          %action-changeProgress          = COND #( WHEN root-UpdateHidden  = abap_true
                                                                      THEN if_abap_behv=>fc-o-disabled
                                                                      ELSE if_abap_behv=>fc-o-enabled )
                          %action-changeCriticality       = COND #( WHEN root-UpdateHidden  = abap_true
                                                                      THEN if_abap_behv=>fc-o-disabled
                                                                      ELSE if_abap_behv=>fc-o-enabled  )
                          %action-overwriteTimezone       = COND #( WHEN root-UpdateHidden  = abap_true
                                                                      THEN if_abap_behv=>fc-o-disabled
                                                                      ELSE if_abap_behv=>fc-o-enabled )
                          %action-copyInstance            = COND #( WHEN root-UpdateHidden  = abap_true
                                                                      THEN if_abap_behv=>fc-o-disabled
                                                                      ELSE if_abap_behv=>fc-o-enabled )
                          %action-resetTimesChildCreated  = COND #( WHEN root-UpdateHidden  = abap_true OR root-TimesChildCreated = 0
                                                                      THEN if_abap_behv=>fc-o-disabled
                                                                      ELSE if_abap_behv=>fc-o-enabled  )

                         ) ).
  ENDMETHOD.

  METHOD resetTimesChildCreated.
    MODIFY ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
      UPDATE
          FIELDS ( TimesChildCreated )
          WITH VALUE #( FOR key IN keys
                          ( %tky                        = key-%tky
                            TimesChildCreated           = 0
                            %control-TimesChildCreated  = if_abap_behv=>mk-on ) )
        FAILED failed
        REPORTED reported.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).

      APPEND VALUE #( %tky        = <key>-%tky
                      %msg        = new_message( id       = '/DMO/CM_FSA'
                                                 number   = 003
                                                 severity = if_abap_behv_message=>severity-success )
                      %action-resetTimesChildCreated = if_abap_behv=>mk-on ) TO reported-root.
    ENDLOOP.
  ENDMETHOD.

  METHOD calcTotalPieces.
    DATA: lv_total TYPE /DMO/FSA_R_RootTP-TotalPieces.

    READ ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        FIELDS ( TotalPieces ) WITH CORRESPONDING #( keys )
      RESULT DATA(roots)
      ENTITY Root BY \_Child
        FIELDS ( ChildPieces ) WITH CORRESPONDING #( keys )
      RESULT DATA(children).

    LOOP AT roots ASSIGNING FIELD-SYMBOL(<root>).
      CLEAR <root>-TotalPieces.

      LOOP AT children ASSIGNING FIELD-SYMBOL(<child>)
        WHERE ParentID = <root>-%tky-id.
        <root>-TotalPieces += <child>-ChildPieces.
      ENDLOOP.
    ENDLOOP.

    MODIFY ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        UPDATE
          FIELDS ( TotalPieces )
          WITH CORRESPONDING #( roots )
      FAILED failed
      REPORTED reported.
  ENDMETHOD.

  METHOD increaseTimesChildCreated.
    READ ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        FIELDS ( TimesChildCreated ) WITH CORRESPONDING #( keys )
      RESULT DATA(roots).

    MODIFY ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
      UPDATE
        FIELDS ( TimesChildCreated ) WITH VALUE #( FOR root IN roots
                                                    ( %tky                        = root-%tky
                                                      TimesChildCreated           = root-TimesChildCreated + 1
                                                      %control-TimesChildCreated  = if_abap_behv=>mk-on ) )
        FAILED failed
        REPORTED reported.
  ENDMETHOD.

  METHOD validateValidTo.
    READ ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        FIELDS ( ValidTo ) WITH CORRESPONDING #( keys )
      RESULT DATA(roots).

    LOOP AT roots ASSIGNING FIELD-SYMBOL(<root>).

      APPEND VALUE #( %tky = <root>-%tky
                      %state_area = 'VAL_VALID_TO' ) TO reported-root.

      IF <root>-ValidTo < cl_abap_context_info=>get_system_date( ) AND <root>-ValidTo IS NOT INITIAL.
        APPEND VALUE #( %tky = <root>-%tky ) TO failed-root.

        APPEND VALUE #( %tky        = <root>-%tky
                        %state_area = 'VAL_VALID_TO'
                        %msg        = new_message( id       = '/DMO/CM_FSA'
                                                   number   = 001
                                                   severity = if_abap_behv_message=>severity-error
                                                   v1       = |{ <root>-ValidTo DATE = (cl_abap_format=>d_user) }|  )
                       %element-ValidTo = if_abap_behv=>mk-on ) TO reported-root.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

   METHOD validatePercentage.
    READ ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Child
        FIELDS ( FieldWithPercent ) WITH CORRESPONDING #( keys )
        RESULT DATA(children)
      ENTITY Child BY \_Root
        FROM CORRESPONDING #( keys )
      LINK DATA(links).

    LOOP AT children ASSIGNING FIELD-SYMBOL(<child>).

      APPEND VALUE #( %tky = <child>-%tky
                      %state_area = 'VAL_PERCENTAGE'
                      ) TO reported-child.

      IF <child>-FieldWithPercent = 0.
        APPEND VALUE #( %tky = <child>-%tky ) TO failed-child.

        APPEND VALUE #( %tky        = <child>-%tky
                        %state_area = 'VAL_PERCENTAGE'
                        %msg        = new_message( id       = '/DMO/CM_FSA'
                                                   number   = 002
                                                   severity = if_abap_behv_message=>severity-error )
                        %path       = VALUE #( root-%tky = links[ KEY ID source-%tky = <child>-%tky ]-target-%tky )
                        %element-FieldWithPercent = if_abap_behv=>mk-on ) TO reported-child.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD copyInstance.
    DATA: lt_root_create        TYPE TABLE FOR CREATE /dmo/fsa_r_roottp\\root,
          lt_child_create       TYPE TABLE FOR CREATE /dmo/fsa_r_roottp\\root\_child,
          lt_grandchild_create  TYPE TABLE FOR CREATE /DMO/fsa_r_roottp\\Child\_Grandchild,
          lt_chart_create       TYPE TABLE FOR CREATE /dmo/fsa_r_roottp\\root\_chart.

    READ ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(roots)
      ENTITY Root BY \_Child
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(children)
      ENTITY Root BY \_Chart
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(charts)
        FAILED DATA(read_failed).

    READ ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Child BY \_Grandchild
        ALL FIELDS WITH CORRESPONDING #( children )
        RESULT DATA(grandchildren).

    lt_root_create = CORRESPONDING #( roots CHANGING CONTROL EXCEPT DeleteHidden UpdateHidden ValidTo ).

    LOOP AT lt_root_create ASSIGNING FIELD-SYMBOL(<fs_root_c>).
      <fs_root_c>-%cid = keys[ KEY entity %key = <fs_root_c>-%key ]-%cid.
      <fs_root_c>-StringProperty = |Copied instance| ##NO_TEXT .
      <fs_root_c>-%control-ID = if_abap_behv=>mk-off.
      CLEAR: <fs_root_c>-ID.

      APPEND VALUE #(
                      %cid_ref = <fs_root_c>-%cid
                      %target  = CORRESPONDING #( children CHANGING CONTROL EXCEPT ParentId )
      ) TO lt_child_create.

      APPEND VALUE #( %cid_ref = <fs_root_c>-%cid
                      %target  = CORRESPONDING #( charts CHANGING CONTROL EXCEPT ID ParentId )
      ) TO lt_chart_create.

      DATA(lt_grandchildren) = grandchildren.

      LOOP AT lt_child_create ASSIGNING FIELD-SYMBOL(<fs_child>)
        USING KEY cid WHERE %cid_ref = <fs_root_c>-%cid.

        LOOP AT <fs_child>-%target ASSIGNING FIELD-SYMBOL(<fs_target>).
          <fs_target>-%cid = <fs_child>-%cid_ref && sy-tabix.

          DELETE lt_grandchildren WHERE ParentID <> <fs_target>-%key-id.

          APPEND VALUE #( %cid_ref  =  <fs_target>-%cid
                          %target = CORRESPONDING #( lt_grandchildren CHANGING CONTROL EXCEPT ID ParentId RootId )
          ) TO lt_grandchild_create.

          <fs_target>-%control-ID = if_abap_behv=>mk-off.
          CLEAR: <fs_target>-ID.

          lt_grandchildren = grandchildren.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.

    MODIFY ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        CREATE
          FROM lt_root_create
        CREATE BY \_Child
          FROM lt_child_create
        CREATE BY \_Chart
          AUTO FILL CID WITH lt_chart_create
      ENTITY Child
        CREATE BY \_Grandchild
          AUTO FILL CID WITH lt_grandchild_create
      MAPPED mapped
      REPORTED reported
      FAILED failed.

  ENDMETHOD.

  METHOD setTime.
    READ ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        FIELDS ( SAPTimezone Timestamp )
        WITH CORRESPONDING #( keys )
      RESULT DATA(roots).

    MODIFY ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        UPDATE
          FIELDS ( IANATimezone IANATimestamp  )
          WITH VALUE #( FOR root IN roots
                          ( %tky                    = root-%tky
                            IANATimezone            = root-SAPTimezone
                            IANATimestamp           = root-Timestamp
                            %control-IANATimezone   = if_abap_behv=>mk-on
                            %control-IANATimestamp  = if_abap_behv=>mk-on ) )
      FAILED DATA(upd_failed)
      REPORTED DATA(upd_reported).

    reported = CORRESPONDING #( DEEP upd_reported ).
  ENDMETHOD.

  METHOD overwriteTimezone.
    MODIFY ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        UPDATE
          FIELDS ( SAPTimezone )
          WITH VALUE #( FOR key IN keys
                          ( %tky = key-%tky
                            SAPTimezone  = key-%param-sap_timezone ) )
      FAILED failed
      REPORTED reported.

  ENDMETHOD.

  METHOD validateTimezone.
    READ ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Root
        FIELDS ( SAPTimezone ) WITH CORRESPONDING #( keys )
      RESULT DATA(roots).

    CHECK roots IS NOT INITIAL.

    SELECT FROM I_Timezone FIELDS TimeZoneID
      FOR ALL ENTRIES IN @roots
        WHERE TimeZoneID = @roots-SAPTimezone
        INTO TABLE @DATA(lt_timezone).

    LOOP AT roots ASSIGNING FIELD-SYMBOL(<root>).

      APPEND VALUE #( %tky = <root>-%tky
                      %state_area = 'VAL_VALID_TZ' ) TO reported-root.

      IF NOT line_exists( lt_timezone[ TimeZoneID = <root>-SAPTimezone ] ).
        APPEND VALUE #( %tky = <root>-%tky ) TO failed-root.

        APPEND VALUE #( %tky        = <root>-%tky
                        %state_area = 'VAL_VALID_TZ'
                        %msg        = new_message( id       = '/DMO/CM_FSA'
                                                   number   = 005
                                                   severity = if_abap_behv_message=>severity-error
                                                   v1       = |{ <root>-SAPTimezone }|  )
                       %element-SAPTimezone = if_abap_behv=>mk-on ) TO reported-root.

      ENDIF.

    ENDLOOP.
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
