@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root'

define view entity /DMO/FSA_I_Root
  as select from /dmo/fsa_root_a
  association [0..1] to /DMO/FSA_I_Contact     as _Contact     on  $projection.ContactID = _Contact.ID
  association [0..1] to /DMO/FSA_I_Criticality as _Criticality on  $projection.CriticalityCode = _Criticality.Code
  association [0..1] to /DMO/FSA_I_Navigation  as _Navigation  on  $projection.NavigationID = _Navigation.ID
  association [0..1] to I_UnitOfMeasure        as _UoM         on  $projection.Uom = _UoM.UnitOfMeasure
  association [0..1] to I_Currency             as _Currency    on  $projection.IsoCurrency = _Currency.Currency
  association [0..1] to I_Country              as _Country     on  $projection.Country = _Country.Country
  association [0..1] to I_Region               as _Region      on  $projection.Region  = _Region.Region
                                                               and $projection.Country = _Region.Country
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

      @EndUserText.label : 'Date'
      valid_from                as ValidFrom,

      @EndUserText.label : 'To Date'
      valid_to                  as ValidTo,

      @EndUserText.label : 'Time'
      time                      as Time,

      @EndUserText.label : 'Timestamp'
      timestamp                 as Timestamp,

      @EndUserText.label : 'Description'
      description               as Description,

      @EndUserText.label : 'Second Description'
      description_customgrowing as DescriptionCustomGrowing,

      @EndUserText.label : 'Intent Based Navigation'
      @EndUserText.quickInfo: 'QuickView'
      @ObjectModel.foreignKey.association: '_Navigation'
      navigation_id             as NavigationID,

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

      _Contact,
      _Criticality,
      _Navigation,
      _UoM,
      _Currency,
      _Country,
      _Region
}
