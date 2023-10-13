@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Grandchild'

define view entity /DMO/FSA_I_Grandchild
  as select from /dmo/fsa_gch_a
{
  key id              as ID,
      parent_id       as ParentID,
      root_id         as RootID,

      @EndUserText.label : 'String Property'
      string_property as StringProperty,
      
      @EndUserText.label : 'Grandchild Pieces'
      grandchild_pieces as GrandchildPieces
}
