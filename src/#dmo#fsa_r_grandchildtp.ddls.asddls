@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Grandchild TP'
define view entity /DMO/FSA_R_GrandchildTP
  as select from /DMO/FSA_I_Grandchild
  association        to parent /DMO/FSA_R_ChildTP as _Child on $projection.ParentID = _Child.ID
  association [0..1] to /DMO/FSA_R_RootTP         as _Root  on $projection.RootID = _Root.ID
{
  key ID,
      ParentID,
      RootID,
      StringProperty,
      GrandchildPieces,
      _Child,
      _Root
}
