@EndUserText.label: 'Oerwrite Timezone parameter'
define root abstract entity /DMO/FSA_D_OverwriteTimezoneP
{
    // Search Term #MandatoryParameter
    @EndUserText.label: 'Timezone (#MandatoryParameter)'
    @Consumption.valueHelpDefinition: [{ entity: { name: 'I_TimeZoneIANACodeMap', element: 'TimeZoneID' },
                                         additionalBinding: [{ usage: #RESULT, localElement: 'iana_timezone', element: 'TimeZoneIANACode' }] }]
    sap_timezone : tznzone;
    
    // Search Term #IANATimezoneAParameter
    @Semantics.timeZone: true
    @EndUserText.label: 'IANA timezone (#IANATimezoneAParameter)'
    iana_timezone : tznzone;
}
