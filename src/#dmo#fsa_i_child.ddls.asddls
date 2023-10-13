@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Child'

define view entity /DMO/FSA_I_Child
  as select from /dmo/fsa_child_a
  association [0..1] to /DMO/FSA_I_Criticality as _Criticality on $projection.CriticalityCode = _Criticality.Code
{
  key id                 as ID,
      parent_id          as ParentID,

      @EndUserText.label : 'String Property'
      string_property    as StringProperty,

      @EndUserText.label : 'Percentage Property'
      field_with_percent as FieldWithPercent,

      @EndUserText.label : 'Boolean Property'
      boolean_property   as BooleanProperty,

      @ObjectModel.foreignKey.association: '_Criticality'
      criticality_code   as CriticalityCode,
      
      @EndUserText.label : 'Stream File'
      stream_file        as StreamFile,
      
      @EndUserText.label : 'Stream Filename'
      stream_filename    as StreamFilename,
      
      @EndUserText.label : 'Stream Mime Type'
      stream_mimetype    as StreamMimeType,
      
      @EndUserText.label : 'Child Pieces'
      child_pieces       as ChildPieces,
      
      _Criticality

}
