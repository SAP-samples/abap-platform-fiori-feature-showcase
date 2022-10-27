@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root TP'
@Metadata.allowExtensions: true

@Search.searchable: true
@ObjectModel.semanticKey: ['StringProperty']

define root view entity /DMO/FSA_C_RootTP
  provider contract transactional_query
  as projection on /DMO/FSA_R_RootTP
{
  key ID,
  
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.9 }
      StringProperty,
      
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
      FieldWithPrice,
      
      ImageUrl,
      IntegerValue,
      ProgressIntegerValue,
      RadialIntegerValue,
      ForecastValue,
      TargetValue,
      Dimensions,
      StarsValue,
      ContactID,
      CriticalityCode,
      Uom,
      FieldWithQuantity,
      IsoCurrency,
      Country,
      Region,
      NavigationID,
      FieldWithCriticality,
      HarveyFieldWithPrice,
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
      CreatedBy,
      CreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      /* Associations */
      _Chart : redirected to composition child /DMO/FSA_C_ChartTP,
      _Child : redirected to composition child /DMO/FSA_C_ChildTP,
      _Contact,
      _Country,
      _Criticality,
      _Currency,
      _Navigation,
      _Region,
      _UoM
}
