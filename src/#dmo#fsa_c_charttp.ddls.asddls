@EndUserText.label: 'Chart TP2'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

define view entity /DMO/FSA_C_ChartTP
  as projection on /DMO/FSA_R_ChartTP
{
  key ID,
      ParentID,
      CriticalityCode,
      IntegerValueForAreaChart,
      IntegerValueForOtherCharts,
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
      _Root : redirected to parent /DMO/FSA_C_RootTP,
      _UoM
}
