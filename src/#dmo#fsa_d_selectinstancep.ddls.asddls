@EndUserText.label: 'Select instance parameter'

// Search Term #DefaultFunctionForAction
define abstract entity /DMO/FSA_D_SelectInstanceP
{
    @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/FSA_RootVH' , element: 'StringProperty' },
                                         additionalBinding: [{ element: 'ValidTo',
                                                               localElement: 'valid_to',
                                                               usage: #FILTER }] }]
    @EndUserText.label: 'Semantic Key'
    string_property : abap.char(256)  ;
    
    @EndUserText.label: 'Valid To'
    valid_to: abap.dats;
}
