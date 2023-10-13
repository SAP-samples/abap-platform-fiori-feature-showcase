@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Criticality'
@ObjectModel : { resultSet.sizeCategory: #XS }

@UI.headerInfo: {
  description.label: ''
}

define view entity /DMO/FSA_I_Criticality
  as select from /dmo/fsa_critlty
{
      // Search Term #QuickViewNullValueIndicator
      @UI.facet: [
        {
          type: #FIELDGROUP_REFERENCE,
          label: 'Criticality (#QuickViewNullValueIndicator)',
          targetQualifier: 'QuickView',
          purpose: #QUICK_VIEW
        }
      ]
      
      @UI: {
        fieldGroup: [
          { 
            qualifier: 'QuickView', 
            position: 10
          }
        ]
      }
      @ObjectModel.text.element: ['Name'] // Search Term #DisplayTextAndID
      @EndUserText.label: 'Code'
  key code  as Code,

      name  as Name,
      
      // Search Term #QuickViewNullValueIndicator
      @UI.fieldGroup: [
        {
          qualifier: 'QuickView', 
          position: 20 
        }
      ]
      @EndUserText.label: 'Description of Criticality'
      @Consumption.valueHelpDefault.display: false
      descr as Description
}
