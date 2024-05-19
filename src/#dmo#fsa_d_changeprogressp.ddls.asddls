@EndUserText.label: 'Change progress parameter'
define abstract entity /DMO/FSA_D_ChangeProgressP
{
  // Search Term #ParameterDefaultValue
  @UI.defaultValue : '60'
  progress : /DMO/FSA_BT_ProgressInteger; // Search Term #SimpleType

}
