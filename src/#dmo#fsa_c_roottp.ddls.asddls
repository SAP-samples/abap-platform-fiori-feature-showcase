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
      CriticalityNullValInd,
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
      IANATimestamp,
      SAPTimezone,
      IANATimezone,
      Description,
      DescriptionCustomGrowing,
      TimesChildCreated,
      TotalPieces,
      TotalGrandchildPieces,
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
      
      @Semantics.largeObject: {
        acceptableMimeTypes: [ 'image/*', 'application/*' ],
        cacheControl.maxAge: #MEDIUM,
        contentDispositionPreference: #ATTACHMENT, // #ATTACHMENT - download as file
                                                   // #INLINE - open in new window
        fileName: 'TypeSstring',
        mimeType: 'StreamMimeType'
      }
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
      TypeCuky,
      TypeLang,
      TypeUnit,
      
      /* Associations */
      _Chart : redirected to composition child /DMO/FSA_C_ChartTP,
      _Child : redirected to composition child /DMO/FSA_C_ChildTP,
      _Language,
      _Contact,
      _Country,
      _Criticality,
      _Currency,
      _Navigation,
      _Region,
      _UoM
}
