@EndUserText.label: 'Grandchild TP'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

define view entity /DMO/FSA_C_GrandchildTP
  as projection on /DMO/FSA_R_GrandchildTP
{
  key ID,
      ParentID,
      RootID,
      StringProperty,
      GrandchildPieces,
      /* Associations */
      _Child : redirected to parent /DMO/FSA_C_ChildTP,
      _Root : redirected to /DMO/FSA_C_RootTP
}
