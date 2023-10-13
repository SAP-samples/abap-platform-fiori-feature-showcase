@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Contact'

// Search Term #AddressFacet, #Contact
define view entity /DMO/FSA_I_Contact
  as select from /dmo/fsa_contact
  association [0..1] to I_Country as _Country on $projection.Country = _Country.Country
{
      @ObjectModel.text.element: ['Name'] // Search Term #DisplayTextAndID
      @UI.textArrangement: #TEXT_ONLY
      @EndUserText.label: 'Contact'
      @Consumption.filter.hidden: true
  key id            as ID,

      @Semantics.name.fullName: true
      @Consumption.valueHelpDefault.display:true
      name          as Name,

      @Semantics.telephone.type: [#PREF]
      @Consumption.valueHelpDefault.display:true
      phone         as Phone,

      @Consumption.valueHelpDefault.display:false
      @Consumption.filter.hidden: true
      building      as Building,

      @Semantics.address.country: true
      @Consumption.valueHelpDefault.display:false
//      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CountryVH', element: 'Country' } }]
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Country', element: 'Country' } }]
      @EndUserText.label: 'Country'
      country       as Country,

      @Consumption.valueHelpDefault.display:true
      @Consumption.filter.hidden: true
      @ObjectModel.text.element: ['CountryName']
      @UI.textArrangement: #TEXT_ONLY
      @EndUserText.label: 'Country'
      country       as CountryDisplay, // needed, to show country in VH list
      
      @Semantics.address.street: true
      @Consumption.valueHelpDefault.display:true
      street        as Street,

      @Semantics.address.city: true
      @Consumption.valueHelpDefault.display:true
      city          as City,

      @Semantics.address.zipCode: true
      @Consumption.valueHelpDefault.display:true
      postcode      as Postcode,

      @Semantics.address.label: true
      @Consumption.valueHelpDefault.display:false
      @Consumption.filter.hidden: true
      address_label as AddressLabel,

      @Consumption.valueHelpDefault.display:false
      @Consumption.filter.hidden: true
      photo_url     as PhotoUrl,
      
      @Semantics.eMail.type: [ #PREF ]
      @Consumption.valueHelpDefault.display:true
      email         as Email,
      
      @Consumption.filter.hidden: true
      @Consumption.valueHelpDefault.display: false
      _Country._Text[1: Language = $session.system_language].CountryName as CountryName,
      _Country
}
