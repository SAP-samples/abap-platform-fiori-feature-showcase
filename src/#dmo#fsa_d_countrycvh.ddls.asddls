@EndUserText.label: 'Country Collective Value Help'
@ObjectModel.supportedCapabilities:[#COLLECTIVE_VALUE_HELP]
@ObjectModel.modelingPattern:#COLLECTIVE_VALUE_HELP
@ObjectModel.collectiveValueHelp.for.element: 'Country'

// Search Term #CollectiveValueHelp
define abstract entity /DMO/FSA_D_CountryCVH
{
  @Consumption.valueHelpDefinition:[
    // 'Default' VH
    { 
      entity: { name:'I_Country' },
      label: 'Search by Country'
    },
    // additional VH, set qualifier
    { 
      entity: { name:'/DMO/FSA_I_ContactVH',
                element:'Country' },
      label: 'Search by Contact',
      qualifier: 'ContactSearch'
    },
    // additional VH, set qualifier
    { 
      entity: { name:'I_RegionVH',
                element:'Country' },
      additionalBinding: [{ localElement:'Region',
                            element:'Region'  }],
      label: 'Search by Region',
      qualifier:  'RegionSearch'
    }
  ]
  Country : land1;
  Region  : regio;
}
