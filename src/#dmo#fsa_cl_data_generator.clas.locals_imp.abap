CLASS lcl_abstract DEFINITION ABSTRACT.

  PUBLIC SECTION.
    CLASS-METHODS:
      class_constructor.

  PROTECTED SECTION.
    TYPES:
      BEGIN OF ts_location,
        building     TYPE /dmo/fsa_contact-building,
        country      TYPE /dmo/fsa_contact-country,
        street       TYPE /dmo/fsa_contact-street,
        city         TYPE /dmo/fsa_contact-city,
        postcode     TYPE /dmo/fsa_contact-postcode,
        addresslabel TYPE /dmo/fsa_contact-address_label,
      END OF ts_location,
      tt_location TYPE STANDARD TABLE OF ts_location WITH EMPTY KEY,

      BEGIN OF ts_region,
        region  TYPE /dmo/fsa_root_a-region,
        country TYPE /dmo/fsa_root_a-country,
      END OF ts_region,
      tt_region TYPE STANDARD TABLE OF ts_region WITH EMPTY KEY.

    CLASS-DATA:
      go_rnd TYPE REF TO cl_abap_random_float.

    CLASS-METHODS:
      get_uuid
        RETURNING
          VALUE(rv_uuid)            TYPE sysuuid_x16,
      get_string
        IMPORTING
          length                    TYPE i
        RETURNING
          VALUE(rv_string)          TYPE string,
      get_name
        RETURNING
          VALUE(rv_name)            TYPE string,
      get_email
        IMPORTING
          name                      TYPE string OPTIONAL
        RETURNING
          VALUE(rv_email)           TYPE string,
      get_int4
        IMPORTING
          min                       TYPE i DEFAULT -2147483648
          max                       TYPE i DEFAULT 2147483647
        RETURNING
          VALUE(rv_int4)            TYPE i,
      get_phonenumber
        RETURNING
          VALUE(rv_phonenumber)     TYPE string,
      get_image_url
        RETURNING
          VALUE(rv_image_url)       TYPE string,
      get_field_with_quantity
        RETURNING
          VALUE(rv_dec)             TYPE /dmo/fsa_root_a-field_with_quantity,
      get_price
        RETURNING
          VALUE(rv_dec)             TYPE /dmo/fsa_root_a-field_with_price,
      get_location
        RETURNING
          VALUE(rs_location)        TYPE ts_location,
      get_uom
        RETURNING
          VALUE(rv_uom)             TYPE msehi,
      get_currency_code
        RETURNING
          VALUE(rv_curky)           TYPE waers_curc,
      get_percent
        RETURNING
          VALUE(rv_percent)         TYPE /dmo/fsa_child_a-field_with_percent,
      get_boolean
        RETURNING
          VALUE(rv_boolean)         TYPE abap_boolean,
      get_region_and_country
        RETURNING
          VALUE(rs_region)          TYPE ts_region,
      get_string_property
        IMPORTING
          iv_entity                 TYPE string
        RETURNING
          VALUE(rv_string_property) TYPE string.
  PRIVATE SECTION.
    CLASS-DATA:
      gt_uom    TYPE STANDARD TABLE OF msehi,
      gt_curky  TYPE STANDARD TABLE OF waers_curc,
      gt_region TYPE tt_region.
ENDCLASS.

