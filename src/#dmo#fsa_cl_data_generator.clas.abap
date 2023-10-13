CLASS /dmo/fsa_cl_data_generator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.

    CLASS-METHODS: generate_random_data.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA: gv_out TYPE REF TO if_oo_adt_classrun_out.

    CLASS-METHODS: _delete_table_content.
    CLASS-METHODS: _delete_bo_data.

ENDCLASS.



CLASS /dmo/fsa_cl_data_generator IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    gv_out = out.
    generate_random_data( ).
    gv_out->write( `Data generation: Completed` ) ##NO_TEXT .
  ENDMETHOD.


  METHOD _delete_bo_data.
    SELECT * FROM /dmo/fsa_root_a
      INTO TABLE @DATA(lt_actives). "#EC CI_NOWHERE

    CHECK lt_actives IS NOT INITIAL.

    SELECT FROM /dmo/fsa_root_d
      FIELDS id INTO TABLE @DATA(lt_drafts). "#EC CI_NOWHERE

    IF lt_drafts IS NOT INITIAL.
      MODIFY ENTITIES OF /DMO/FSA_R_RootTP
        ENTITY Root
          EXECUTE Discard FROM
            VALUE #( FOR draft in lt_drafts ( %key-id = draft-id ) )
        FAILED DATA(failed)
          REPORTED DATA(reported).

      COMMIT ENTITIES.

      IF sy-subrc <> 0.
        gv_out->write( `Error deleting draft instances` ) ##NO_TEXT .
      ENDIF.
    ENDIF.

    LOOP AT lt_actives ASSIGNING FIELD-SYMBOL(<fs_active>).
      <fs_active>-delete_hidden = abap_false.
      <fs_active>-update_hidden = abap_false.
    ENDLOOP.

    UPDATE /dmo/fsa_root_a FROM TABLE @lt_actives.

    MODIFY ENTITIES OF /DMO/FSA_R_RootTP
      ENTITY Root
        DELETE FROM
          VALUE #( FOR active in lt_actives ( %key-id = active-id ) )
        FAILED failed
        REPORTED reported.

  ENDMETHOD.

  METHOD _delete_table_content.
    _delete_bo_data( ).

    DELETE FROM /dmo/fsa_contact. "#EC CI_NOWHERE
    DELETE FROM /dmo/fsa_critlty. "#EC CI_NOWHERE
    DELETE FROM /dmo/fsa_nav. "#EC CI_NOWHERE

    COMMIT WORK.
  ENDMETHOD.

  METHOD generate_random_data.
    _delete_table_content( ).

    INSERT /dmo/fsa_root_a  FROM TABLE @( lcl_fsa_root=>generate( ) ).
    INSERT /dmo/fsa_chart_a FROM TABLE @( lcl_fsa_chart=>generate( ) ).
    INSERT /dmo/fsa_child_a FROM TABLE @( lcl_fsa_child=>generate( ) ).
    INSERT /dmo/fsa_nav     FROM TABLE @( lcl_fsa_navigation=>generate( ) ).
    INSERT /dmo/fsa_gch_a   FROM TABLE @( lcl_fsa_grandchild=>generate( ) ).
    INSERT /dmo/fsa_contact FROM TABLE @( lcl_fsa_contact=>generate( ) ).
    INSERT /dmo/fsa_critlty FROM TABLE @( lcl_fsa_criticality=>generate( ) ).

    COMMIT WORK.
  ENDMETHOD.

ENDCLASS.
