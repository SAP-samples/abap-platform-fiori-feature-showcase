@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Contact Value Help'

define view entity /DMO/FSA_I_ContactVH
  as select from /DMO/FSA_I_Contact
{
  key ID,
  
      @ObjectModel.text.element: ['CountryName']
      @UI.textArrangement: #TEXT_ONLY
      @EndUserText.label: 'Country'
  key Country,
  
      @Consumption.valueHelpDefault.display: false
      Name,
      
      City,
      Postcode,
      
      @Consumption.filter.hidden: true
      @Consumption.valueHelpDefault.display: false
      _Country._Text[1: Language = $session.system_language].CountryName as CountryName
     
}