CLASS lcl_abstract IMPLEMENTATION.

  METHOD class_constructor.
    go_rnd = cl_abap_random_float=>create( CONV i( cl_abap_context_info=>get_system_time( ) ) ).
  ENDMETHOD.

  METHOD get_uuid.
    TRY.
        rv_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      CATCH cx_uuid_error INTO DATA(lx).
        RAISE SHORTDUMP lx.
    ENDTRY.
  ENDMETHOD.

  METHOD get_string.
    DATA: lt_lorem TYPE STANDARD TABLE OF string WITH DEFAULT KEY.
    lt_lorem = VALUE #(
        ( `Lorem` )
        ( `ipsum` )
        ( `dolor` )
        ( `sit` )
        ( `amet` )
        ( `consetetur` )
        ( `sadipscing` )
        ( `elitr` )
        ( `sed` )
        ( `diam` )
        ( `nonumy` )
        ( `eirmod` )
        ( `tempor` )
        ( `invidunt` )
        ( `ut` )
        ( `labore` )
        ( `et` )
        ( `dolore` )
        ( `magna` )
        ( `aliquyam` )
        ( `erat` )
        ( `sed` )
        ( `diam` )
        ( `voluptua` )
        ( `At` )
        ( `vero` )
        ( `eos` )
        ( `et` )
        ( `accusam` )
        ( `et` )
        ( `justo` )
        ( `duo` )
        ( `dolores` )
        ( `et` )
        ( `ea` )
        ( `rebum` )
        ( `Stet` )
        ( `clita` )
        ( `kasd` )
        ( `gubergren` )
        ( `no` )
        ( `sea` )
        ( `takimata` )
        ( `sanctus` )
        ( `est` )
        ( `Lorem` )
        ( `ipsum` )
        ( `dolor` )
        ( `sit` )
        ( `amet` )
        ( `Lorem` ) ##NO_TEXT
        ( `ipsum` )
        ( `dolor` )
        ( `sit` )
        ( `amet` )
        ( `consetetur` )
        ( `sadipscing` )
        ( `elitr` )
        ( `sed` )
        ( `diam` )
        ( `nonumy` )
        ( `eirmod` )
        ( `tempor` )
        ( `invidunt` )
        ( `ut` )
        ( `labore` )
        ( `et` )
        ( `dolore` )
        ( `magna` )
        ( `aliquyam` )
        ( `erat` )
        ( `sed` )
        ( `diam` )
        ( `voluptua` )
        ( `At` )
        ( `vero` )
        ( `eos` )
        ( `et` )
        ( `accusam` )
        ( `et` )
        ( `justo` )
        ( `duo` )
        ( `dolores` )
        ( `et` )
        ( `ea` )
        ( `rebum` )
        ( `Stet` )
        ( `clita` )
        ( `kasd` )
        ( `gubergren` )
        ( `no` )
        ( `sea` )
        ( `takimata` )
        ( `sanctus` )
        ( `est` )
        ( `Lorem` ) ##NO_TEXT
        ( `ipsum` )
        ( `dolor` )
        ( `sit` )
        ( `amet` )
      ).

    DATA(lv_string) = lt_lorem[ floor( lines( lt_lorem ) * go_rnd->get_next( ) ) + 1 ].
    DATA(lv_length) = strlen( lv_string ) - 1.
    rv_string = |{ to_upper( lv_string+0(1) ) }{ lv_string+1(lv_length) }|.

    DO floor( go_rnd->get_next( ) * length + 1 ) TIMES.
      rv_string &&= ` ` && lt_lorem[ floor( lines( lt_lorem ) * go_rnd->get_next( ) ) + 1 ].
    ENDDO.
    rv_string &&= `.`.
  ENDMETHOD.

  METHOD get_int4.
    rv_int4 = floor( go_rnd->get_next( ) * ( max - min ) + min ).
  ENDMETHOD.

  METHOD get_phonenumber.
    rv_phonenumber = `+` && get_int4( min = 1  max = 99 ) && ` ` && get_int4( min = 1000000  max = 99999999 ).
  ENDMETHOD.

  METHOD get_image_url.
    DATA: lt_lorem TYPE STANDARD TABLE OF string WITH DEFAULT KEY.
    lt_lorem = VALUE #(
        ( |sap-icon://lab| )
        ( |sap-icon://cart| )
      ).

    rv_image_url = lt_lorem[ floor( lines( lt_lorem ) * go_rnd->get_next( ) ) + 1 ].
  ENDMETHOD.

  METHOD get_field_with_quantity.
    rv_dec = go_rnd->get_next( ) * 10000 .
  ENDMETHOD.

  METHOD get_name.
    DATA:
      lt_first_name TYPE STANDARD TABLE OF string,
      lt_sur_name   TYPE STANDARD TABLE OF string.

    lt_first_name = VALUE #( ##NO_TEXT
                ( `Simon`  )
                ( `Harish`  )
                ( `Volker`  )
                ( `Jasmin`  )
                ( `Felix`  )
                ( `Kristina`  )
                ( `Thilo`  )
                ( `Andrej`  )
                ( `Anna`  )
                ( `Johannes` )
                ( `Johann`  )
                ( `Christoph` )
                ( `Andreas` )
                ( `Stephen` )
                ( `Mathilde` )
                ( `August`  )
                ( `Illya`  )
                ( `Georg`  )
                ( `Gisela`  )
                ( `Christa` )
                ( `Holm`  )
                ( `Irmtraut` )
                ( `Ludwig`  )
                ( `Laura`  )
                ( `Kurt`  )
                ( `Guenther` )
                ( `Horst`  )
                ( `Matthias` )
                ( `Amelie`  )
                ( `Walter`  )
                ( `Sophie`  )
                ( `Claire`  )
                ( `Chantal` )
                ( `Jean`  )
                ( `Cindy`  )
                ( `Pierre`  )
                ( `Irene`  )
                ( `Adam`  )
                ( `Fabio`  )
                ( `Lothar`  )
                ( `Annemarie` )
                ( `Ida`  )
                ( `Roland`  )
                ( `Achim`  )
                ( `Allen`  )
                ( `Lee`  )
                ( `Guillermo` )
                ( `Florian` )
                ( `Ulla`  )
                ( `Juan`  )
                ( `Marta`  )
                ( `Salvador` )
                ( `Christine` )
                ( `Dominik` )
                ( `Astrid`  )
                ( `Ruth`  )
                ( `Theresia` )
                ( `Thomas`  )
                ( `Friedrich` )
                ( `Anneliese` )
                ( `Peter`  )
                ( `Anne-Marie` )
                ( `James`  )
                ( `Jean-Luc` )
                ( `Benjamin` )
                ( `Hendrik` )
                ( `Uli`  )
                ( `Siegfried` )
                ( `Max` )
              ).

    lt_sur_name = VALUE #( ##NO_TEXT ##STRING_OK
          ( `Buchholm` )
          ( `Vrsic` )
          ( `Jeremias` )
          ( `Gutenberg` )
          ( `Fischmann` )
          ( `Columbo` )
          ( `Neubasler` )
          ( `Martin` )
          ( `Detemple` )
          ( `Barth` )
          ( `Benz` )
          ( `Hansmann` )
          ( `Koslowski` )
          ( `Wohl` )
          ( `Koller` )
          ( `Hoffen` )
          ( `Dumbach` )
          ( `Goelke` )
          ( `Waldmann` )
          ( `Mechler` )
          ( `Buehler` )
          ( `Heller` )
          ( `Simonen` )
          ( `Henry` )
          ( `Marshall` )
          ( `Legrand` )
          ( `Jacqmain` )
          ( `D´Oultrement` )
          ( `Hunter` )
          ( `Delon` )
          ( `Kreiss` )
          ( `Trensch` )
          ( `Cesari` )
          ( `Matthaeus` )
          ( `Babilon` )
          ( `Zimmermann` )
          ( `Kramer` )
          ( `Illner` )
          ( `Pratt` )
          ( `Gahl` )
          ( `Benjamin` )
          ( `Miguel` )
          ( `Weiss` )
          ( `Sessler` )
          ( `Montero` )
          ( `Domenech` )
          ( `Moyano` )
          ( `Sommer` )
          ( `Schneider` )
          ( `Eichbaum` )
          ( `Gueldenpfennig` )
          ( `Sudhoff` )
          ( `Lautenbach` )
          ( `Ryan` )
          ( `Prinz` )
          ( `Deichgraeber` )
          ( `Pan` )
          ( `Lindwurm` )
          ( `Kirk` )
          ( `Picard` )
          ( `Sisko` )
          ( `Madeira` )
          ( `Meier` )
          ( `Rahn` )
          ( `Leisert` )
          ( `Müller` )
          ( `Mustermann` )
          ( `Becker` )
          ( `Fischer` )
      ).

    rv_name =
      lt_first_name[ floor( lines( lt_first_name ) * go_rnd->get_next( ) ) + 1 ]
      && ` ` &&
      lt_sur_name[ floor( lines( lt_sur_name ) * go_rnd->get_next( ) ) + 1 ].
  ENDMETHOD.

  METHOD get_email.
    DATA(lv_mail) = COND #( WHEN name IS SUPPLIED THEN name
                                                  ELSE get_name( ) ).
    REPLACE ALL OCCURRENCES OF ` ` IN lv_mail WITH '.'.
    rv_email = lv_mail && '@mail.example'.
  ENDMETHOD.

  METHOD get_location.
    DATA(lt_location) = VALUE tt_location(
        ( building = 'WDF02'                         country = 'DE'  street = 'Dietmar-Hopp-Allee 16'              city = 'Walldorf'      postcode = '69190' )
        ( building = 'Victoria Center - Batiment A3' country = 'FR'  street = '20 Chemin de Laporte'               city = 'Toulouse'      postcode = '31300' )
        ( building = 'Millennium Tower'              country = 'CA'  street = '999 de Maisonneuve Boulevard West'  city = 'Montreal'      postcode = 'H3A 3L4' )
        ( building = '5th Floor G-Block'             country = 'IN'  street = 'C-59 BKC Bandra East'               city = 'Mumbai'        postcode = '400 051' )
        ( building = 'AKL02-151'                     country = 'NZ'  street = '151 Queen Street'                   city = 'Auckland'      postcode = '1010' ) ##NO_TEXT
        ( building = 'Edificio Torre Diagonal Mar.'  country = 'ES'  street = 'c/Josep Pla, no 2. Planta 13'       city = 'Barcelona'     postcode = '08019' ) ##NO_TEXT
        ( building = 'BOS04'                         country = 'US'  street = '53 State Street'                    city = 'Boston'        postcode = '02109' ) ##NO_TEXT
        ( building = 'KUL04--Menara Southpoint'      country = 'MY'  street = 'Medan Syed Putra Selata'            city = 'Kuala Lumpur'  postcode = '59200' ) ##NO_TEXT
        ( building = 'ROT15'                         country = 'DE'  street = 'SAP-Allee 15'                       city = 'St. Leon-Rot'  postcode = '68789' ) ##NO_TEXT
      ).
    rs_location = lt_location[ floor( lines( lt_location ) * go_rnd->get_next( ) ) + 1 ].
    rs_location-addresslabel = |{ rs_location-building }\n{ rs_location-street }\n{ rs_location-postcode } { rs_location-city }\n{ rs_location-country }|.
  ENDMETHOD.

  METHOD get_uom.
    IF gt_uom IS INITIAL.
      SELECT
        FROM i_unitofmeasurestdvh
        FIELDS unitofmeasure
        WHERE UnitOfMeasureLongName IS NOT INITIAL
        INTO TABLE @gt_uom.
    ENDIF.

    rv_uom = gt_uom[ floor( lines( gt_uom ) * go_rnd->get_next( ) ) + 1 ].
  ENDMETHOD.

  METHOD get_price.
    rv_dec = go_rnd->get_next( ) * 10000 .
  ENDMETHOD.

  METHOD get_currency_code.
    IF gt_curky IS INITIAL.
      SELECT
        FROM i_currencystdvh
        FIELDS currency
        INTO TABLE @gt_curky. "#EC CI_NOWHERE
    ENDIF.

    rv_curky = gt_curky[ floor( lines( gt_curky ) * go_rnd->get_next( ) ) + 1 ].
  ENDMETHOD.

  METHOD get_percent.
    rv_percent = go_rnd->get_next( ) * 101 .
    IF rv_percent > '100.00'.
      rv_percent = '99.99'.
    ENDIF.
  ENDMETHOD.

  METHOD get_boolean.
    rv_boolean = COND #(
        WHEN go_rnd->get_next( ) < '0.5'
          THEN abap_false
          ELSE abap_true
      ).
  ENDMETHOD.

  METHOD get_region_and_country.
    IF gt_uom IS INITIAL.
      SELECT
        FROM i_regionvh
        FIELDS region, country
        INTO CORRESPONDING FIELDS OF TABLE @gt_region. "#EC CI_NOWHERE
    ENDIF.

    rs_region = gt_region[ floor( lines( gt_region ) * go_rnd->get_next( ) ) + 1 ].
  ENDMETHOD.

  METHOD get_string_property.
    rv_string_property = |{ iv_entity } { floor( 1000 * go_rnd->get_next( ) ) + 1  }.|.
  ENDMETHOD.

