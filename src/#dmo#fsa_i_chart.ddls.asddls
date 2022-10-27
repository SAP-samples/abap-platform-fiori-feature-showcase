@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Chart'

define view entity /DMO/FSA_I_Chart
  as select from /dmo/fsa_chart_a
  association [0..1] to /DMO/FSA_I_Criticality as _Criticality on $projection.CriticalityCode = _Criticality.Code
  association [0..1] to I_UnitOfMeasure        as _UoM         on $projection.Uom = _UoM.UnitOfMeasure
{
  key id                             as ID,
      parent_id                      as ParentID,
      criticality_code               as CriticalityCode,

      @EndUserText.label : 'Integer Value'
      integer_value                  as IntegerValue,

      @EndUserText.label : 'Minimal Net Amount'
      @Aggregation.default: #MIN
      integer_value                  as MinAmount,

      @EndUserText.label : 'Maximal Net Amount'
      @Aggregation.default: #MAX
      integer_value                  as MaxAmount,

      @EndUserText.label : 'Average Net Amount'
      @Aggregation.default: #AVG
      integer_value                  as AvgAmount,

      uom                            as Uom,
      integer_value_for_line_chart   as IntegerValueForLineChart,

      @EndUserText.label : 'Forecast Value'
      forecast_value                 as ForecastValue,

      @EndUserText.label : 'Target Value'
      target_value                   as TargetValue,

      @EndUserText.label : 'Dimensions'
      dimensions                     as Dimensions,

      areachart_tol_upperbound_value as AreachartTolUpperboundValue,
      areachart_tol_lowerbound_value as AreachartTolLowerboundValue,
      areachart_dev_upperbound_value as AreachartDevUpperboundValue,
      areachart_dev_lowerbound_value as AreachartDevLowerboundValue,
      _Criticality,
      _UoM
}
