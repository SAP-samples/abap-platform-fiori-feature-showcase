@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root'

define view entity /DMO/FSA_I_Root
  as select from /dmo/fsa_root_a
  association [0..1] to /DMO/FSA_I_Contact     as _Contact      on  $projection.ContactID = _Contact.ID
  association [0..1] to /DMO/FSA_I_Criticality as _Criticality  on  $projection.CriticalityCode = _Criticality.Code
  association [0..1] to /DMO/FSA_I_Navigation  as _Navigation   on  $projection.NavigationID = _Navigation.ID
  association [0..1] to I_UnitOfMeasure        as _UoM          on  $projection.Uom = _UoM.UnitOfMeasure
  association [0..1] to I_Currency             as _Currency     on  $projection.IsoCurrency = _Currency.Currency
  association [0..1] to I_Country              as _Country      on  $projection.Country = _Country.Country
  association [0..1] to I_Region               as _Region       on  $projection.Region  = _Region.Region
                                                                and $projection.Country = _Region.Country
  association [0..1] to I_Language             as _Language     on  $projection.TypeLang = _Language.Language
{
  key id                        as ID,

      @EndUserText.label : 'Field with Semantic Key'
      string_property           as StringProperty,

      @Semantics.imageUrl: true
      @EndUserText.label : 'Image'
      image_url                 as ImageUrl,

      @EndUserText.label : 'Integer Value'
      integer_value             as IntegerValue,

      @EndUserText.label : 'Forecast Value'
      forecast_value            as ForecastValue,

      @EndUserText.label : 'Target Value'
      target_value              as TargetValue,

      @EndUserText.label : 'Dimension Value'
      dimensions                as Dimensions,

      @EndUserText.label : 'Stars'
      stars_value               as StarsValue,

      @ObjectModel.foreignKey.association: '_Contact'
      @EndUserText.label : 'Contact'
      contact_id                as ContactID,

      @ObjectModel.foreignKey.association: '_Criticality'
      @EndUserText.label : 'Criticality'
      criticality_code          as CriticalityCode,

      @EndUserText.label : 'Property with Criticality'
      field_with_criticality    as FieldWithCriticality, 

      @ObjectModel.foreignKey.association: '_UoM'
      @EndUserText.label : 'Unit of Measure (#Units)'
      uom                       as Uom,

      // Search Term #Units
      @EndUserText.label : 'Property with Unit (#Units)'
      @Semantics.quantity.unitOfMeasure: 'Uom'
      field_with_quantity       as FieldWithQuantity,

      @ObjectModel.foreignKey.association: '_Currency'
      @EndUserText.label : 'Currency (#Units)'
      iso_currency              as IsoCurrency,

      // Search Term #Units
      @Semantics.amount.currencyCode: 'IsoCurrency'
      @EndUserText.label : 'Property with Currency (#Units)'
      field_with_price          as FieldWithPrice,
      
      @EndUserText.label : 'Intent Based Navigation'
      @EndUserText.quickInfo: 'QuickView'
      @ObjectModel.foreignKey.association: '_Navigation'
      navigation_id             as NavigationID, 

      // Search Term #QuickViewNullValueIndicator
      @Semantics.nullValueIndicatorFor: 'CriticalityCode'
      cast(' ' as abap_boolean preserving type ) as CriticalityNullValInd,
      
      delete_hidden             as DeleteHidden,
      update_hidden             as UpdateHidden,
      field_with_url            as FieldWithUrl,
      field_with_url_text       as FieldWithUrlText,

      // Search Term #CommunicationFields
      @Semantics.eMail.address: true
      @EndUserText.label : 'E-Mail'
      email                     as Email,

      // Search Term #CommunicationFields
      @Semantics.telephone.type: [#CELL]
      @EndUserText.label : 'Telephone'
      telephone                 as Telephone,

      @ObjectModel.foreignKey.association: '_Country'
      @EndUserText.label : 'Country'
      country                   as Country,

      @ObjectModel.foreignKey.association: '_Region'
      @EndUserText.label : 'Region'
      region                    as Region,

      @EndUserText.label : 'Valid From Date'
      valid_from                as ValidFrom,

      @EndUserText.label : 'Valid To Date'
      valid_to                  as ValidTo,

      @EndUserText.label : 'Time'
      time                      as Time,

      @EndUserText.label : 'Timestamp'
      timestamp                 as Timestamp,
      
      @EndUserText.label : 'Timezone'
      time_zone                 as SAPTimezone,

      @EndUserText.label : 'Description'
      description               as Description,

      @EndUserText.label : 'Second Description'
      description_customgrowing as DescriptionCustomGrowing,

      @EndUserText.label : 'Children Created via Root Action'
      times_child_created       as TimesChildCreated,

      @EndUserText.label : 'Total Pieces'
      total_pieces              as TotalPieces,
      
      @EndUserText.label : 'Total Grandchild Pieces'
      total_granddchild_pieces  as TotalGrandchildPieces,
      
      @Semantics.user.createdBy: true
      created_by                as CreatedBy,

      @Semantics.systemDateTime.createdAt: true
      created_at                as CreatedAt,

      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by     as LocalLastChangedBy,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at     as LocalLastChangedAt,

      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at           as LastChangedAt,
      
      @EndUserText.label: 'ACCP - Posting Period YYYYMM '
      type_accp      as TypeAccp,
      
      @EndUserText.label: 'ABAP_BOOLEAN - Boolean'
      type_bool      as TypeBool,
      
      @EndUserText.label: 'CHAR - Character String'
      type_char      as TypeChar,
      
      @EndUserText.label: 'CLNT - Client'
      type_clnt      as TypeClnt,
      
      @EndUserText.label: 'CUKY - Currency Key'
      type_cuky      as TypeCuky,
      
      @Semantics.amount.currencyCode: 'TypeCuky'
      @EndUserText.label: 'CURR - Currency Field'
      type_curr      as TypeCurr,
      
      @Semantics.amount.currencyCode: 'TypeCuky'
      @EndUserText.label: 'DEC - Currency in Decimal'
      type_dec_amount as TypeDecAmount,
      
      @EndUserText.label: 'DATN - Date Format YYYYMMDD (HANA Date)'
      type_datn      as TypeDatn,
      
      @EndUserText.label: 'DATS - Date Format YYYYMMDD'
      type_dats      as TypeDats,
      
      @EndUserText.label: 'DEC - Decimal/Packed Number'
      type_dec       as TypeDec,
      
      @EndUserText.label: 'DF16_DEC - Decimal Floating Point Number'
      type_df16_dec  as TypeDf16Dec,
      
      @EndUserText.label: 'FLTP - Floating Point Number'
      type_fltp      as TypeFltp,
      
      @EndUserText.label: 'INT1 - Unsigned 1 Byte Integer'
      type_int1      as TypeInt1,
      
      @EndUserText.label: 'INT2 - Signed 2 Byte Integer'
      type_int2      as TypeInt2,
      
      @EndUserText.label: 'INT4 - Signed 4 Byte Integer'
      type_int4      as TypeInt4,
      
      @EndUserText.label: 'INT8 - Signed 8 Byte Integer'
      type_int8      as TypeInt8,
      
      @EndUserText.label: 'LANG - Language Key'
      @Semantics.language:true
      @ObjectModel.foreignKey.association: '_Language'
      type_lang      as TypeLang,
      
      @EndUserText.label: 'NUMC - Numerical Text'
      type_numc      as TypeNumc,
      
      @Semantics.quantity.unitOfMeasure: 'TypeUnit'
      @EndUserText.label: 'QUAN - Quantity Field'
      type_quan      as TypeQuan,
      
      @Semantics.quantity.unitOfMeasure: 'TypeUnit'
      @EndUserText.label: 'FLTP - Quantity in Floating Point Number'
      type_fltp_quan as TypeFltpQuan,
      
      @EndUserText.label: 'RAWSTRING - Byte String (BLOB) (#Stream)'
      type_rawstring as TypeRawstring,
      
      @EndUserText.label: 'SSTRING - Character String'
      type_sstring   as TypeSstring,
      
      @EndUserText.label: 'STRING - Character String (BLOB)'
      type_string    as TypeString,
      
      @EndUserText.label: 'TIMN - Time format HHMMSS (HANA Time)'
      type_timn      as TypeTimn,
      
      @EndUserText.label: 'TIMS - Time format HHMMSS'
      type_tims      as TypeTims,
      
      @EndUserText.label: 'UNIT - Unit Key'
      type_unit      as TypeUnit,
      
      @EndUserText.label: 'UTCLONG - Time stamp (HANA Timestamp)'
      type_utclong   as TypeUtclong,
      
      @EndUserText.label: 'TZNTSTMPS- UTC Timestamp(YYYYMMDDhhmmss)'
      type_tzntstmps as TypeTzntstmps,
      
      @EndUserText.label: 'TZNTSTMPL- UTC Timestamp(YYYYMMDDhhmmss)'
      type_tzntstmpl as TypeTzntstmpl,
      
      @EndUserText.label: 'DEC(21,7) - Time stamp in Decimal(21,7)'
      @Semantics.dateTime:true
      type_dec_time as TypeDecTime,
      
      stream_mimetype as StreamMimeType,
      
      @EndUserText.label: 'DF34_DEC - Decimal Floating Point Number'
      type_df34_dec  as TypeDf34Dec,

      _Contact,
      _Criticality,
      _Navigation,
      _UoM,
      _Currency,
      _Country,
      _Region,
      _Language
}
