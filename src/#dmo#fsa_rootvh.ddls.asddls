@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root VH'

define view entity /DMO/FSA_RootVH
  as select from /DMO/FSA_I_Root
{
      @ObjectModel.text.element: [ 'StringProperty' ]
      @Consumption.filter.hidden: true
  key ID,
  
      @Consumption.filter.hidden: true
      StringProperty,
      
      ValidTo,
      
      @EndUserText.label: 'Valid To'
      @Consumption.filter.hidden: true
      ValidTo as ValidToDisplay,
      
      @Consumption.filter.hidden: true
      Country,
      
      @Consumption.filter.hidden: true
      Region,
      
      @Consumption.filter.hidden: true
      FieldWithCriticality,
      
      @Consumption.filter.hidden: true
      Email,
      
      @Consumption.filter.hidden: true
      Telephone,
      
      @Consumption.filter.hidden: true
      Description,
      
      @Consumption.filter.hidden: true
      LastChangedAt
}
