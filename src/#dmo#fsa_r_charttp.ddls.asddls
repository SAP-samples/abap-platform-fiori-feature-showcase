@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Chart TP'

define view entity /DMO/FSA_R_ChartTP
  as select from /DMO/FSA_I_Chart
  association to parent /DMO/FSA_R_RootTP as _Root on $projection.ParentID = _Root.ID
{
  key ID,
      ParentID,
      CriticalityCode,
      IntegerValue as IntegerValueForAreaChart,
      IntegerValue as IntegerValueForOtherCharts,
      MinAmount,
      MaxAmount,
      AvgAmount,
      Uom,
      IntegerValueForLineChart,
      ForecastValue,
      TargetValue,
      Dimensions,
      AreachartTolUpperboundValue,
      AreachartTolLowerboundValue,
      AreachartDevUpperboundValue,
      AreachartDevLowerboundValue,
      /* Associations */
      _Criticality,
      _UoM,
      _Root
}