ENDCLASS.






""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""




CLASS lcl_fsa_contact DEFINITION CREATE PUBLIC INHERITING FROM lcl_abstract.

  PUBLIC SECTION.
    TYPES:
     tt_contact TYPE STANDARD TABLE OF /dmo/fsa_contact WITH KEY id.

    CLASS-METHODS:
      generate
        RETURNING
          VALUE(rt_contact) TYPE tt_contact,
      get
        RETURNING
          VALUE(rs_contact) TYPE /dmo/fsa_contact.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA:
      gt_contact TYPE tt_contact.

    CLASS-METHODS:
      _generate.

ENDCLASS.

CLASS lcl_fsa_contact IMPLEMENTATION.

  METHOD generate.
    IF gt_contact IS INITIAL.
      _generate( ).
    ENDIF.

    rt_contact = gt_contact.
  ENDMETHOD.

  METHOD _generate.

    DO get_int4( min = 4  max = 250 ) TIMES.
      DATA(ls_location) = get_location( ).
      DATA(ls_name) = get_name( ).
      APPEND VALUE /dmo/fsa_contact(
          id              = get_uuid( )
          name            = ls_name
          phone           = get_phonenumber( )
          building        = ls_location-building
          country         = ls_location-country
          street          = ls_location-street
          city            = ls_location-city
          postcode        = ls_location-postcode
          address_label   = ls_location-addresslabel
          email           = get_email( ls_name )
*          photourl     =
      ) TO gt_contact.
    ENDDO.
  ENDMETHOD.

  METHOD get.
    IF gt_contact IS INITIAL.
      _generate( ).
    ENDIF.

    rs_contact = gt_contact[ floor( lines( gt_contact ) * go_rnd->get_next( ) ) + 1 ].
  ENDMETHOD.

