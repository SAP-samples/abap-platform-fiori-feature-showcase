@EndUserText.label: 'Child TP'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

@Search.searchable: true

define view entity /DMO/FSA_C_ChildTP
  as projection on /DMO/FSA_R_ChildTP
{
  key ID,
      ParentID,

      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.9 }
      StringProperty,

      FieldWithPercent,
      BooleanProperty,
      StreamIsReadOnly, // Search Term #StreamDynamicFeatureCtrl
      CriticalityCode,
      ChildPieces,
      
      StreamFilename, // Search Term #Stream
      
      // Search Term #Stream
      @Semantics.largeObject: {
        acceptableMimeTypes: [ 'image/*', 'application/*' ],
        cacheControl.maxAge: #MEDIUM,
        contentDispositionPreference: #ATTACHMENT , // #ATTACHMENT - download as file
                                                   // #INLINE - open in new window
        fileName: 'StreamFilename',
        mimeType: 'StreamMimeType'
      }
      StreamFile,
      
      // Search Term #StreamStaticFeatureCtrl
      @Semantics.largeObject: {
        acceptableMimeTypes: [ 'image/*', 'application/*' ],
        cacheControl.maxAge: #MEDIUM,
        contentDispositionPreference: #ATTACHMENT , // #ATTACHMENT - download as file
                                                   // #INLINE - open in new window
        fileName: 'StreamFilename',
        mimeType: 'StreamMimeType'
      }
      StreamFileReadonly,
      
      // Search Term #Stream
      @Semantics.mimeType: true
      StreamMimeType,
      
      /* Associations */
      _Criticality,
      _Grandchild : redirected to composition child /DMO/FSA_C_GrandchildTP,
      _Root : redirected to parent /DMO/FSA_C_RootTP
}
