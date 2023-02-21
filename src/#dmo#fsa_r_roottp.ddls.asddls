@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root TP'

// Search Term #SemanticKey
@ObjectModel.semanticKey: ['StringProperty']

define root view entity /DMO/FSA_R_RootTP
  as select from /DMO/FSA_I_Root
  composition [0..*] of /DMO/FSA_R_ChildTP as _Child
  composition [0..*] of /DMO/FSA_R_ChartTP as _Chart
{
  key ID,
      StringProperty,
      ImageUrl,
      IntegerValue,
      IntegerValue   as RadialIntegerValue,
      ForecastValue,
      TargetValue,
      Dimensions,
      
      @EndUserText.label: 'Progress Indicator'
      IntegerValue   as ProgressIntegerValue,

      @EndUserText.label: 'Rating Indicator'
      StarsValue,

      // Search Term #ValueHelps BEGIN

      // Search Term #DependentFilter
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/FSA_I_Contact' , element: 'ID' },
                                           label: 'Contacts',
                                           additionalBinding: [{ element: 'Country',
                                                                 localElement: 'Country',
                                                                 usage: #FILTER }] }]
      ContactID,

      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/FSA_I_Criticality', element: 'Code' },
                                           additionalBinding: [{ element: 'Name',
                                                                 localElement: 'FieldWithCriticality',
                                                                 usage: #RESULT }] }]
      CriticalityCode,

      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_UnitOfMeasureStdVH', element: 'UnitOfMeasure' } }]
      Uom,

      FieldWithQuantity,

      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CurrencyStdVH', element: 'Currency' } }]
      IsoCurrency,

      // Search Term #CollectiveValueHelp
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/FSA_D_CountryCVH',  element: 'Country' },
                                           additionalBinding: [{ element: 'Region', 
                                                                 localElement: 'Region' }]  }]
      Country,

      @Consumption.valueHelpDefinition: [{entity: { name: 'I_RegionVH', element: 'Region' },
                                          additionalBinding: [{ element: 'Country',
                                                                localElement: 'Country' }] }]
      Region,

      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/FSA_I_Navigation', element: 'ID' } }]
      NavigationID,
      // Search Term #ValueHelps END

      FieldWithCriticality,
      FieldWithPrice,
      FieldWithPrice as HarveyFieldWithPrice,
      DeleteHidden,
      UpdateHidden,
      FieldWithUrl,
      FieldWithUrlText,
      Email,
      Telephone,
      ValidFrom,
      ValidTo,
      Time,
      Timestamp,
      Description,
      DescriptionCustomGrowing,
      TimesChildCreated,
      TotalPieces,
      CreatedBy,
      CreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      TypeAccp,
      TypeBool,
      TypeChar,
      TypeClnt,
      TypeCurr,
      TypeDecAmount,
      TypeDatn,
      TypeDats,
      TypeDec,
      TypeDf16Dec,
      TypeDf34Dec,
      TypeFltp,
      TypeInt1,
      TypeInt2,
      TypeInt4,
      TypeInt8,
      TypeNumc,
      TypeQuan,
      TypeFltpQuan,
      TypeRawstring,
      TypeSstring,
      TypeString,
      TypeTimn,
      TypeTims,
      TypeUtclong,
      TypeTzntstmps,
      TypeTzntstmpl,
      TypeDecTime,
      StreamMimeType,
      
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CurrencyStdVH', element: 'Currency' } }]
      TypeCuky,
      
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Language', element: 'Language' } }]
      TypeLang,
      
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_UnitOfMeasureStdVH', element: 'UnitOfMeasure' } }]
      TypeUnit,
      /* Associations */
      _Contact,
      _Country,
      _Criticality,
      _Currency,
      _Navigation,
      _Region,
      _UoM,
      _Child,
      _Chart,
      _Language
}