ENDCLASS.





""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""




CLASS lcl_fsa_criticality DEFINITION CREATE PUBLIC INHERITING FROM lcl_abstract.

  PUBLIC SECTION.
    TYPES:
     tt_criticality TYPE STANDARD TABLE OF /dmo/fsa_critlty WITH KEY code.

    CLASS-METHODS:
      generate
        RETURNING
          VALUE(rt_criticality) TYPE tt_criticality,
      get
        RETURNING
          VALUE(rs_criticality) TYPE /dmo/fsa_critlty.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA:
      gt_criticality TYPE tt_criticality.

    CLASS-METHODS:
      _generate.

ENDCLASS.

CLASS lcl_fsa_criticality IMPLEMENTATION.

  METHOD generate.
    IF gt_criticality IS INITIAL.
      _generate( ).
    ENDIF.

    rt_criticality = gt_criticality.
  ENDMETHOD.

  METHOD _generate.
    gt_criticality = VALUE #(
        ( code = '0'  name = 'Neutral'   descr = 'Criticality shown as grey'  ) ##NO_TEXT
        ( code = '1'  name = 'Negative'  descr = 'Criticality shown as red' ) ##NO_TEXT
        ( code = '2'  name = 'Critical'  descr = 'Criticality shown as orange' ) ##NO_TEXT
        ( code = '3'  name = 'Positive'  descr = 'Criticality shown as green' ) ##NO_TEXT
        ( code = '5'  name = 'New Item'  descr = 'Criticality shown as blue' ) ##NO_TEXT
      ).
  ENDMETHOD.

  METHOD get.
    IF gt_criticality IS INITIAL.
      _generate( ).
    ENDIF.

    rs_criticality = gt_criticality[ floor( lines( gt_criticality ) * go_rnd->get_next( ) ) + 1 ].
  ENDMETHOD.

