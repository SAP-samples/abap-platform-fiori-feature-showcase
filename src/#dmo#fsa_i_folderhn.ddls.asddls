@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Folder Hierarchy Node'

// Search Term #RAPTreeview

define hierarchy /DMO/FSA_I_FolderHN
  with parameters
    P_Directory : sysuuid_x16
    
  as parent child hierarchy (
    source /DMO/FSA_I_Folder
    
    child to parent association _ParentFolder
    
    directory _Directory filter by
      RootId = $parameters.P_Directory
    
    start where ParentFolder is initial
    
    siblings order by FolderName
  )
{
    key RootId,
    key FolderId,
        ParentFolder
    
}
