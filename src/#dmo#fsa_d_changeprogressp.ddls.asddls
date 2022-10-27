@EndUserText.label: 'Change progress parameter'
define abstract entity /DMO/FSA_D_ChangeProgressP
{
  @EndUserText.label: 'Change Progress'
  // Search Term #ParameterDefaultValue
  @UI.defaultValue : '60'
  progress : abap.int4;

}