ENDCLASS.





""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""





CLASS lcl_fsa_navigation DEFINITION CREATE PUBLIC INHERITING FROM lcl_abstract.

  PUBLIC SECTION.
    TYPES:
     tt_navigation TYPE STANDARD TABLE OF /dmo/fsa_nav WITH KEY id.

    CLASS-METHODS:
      generate
        RETURNING
          VALUE(rt_navigation) TYPE tt_navigation,
      get
        RETURNING
          VALUE(rs_navigation) TYPE /dmo/fsa_nav.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA:
      gt_navigation TYPE tt_navigation.

    CLASS-METHODS:
      _generate.
ENDCLASS.

CLASS lcl_fsa_navigation IMPLEMENTATION.

  METHOD generate.
    IF gt_navigation IS INITIAL.
      _generate( ).
    ENDIF.

    rt_navigation = gt_navigation.
  ENDMETHOD.

  METHOD _generate.
    DO get_int4( min = 4  max = 50 ) TIMES.
      APPEND VALUE /dmo/fsa_nav(
          id                = get_uuid( )
          string_property   = get_string( 5 )
          integer_property  = get_int4( min = 0  max = 1024 )
          decimal_property  = get_percent( )
          country           = get_location( )-country
        ) TO gt_navigation.
    ENDDO.
  ENDMETHOD.

  METHOD get.
    IF gt_navigation IS INITIAL.
      _generate( ).
    ENDIF.

    rs_navigation = gt_navigation[ floor( lines( gt_navigation ) * go_rnd->get_next( ) ) + 1 ].
  ENDMETHOD.

