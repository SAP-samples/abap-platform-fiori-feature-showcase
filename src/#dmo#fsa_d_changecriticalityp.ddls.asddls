@EndUserText.label: 'Change criticality parameter'
define abstract entity /DMO/FSA_D_ChangeCriticalityP
{
    // Search Term #ValueHelpParameter
    @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/FSA_I_Criticality',  element: 'Code' }}]
    // Search Term #ParameterDefaultValue
    @UI.defaultValue : #( 'ELEMENT_OF_REFERENCED_ENTITY: CriticalityCode')
    criticality_code : /dmo/fsa_criticality;
}
