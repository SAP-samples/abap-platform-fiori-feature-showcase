@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '(Outbound) Navigation'
@ObjectModel : { resultSet.sizeCategory: #XS }

@Consumption.semanticObject: 'FeatureShowcaseNavigation'

@UI.headerInfo: {
  typeName: 'Navigation',
  typeNamePlural: 'Navigations',
  title.value: 'StringProperty',
  description.value: 'StringProperty',
  typeImageUrl: 'sap-icon://blank-tag'
}

// Search Term #QuickView
define view entity /DMO/FSA_I_Navigation
  as select from /dmo/fsa_nav
  association [0..1] to I_Country as _Country on $projection.Country = _Country.Country
{
      @UI.facet: [
        {
          type: #FIELDGROUP_REFERENCE,
          label: 'Navigation',
          targetQualifier: 'data',
          purpose: #QUICK_VIEW
        },
        {
          type: #IDENTIFICATION_REFERENCE,
          label: 'Navigational Properties'
        }
      ]
      @UI.textArrangement: #TEXT_ONLY
      @ObjectModel.text.element: ['StringProperty'] // Search Term #DisplayTextAndID
  key id               as ID,

      @EndUserText.label : 'String Property'
      @UI: {
        multiLineText: true,
        fieldGroup: [{ qualifier: 'data', position: 10 }],
        lineItem: [{ position: 1 }],
        identification: [{ position: 1 }]
      }
      string_property  as StringProperty,

      @EndUserText.label : 'Integer Property'
      @UI.fieldGroup: [{ qualifier: 'data', position: 20 }]
      integer_property as IntegerProperty,

      @EndUserText.label : 'Decimal Property'
      @UI.fieldGroup: [{ qualifier: 'data', position: 30 }]
      decimal_property as DecimalProperty,

      @UI.textArrangement: #TEXT_FIRST
      @UI.fieldGroup: [{ qualifier: 'data', position: 40 }]
      @ObjectModel.foreignKey.association: '_Country'
      @Consumption.valueHelpDefinition: [{entity: { name: 'I_Country', element: 'Country' } }]
      country          as Country,

      _Country
}