ENDCLASS.





""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""





CLASS lcl_fsa_root DEFINITION CREATE PUBLIC INHERITING FROM lcl_abstract.

  PUBLIC SECTION.
    TYPES:
     tt_root TYPE STANDARD TABLE OF /dmo/fsa_root_a WITH KEY id.

    CLASS-METHODS:
      generate
        RETURNING
          VALUE(rt_root) TYPE tt_root.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA:
      gt_root TYPE tt_root.

    CLASS-METHODS:
      _generate.
ENDCLASS.

CLASS lcl_fsa_root IMPLEMENTATION.

  METHOD generate.
    IF gt_root IS INITIAL.
      _generate( ).
    ENDIF.

    rt_root = gt_root.
  ENDMETHOD.

  METHOD _generate.
    GET TIME STAMP FIELD DATA(lv_timestampl).

    DO get_int4( min = 10  max = 25 ) TIMES.
      DATA(ls_region) = get_region_and_country( ).
      DATA(lv_criticality) = lcl_fsa_criticality=>get( ).
      DATA(lv_update) = get_boolean( ).
      DATA(lv_delete) = get_boolean( ).
      DATA(lv_string_property) = get_string_property( 'Root entity' ) ##NO_TEXT .

      IF lv_update = abap_true AND lv_delete = abap_true.
        lv_string_property = lv_string_property && | Delete and update not possible.| ##NO_TEXT .
      ELSE.
        IF lv_update = abap_true.
          lv_string_property = lv_string_property && | Update not possible.| ##NO_TEXT .
        ELSEIF lv_delete = abap_true.
          lv_string_property = lv_string_property && | Delete not possible.| ##NO_TEXT .
        ENDIF.
      ENDIF.

      TRY.
          DATA(lv_timezone) = cl_abap_context_info=>get_user_time_zone( ).
        CATCH cx_abap_context_info_error.
          lv_timezone = |CET|.
      ENDTRY.

      APPEND VALUE /dmo/fsa_root_a(
          id                        = get_uuid( )
          image_url                 = get_image_url( )
          string_property           = lv_string_property
          integer_value             = get_int4( min = 1  max = 100 )
          forecast_value            = get_int4( min = 1  max = 100 )
          target_value              = get_int4( min = 1  max = 100 )
          dimensions                = get_int4( min = 1  max = 100 )
          stars_value               = go_rnd->get_next( ) * 4
          contact_id                = lcl_fsa_contact=>get( )-id
          criticality_code          = lv_criticality-code
          field_with_quantity       = get_field_with_quantity( )
          uom                       = get_uom( )
          field_with_price          = get_price( )
          iso_currency              = get_currency_code( )
          field_with_criticality    = lv_criticality-name
          delete_hidden             = lv_delete
          update_hidden             = lv_update
          field_with_url            = |https://www.sap.com|
          field_with_url_text       = |SAP|
          email                     = get_email( )
          telephone                 = get_phonenumber( )
          country                   = ls_region-country
          region                    = ls_region-region
          valid_from                = cl_abap_context_info=>get_system_date( ) - get_int4( min = 0   max = 120 )
          valid_to                  = cl_abap_context_info=>get_system_date( ) + get_int4( min = 0   max = 240 )
          time                      = cl_abap_context_info=>get_system_time( ) - get_int4( min = 0   max = 3600 )
          timestamp                 = lv_timestampl
          time_zone                 = lv_timezone
          description               = get_string( 55 )
          description_customgrowing = get_string( 55 )
          navigation_id             = lcl_fsa_navigation=>get( )-id
          created_by                = |GENERATOR|
          created_at                = lv_timestampl
          local_last_changed_by     = |GENERATOR|
          local_last_changed_at     = lv_timestampl
          last_changed_at           = lv_timestampl
      ) TO gt_root.

    ENDDO.
  ENDMETHOD.

ENDCLASS.





""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""





