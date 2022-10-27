@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Criticality'
@ObjectModel : { resultSet.sizeCategory: #XS }

define view entity /DMO/FSA_I_Criticality
  as select from /dmo/fsa_critlty
{
      @ObjectModel.text.element: ['Name'] // Search Term #DisplayTextAndID
  key code  as Code,

      name  as Name,
      descr as Description
}
