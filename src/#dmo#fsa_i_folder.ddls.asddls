@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '(Hierarchy) Folder'

// Search Term #RAPTreeview

@OData.hierarchy.recursiveHierarchy: [{ entity.name: '/DMO/FSA_I_FolderHN' }]

@UI: { 
  headerInfo: {
    typeName: 'Folder in Directory',
    typeNamePlural: 'Folders in Directory',
    title.value: 'FolderName'
  },
  presentationVariant: [
    {
      sortOrder: [{ by: 'FolderName', direction: #ASC }],
      visualizations: [{type: #AS_LINEITEM}]
    }
  ]
}

define view entity /DMO/FSA_I_Folder
  as select from /dmo/fsa_fldr_a
  association         to one /DMO/FSA_I_Root   as _Directory    on  $projection.RootId        = _Directory.ID
  association of many to one /DMO/FSA_I_Folder as _ParentFolder on  $projection.RootId        = _ParentFolder.RootId
                                                                and $projection.ParentFolder  = _ParentFolder.FolderId
{
      @UI.facet: [{
        purpose:       #STANDARD,
        type:          #IDENTIFICATION_REFERENCE,
        label:         'Folder (#RAPTreeview)',
        position:      10
      }]
    
      @UI.hidden: true
  key root_id       as RootId,
  
      @UI.hidden: true
  key folder_id     as FolderId,
  
      @UI: {
        lineItem:       [{ 
          position: 30, 
          value: '_ParentFolder.FolderName',
          label: 'Parent Folder' 
        }],
        identification: [{ 
          position: 30, 
          value: '_ParentFolder.FolderName',
          label: 'Parent Folder'  
        }]
      }
      @EndUserText.label : 'Parent Folder'
      parent_folder as ParentFolder,
      
      @UI: {
        lineItem:       [{ position: 10 }],
        identification: [{ position: 10 }]
      }
      @EndUserText.label : 'Name of Folder'
      folder_name   as FolderName,
      
      @UI: {
        lineItem:       [{ position: 20 }],
        identification: [{ position: 20 }]
      }
      @EndUserText.label : 'Size of Folder (in GB)'
      folder_size   as FolderSize,
      _Directory,
      _ParentFolder
}