CLASS lcl_fsa_chart DEFINITION CREATE PUBLIC INHERITING FROM lcl_abstract.

  PUBLIC SECTION.
    TYPES:
     tt_chart TYPE STANDARD TABLE OF /dmo/fsa_chart_a WITH KEY id.

    CLASS-METHODS:
      generate
        RETURNING
          VALUE(rt_chart) TYPE tt_chart.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA:
      gt_chart TYPE tt_chart.

    CLASS-METHODS:
      _generate.
ENDCLASS.

CLASS lcl_fsa_chart IMPLEMENTATION.

  METHOD generate.
    IF gt_chart IS INITIAL.
      _generate( ).
    ENDIF.

    rt_chart = gt_chart.
  ENDMETHOD.

  METHOD _generate.
    LOOP AT lcl_fsa_root=>generate( ) INTO DATA(ls_root).
      DO get_int4( min = 4  max = 10 ) TIMES.
        APPEND VALUE /dmo/fsa_chart_a(
            id                              = get_uuid( )
            parent_id                       = ls_root-id
            criticality_code                = lcl_fsa_criticality=>get( )-code
            integer_value                   = get_int4( min = 0  max = 100 )
            integer_value_for_line_chart    = get_int4( min = 0  max = 256 )
            uom                             = get_uom( )
            forecast_value                  = get_int4( min = 0    max = 256 )
            target_value                    = get_int4( min = 128  max = 512 )
            dimensions                      = get_int4( min = 0  max = 10 )
            areachart_tol_upperbound_value  = get_int4( min = 256  max = 512 )
            areachart_tol_lowerbound_value  = get_int4( min = 0  max = 256 )
            areachart_dev_upperbound_value  = get_int4( min = 256  max = 512 )
            areachart_dev_lowerbound_value  = get_int4( min = 0  max = 256 )
          ) TO gt_chart.
      ENDDO.
    ENDLOOP.

    SORT gt_chart BY dimensions.
  ENDMETHOD.

ENDCLASS.




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""





CLASS lcl_fsa_child DEFINITION CREATE PUBLIC INHERITING FROM lcl_abstract.

  PUBLIC SECTION.
    TYPES:
     tt_child TYPE STANDARD TABLE OF /dmo/fsa_child_a WITH KEY id.

    CLASS-METHODS:
      generate
        RETURNING
          VALUE(rt_child) TYPE tt_child.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA:
      gt_child TYPE tt_child.

    CLASS-METHODS:
      _generate.
ENDCLASS.

CLASS lcl_fsa_child IMPLEMENTATION.

  METHOD generate.
    IF gt_child IS INITIAL.
      _generate( ).
    ENDIF.

    rt_child = gt_child.
  ENDMETHOD.

  METHOD _generate.
    LOOP AT lcl_fsa_root=>generate( ) INTO DATA(ls_root).
      DO get_int4( min = 4  max = 30 ) TIMES.
        APPEND VALUE /dmo/fsa_child_a(
            id                  = get_uuid( )
            parent_id           = ls_root-id
            string_property     = get_string_property( 'Child entity' ) ##NO_TEXT
            field_with_percent  = get_percent( )
            boolean_property    = get_boolean( )
            criticality_code    = lcl_fsa_criticality=>get( )-code
          ) TO gt_child.
      ENDDO.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.





""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""








CLASS lcl_fsa_grandchild DEFINITION CREATE PUBLIC INHERITING FROM lcl_abstract.

  PUBLIC SECTION.
    TYPES:
     tt_grandchild TYPE STANDARD TABLE OF /dmo/fsa_gch_a WITH KEY id.

    CLASS-METHODS:
      generate
        RETURNING
          VALUE(rt_grandchild) TYPE tt_grandchild.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA:
      gt_grandchild TYPE tt_grandchild.

    CLASS-METHODS:
      _generate.
ENDCLASS.

CLASS lcl_fsa_grandchild IMPLEMENTATION.

  METHOD generate.
    IF gt_grandchild IS INITIAL.
      _generate( ).
    ENDIF.

    rt_grandchild = gt_grandchild.
  ENDMETHOD.

  METHOD _generate.
    LOOP AT lcl_fsa_child=>generate( ) INTO DATA(ls_child).
      DO get_int4( min = 4  max = 30 ) TIMES.
        APPEND VALUE /dmo/fsa_gch_a(
            id              = get_uuid( )
            parent_id       = ls_child-id
            root_id         = ls_child-parent_id
            string_property = get_string( 10 )
          ) TO gt_grandchild.
      ENDDO.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
