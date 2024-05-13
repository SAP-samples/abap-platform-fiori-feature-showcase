# Object Page - Header Area

## Content
- [Object Page - Header Area](#object-page---header-area)
    - [Title and Subtitle](#title-and-subtitle)
    - [Header Facets](#header-facets)
    - [Header Field Group Facet](#header-field-group-facet)
    - [Handling Semantic Key Fields](#handling-semantic-key-fields)
    - [Plain Text](#plain-text)
    - [Address Facet](#address-facet)
    - [Data Points](#data-points)
        - [Rating](#rating)
        - [Progress](#progress)
        - [Key Value](#key-value)
    - [Micro Chart Facet](#micro-chart-facet)
        - [Area Micro Chart](#area-micro-chart)
        - [Bullet Micro Chart](#bullet-micro-chart)
        - [Radial Micro Chart](#radial-micro-chart)
        - [Line Micro Chart](#line-micro-chart)
        - [Column Micro Chart](#column-micro-chart)
        - [Harvey Micro Chart](#harvey-micro-chart)
        - [Stacked Bar Micro Chart](#stacked-bar-micro-chart)
        - [Comparison Micro Chart](#comparison-micro-chart)
    - [Actions - Object Page Header Area](#actions---object-page-header-area)
        - [Copy Action in Object Page](#copy-action-in-object-page)
        - [Regular Actions](#regular-actions)
        - [Hide Standard Operations](#hide-standard-operations)
        - [Datafield WithAction in Object Page](#datafield-withaction-in-object-page)

## Title and Subtitle

*Search term:* `#HeaderInfo`

The title and subtitle of an Object Page are defined with the annotation `@UI.headerInfo`.

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
// Search Term #HeaderInfo
@UI.headerInfo: {
  typeName: 'Object Page - Root',
  typeNamePlural: 'Root Entities (#ListTableTitle)', // Search Term #ListTableTitle
  typeImageUrl: 'sap-icon://sales-order',
  imageUrl: 'ImageUrl',
  title: {
    value: 'StringProperty',
    type: #STANDARD
  },
  description: {
    label: 'Root entity',
    type: #STANDARD,
    value: 'StringProperty'
  }
}
```

The attribute `typeName` is the title and it is displayed next to the SAP Logo in header bar on the Object Page. The attribute `typeNamePlural` will be shown, if all entities are shown in a table. The attribute `title` is displayed as the header in the Object Page in bold. Attribute `description` is shown beneath `title` and if the optional `imageUrl` is given, then the picture will be visible on the left side of the `title` and `description`. If no url is given for the `imageUrl`, but `typeImageUrl` is defined, it will be displayed instead.

More Information: 
- [ABAP RESTful Application Programming Model - Defining the Table Header of a List Report](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/defining-table-header-of-list-report)
- [ABAP RESTful Application Programming Model - Defining the Title Section of an Object Page](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/defining-title-section-of-object-page)

:arrow_up_small: [Back to Content](#content)

---

## Header Facets

*Search term:* `#HeaderFacet`

The header facet is displayed in the header of an Object Page. The facet is annotated with `UI.facet.purpose: #HEADER`.

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
@UI.facet: [
  // OPHEADER
  // Search Term #HeaderFacet, #KeyValue
  {
    purpose: #HEADER,
    type: #DATAPOINT_REFERENCE,
    targetQualifier: 'fieldWithPrice'
  }
]

// Search Term #HeaderFacet, #KeyValue
@UI.dataPoint: {
  qualifier: 'fieldWithPrice',
  title: 'Field with Price (#HeaderFacet)'
}
FieldWithPrice;
```

More Information: [ABAP RESTful Application Programming Model - Using Facets to change the Object Page Layout](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/using-facets-to-change-object-page-layout)

:arrow_up_small: [Back to Content](#content)

---

## Header Field Group Facet

*Search term:* `#HeaderFieldGroup`, `#ContactInHeader`, `#OPQuickView`

Field groups can be part of a header.

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
// Search Term #HeaderFieldGroup
@UI.facet: [
  {
    purpose: #HEADER
    label      : 'General Data (#HeaderFieldGroup)',
    type       : #FIELDGROUP_REFERENCE,
    targetQualifier: 'HeaderData'
  }
]
```

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/header_fg.jpg" title="Header Field Group - Object Page" />

A quick view contact card can be displayed (#ContactInHeader). A QuickView can be displayed by just adding the property as a data field (#OPQuickView). Both implementations are identical to how they would be added as a line item in a List Report:
- [Adding a Contact Quick View to a Table](/03_list_report_content.md#adding-a-contact-quick-view-to-a-table)
- [Adding a Quick View to a Table](/03_list_report_content.md#adding-a-quick-view-to-a-table)

```
// Search Term #HeaderFieldGroup
@UI.fieldGroup: [
  {
    qualifier: 'HeaderData',
    position: 10,
    label: 'Field with Sem. Key(#SemanticKey)'
  }
]
StringProperty;

// Search Term #ContactInHeader, #HeaderFieldGroup
@UI.fieldGroup: [
  {
    qualifier: 'HeaderData',
    type: #AS_CONTACT,
    label: 'Contact QuickView (#ContactInHeader)',
    position: 70,
    value: '_Contact'
  }
]
ContactID;

// Search Term #HeaderFieldGroup, #WithAction
@UI.fieldGroup: [
  {
    qualifier: 'HeaderData',
    criticality: 'CriticalityCode',
    position: 20,
    label: 'Change Criticality (#WithAction)',
    dataAction: 'changeCriticality',
    type: #WITH_ACTION
  }
]
FieldWithCriticality;

// Search Term #HeaderFieldGroup, #OPQuickView
@UI.fieldGroup: [
  {
    qualifier: 'HeaderData',
    position: 50,
    label: 'Navigation QuickView (#OPQuickView)'
  }
]
NavigationID;
```

:arrow_up_small: [Back to Content](#content)

---

## Handling Semantic Key Fields

*Search term:* `#SemanticKey`

Semantic Key fields can be defined, with the annotation `@ObjectModel.semanticKey`, which consists of an array of properties from the entity. The given fields will be displayed in bold, and when possible the editing status will be displayed. 

> [!NOTE] 
> Source: CDS View **/DMO/FSA_R_RootTP**

```
// Search Term #SemanticKey
@ObjectModel.semanticKey: ['StringProperty']
```

:arrow_up_small: [Back to Content](#content)

---

## Plain Text

*Search term:* `#PlainText`

Plain text can be displayed, by adding a standard property to a field group and using this field group as a target of a reference facet.

The property in the field group can be optionally annotated with [`@UI.MultiLineText`](/04_object_page_general.md#multi-line-text), especially if you have a long text and would like it to be show in the UI as a multi-line text, with an expand/collapse button.

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
// Search Term #PlainText
@UI.facet: [
  {
    purpose: #HEADER,
    type: #FIELDGROUP_REFERENCE,
    label: 'Plain Text (#PlainText)',
    targetQualifier: 'plainText'
  }
]

@UI: {
  // Search Term #PlainText
  fieldGroup: [ { qualifier: 'plainText' } ]
  // Search Term #MultiLineText
  multiLineText: true
}
Description;
```

More Information: [ABAP RESTful Application Programming Model - Grouping Fields](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/grouping-fields)

:arrow_up_small: [Back to Content](#content)

---

## Address Facet

*Search term:* `#AddressFacet`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/add_facet.jpg" title="Address Facet"  width="50%" height="50%" />

The property of an entity annotated with `@Semantics.address.label` can be directly displayed in an address facet, with target qualifier **'pref'** if no specific qualifier is set. The label will be used as is, therefore it needs to be fully formatted. Linebreaks can be achieved with '\n'.

> [!NOTE] 
> Source: CDS View  **/DMO/FSA_I_Contact**

```
// Search Term #CONTACT
define view entity /DMO/FSA_I_Contact
...
{
  ...
  @Semantics.address.label: true
  @Consumption.valueHelpDefault.display:false 
  address_label as AddressLabel,
}
```

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
// Search Term #AddressFacet
@UI.facet: [
  {
    purpose: #HEADER, // or #STANDARD
    label     : 'Address (#AddressFacet)',
    type      : #ADDRESS_REFERENCE,
    targetElement: '_Contact',
    targetQualifier: 'pref'
  }
]
```

:arrow_up_small: [Back to Content](#content)

---

## Data Points

### Rating

*Search term:* `#DataPointRating`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/op_rating_ind.jpg" title="Rating Indicator - Object Page" />

To add a rating indicator (stars) to the object page header, you first need to define a datapoint with `@UI.dataPoint`. The property where datapoint is defined sets how many stars are visible. Values between x.25 and x.74 are displayed as a half star. The attribute `targetValue` defines how many stars are possible. **Most importantly, the qualifier needs to match the property name.**

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
@UI: { 
  // Search Term #DataPointRating, #DataPointRatingTable
  dataPoint: {
    qualifier: 'StarsValue',
    targetValue: 4,
    visualization: #RATING,
    title: 'Rating Indicator (#DataPointRating)'
  }
}
StarsValue;
```

After creating the data point, it has to be added to the `@UI.facet` annotation.

```
@UI.facet: [
  {
    // Search Term #DataPointRating
    purpose: #HEADER, // or #STANDARD
    type       : #DATAPOINT_REFERENCE,
    targetQualifier: 'StarsValue'
  }
]
```

Example: [ABAP RESTful Application Programming Model - Develop Node Extensions - Extension Node with Rating](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/develop-node-extensions#extension-node)

:arrow_up_small: [Back to Content](#content)

---

### Progress

*Search term:* `#DataPointProgress`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/op_progress_ind.jpg" title="Progress Indicator - Object Page" />

To add a progress indicator to the object page header, you first need to define a datapoint with `@UI.dataPoint`. The property where datapoint is defined sets the current progress and the attribute `targetValue`, the maximum progress. Additionally, a criticality can be given, if wanted. **Most importantly, the qualifier needs to match the property name.**

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
// Search Term #DataPointProgress, #DataPointProgressTable
@UI: {
  dataPoint: {
    qualifier: 'ProgressIntegerValue',
    targetValue: 100,
    visualization: #PROGRESS,
    criticality: 'CriticalityCode',
    title: 'Progress Indicator (#DataPointProgress)'
  }
}
ProgressIntegerValue;
```

After creating the data point, it has to be added to the `@UI.facet` annotation.

```
@UI.facet: [
  {
    // Search Term #DataPointProgress
    purpose: #HEADER, // or #STANDARD
    type       : #DATAPOINT_REFERENCE,
    targetQualifier: 'ProgressIntegerValue'
  }
]
```

Example: [ABAP RESTful Application Programming Model - Develop Node Extensions - Extension Node with Progress](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/develop-node-extensions#extension-node)

:arrow_up_small: [Back to Content](#content)

---

### Key Value

*Search term:* `#KeyValue`

A key value is the default data point, when the attribute `visualization` is not specified in `@UI.dataPoint`.

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
@UI.facet: [
  // Search Term #Headerfacet, #KeyValue
  {
    purpose: #HEADER,
    type: #DATAPOINT_REFERENCE,
    targetQualifier: 'fieldWithPrice'
  }
]

@UI: {
  // Search Term #HeaderFacet, #KeyValue
  dataPoint: {
    qualifier: 'fieldWithPrice',
    title: 'Field with Price (#HeaderDataPoint)'
  }
}
FieldWithPrice;
```

:arrow_up_small: [Back to Content](#content)

---

## Micro Chart Facet

The following micro charts are supported: Area, Bullet, Radial, Column, Line, Harvey, Stacked bar and Comparison. Micro charts can only be displayed in the header. 

A micro chart is defined with the `@UI.chart` annotation, which then is the target of a ReferenceFacet in the `@UI.facet` of `purpose: #HEADER`. The title of the facet is the attribute `title` of the annotation and the subtitle is `description`. If the property of the data point is a property with unit of measure, the unit will be displayed in the footer. The attribute `measures` of the chart has to be a data point. 

The `@UI.dataPoint` supports generally the attributes `criticality` and `criticalityCalculation`, but the support varies between the micro chart types. If the value of the data point is annotated with a unit of measure, the unit will be shown as the footer of the micro chart facet.

In the following examples, all used attributes are mandatory.

---

### Area Micro Chart

*Search term:* `#AreaMicroChart`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/op_area_mc.jpg" title="Area Micro Chart - Object Page" />

The area micro chart is a trend chart, which provides information for the actual and target value for a specified dimension. The displayed values at the bottom of the chart are the boundary values of the dimension. The values above the chart are the boundary values of the measure attribute.

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_ChartTP**

```
@UI.chart: [
  // Search Term #AreaMicroChart
  { 
    qualifier: 'areaChart',
    title: 'Area Micro Chart (#AreaMicroChart)',
    description: 'This is a micro chart',
    chartType: #AREA,
    dimensions: ['Dimensions'],
    measures: ['IntegerValueForAreaChart'],
    measureAttributes: [
      {
        measure: 'IntegerValueForAreaChart',
        role: #AXIS_1,
        asDataPoint: true
      }
    ]
  }
]
```

The criticality calculation of the data point is mandatory, as each value is shown with its threshold (error, warning, acceptance and good) ranges.

```
// Search Term #AreaMicroChart
@UI.dataPoint: { 
  qualifier: 'IntegerValueForAreaChart',
  targetValueElement: 'TargetValue',
  criticalityCalculation: { 
    improvementDirection: #TARGET,
    toleranceRangeLowValueElement: 'AreachartTolLowerboundValue',
    toleranceRangeHighValueElement: 'AreachartTolUpperboundValue',
    deviationRangeHighValueElement: 'AreachartDevUpperboundValue',
    deviationRangeLowValueElement: 'AreachartDevLowerboundValue'
  }
}
IntegerValueForAreaChart;
```

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
// Search Term #AreaMicroChart
@UI.facet: [
  {
    purpose: #HEADER,
    type       : #CHART_REFERENCE,
    targetQualifier: 'areaChart',
    targetElement: '_Chart'
  }
]
```

More Information: [ABAP RESTful Application Programming Model: Visualizing Data with Charts](https://help.sap.com/docs/BTP/923180ddb98240829d935862025004d6/c7f12219d533404f8fad96aa68fa4ba6.html)

:arrow_up_small: [Back to Content](#content)

---

### Bullet Micro Chart

*Search term:* `#BulletMicroChart`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/op_bullet_mc.jpg" title="Bullet Micro Chart - Object Page" />

The bullet chart features a single measure and compares it to one or more other measures (e.g. value with target comparison). Both `criticality` and `criticalityCalculation` are supported, but if both are given `criticality` overrides `criticalityCalculation`. The bullet chart does not support the criticality value of 5 (new item). The `measuresAttributes`, while it is mandatory, has no effect on the chart as the values come from datapoint.

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

Chart

```
// Search Term #BulletMicroChart, #BulletMicroChartTable
@UI.chart: [
  {
    qualifier: 'bulletChart',
    title: 'Bullet Micro Chart (#BulletMicroChart)',
    description: 'This is a micro chart',
    chartType: #BULLET,
    measures: ['IntegerValue'],
    measureAttributes: [
      {
        measure: 'IntegerValue',
        role: #AXIS_1,
        asDataPoint: true
      }
    ]
  }
]
```

Facet

```
// Search Term #BulletMicroChart
@UI.facet: [
  {
    purpose: #HEADER,
    type       : #CHART_REFERENCE,
    targetQualifier: 'bulletChart'
  }
]
```

Data Point. The attribute `minimumValue` is needed to render the chart properly. The value is the actual bar. The `forecastValue` is the bar in the background with a lower opacity and the `targetValue` is the dark line. **Qualifier must be set to the name of the property.**

```
// Search Term: #BulletMicroChart
@UI.dataPoint: {
  qualifier: 'IntegerValue', //IntegerValue: horizontal bar in relation to the goal line
  targetValueElement: 'TargetValue', //visual goal line in the UI
  forecastValue: 'ForecastValue', //horizontal bar behind the value bar with, slightly larger with higher transparency
  criticality: 'CriticalityCode',
  minimumValue: 0 //Minimal value, needed for output rendering
}
IntegerValue;
```

More Information: [ABAP RESTful Application Programming Model: Visualizing Data with Charts](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/visualizing-data-with-charts)

:arrow_up_small: [Back to Content](#content)

---

### Radial Micro Chart

*Search term:* `#RadialMicroChart`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/op_radial_mc.jpg" title="Radial Micro Chart - Object Page" />

The radial micro chart displays a single percentage value. The `measureAttributes`, while mandatory, has no effect on the chart as the values come from datapoint.

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

Chart

```
// Search Term #RadialMicroChart
@UI.chart: [
  {
    qualifier: 'radialChart',
    title: 'Radial Micro Chart (#RadialMicroChart)',
    description: 'This is a micro chart',
    chartType: #DONUT,
    measures: ['RadialIntegerValue'],
    measureAttributes: [
      {
        measure: 'RadialIntegerValue',
        role: #AXIS_1,
        asDataPoint: true
      }
    ]
  }
]
```

Facet

```
// Search Term #RadialMicroChart
@UI.facet: [
  {
    purpose: #HEADER, 
    type       : #CHART_REFERENCE,
    targetQualifier: 'radialChart'
  }
]
```

Data Point. The percentage value is the fraction of the property value and the target value. The unit of measure label will not be rendered, as the chart displays percentage values. Both `criticality` and `criticalityCalculation` are supported, but if both are given `criticality` overrides `criticalityCalculation`. **Qualifier must be set to the name of the property.**

```
// Search Term #RadialMicroChart
@UI.dataPoint: {
  qualifier: 'RadialIntegerValue',
  targetValueElement: 'TargetValue', //The relation between the value and the target value will be displayed as a percentage
  criticality: 'CriticalityCode'
}
RadialIntegerValue;
```

More Information: [ABAP RESTful Application Programming Model: Visualizing Data with Charts](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/visualizing-data-with-charts)

:arrow_up_small: [Back to Content](#content)

---

### Line Micro Chart

*Search term:* `#LineMicroChart`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/op_line_mc.jpg" title="Line Micro Chart - Object Page"  />

The line chart displays a series of data points as a line. The bottom values are the border values of the `dimension`. The upper left value is the smallest value of the first `measures` property and the upper right value is the largest value of the last `measures` property. The shown unit of measure is from the first entry.

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_ChartTP**

```
// Search Term #LineMicroChart
@UI.chart: [
  { 
    qualifier: 'lineChart',
    title: 'Line Micro Chart (#LineMicroChart)',
    description: 'This is a micro chart',
    chartType: #LINE,
    measures: ['IntegerValueForLineChart', 'TargetValue'],
    dimensions: ['Dimensions'],
    measureAttributes: [
      { 
        measure: 'IntegerValueForLineChart',
        role: #AXIS_2,
        asDataPoint: true
      },
      { 
        measure: 'TargetValue',
        role: #AXIS_2,
        asDataPoint: true
      }
    ]
  }
]
```

Data Points. It is recommended to only use one measure, and a maximum of three measures, if more is required. If the attribute `criticality` contains a path, then the value of the last data point's `criticality` determines the color of the line.

```
// Search Term #LineMicroChart
@UI: {
  dataPoint: {
    qualifier: 'TargetValue',
    criticality: 'CriticalityCode'
  }
}
TargetValue;

// Search Term #LineMicroChart
@UI.dataPoint: { 
  qualifier: 'IntegerValueForLineChart',
  criticality: 'CriticalityCode'
}
IntegerValueForLineChart;
```

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
// Search Term #LineMicroChart
@UI.facet: [
  {
    purpose: #HEADER, 
    type: #CHART_REFERENCE,
    targetQualifier: 'lineChart',
    targetElement: '_Chart'
  }
]
```

More Information: [ABAP RESTful Application Programming Model: Visualizing Data with Charts](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/visualizing-data-with-charts)

:arrow_up_small: [Back to Content](#content)

---

### Column Micro Chart

*Search term:* `#ColumnMicroChart`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/op_column_mc.jpg" title="Column Micro Chart - Object Page" />

A column chart uses vertical bars to compare values of a dimension. The displayed values at the bottom of the chart are the boundary values of the `dimensions`. The values above the chart are the boundary values of the `measureAttributes`.

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_ChartTP**

```
// Search Term #ColumnMicroChart
@UI.chart: [
  { 
    qualifier: 'columnChart',
    title: 'Column Micro Chart (#ColumnMicroChart)',
    description: 'This is a micro chart',
    chartType: #COLUMN,
    measures: ['IntegerValueForOtherCharts'],
    dimensions: ['Dimensions'],
    measureAttributes: [
      { 
        measure: 'IntegerValueForOtherCharts',
        role: #AXIS_1,
        asDataPoint: true
      }
    ]
  }
]
```

Data Point. Both `criticality` and `criticalityCalculation` are supported, but if both are given `criticality` overrides `criticalityCalculation`.

```
// Search Term #ColumnMicroChart, #StackedBarMicroChart, #ComparisonMicroChart
@UI.dataPoint: { 
  qualifier: 'IntegerValueForOtherCharts',
  criticality: 'CriticalityCode'
}
IntegerValueForOtherCharts;
```

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
// Search Term #ColumnMicroChart
@UI.facet: [
  {
    purpose: #HEADER, 
    type: #CHART_REFERENCE,
    targetQualifier: 'columnChart',
    targetElement: '_Chart'
  }
]
```

More Information: [ABAP RESTful Application Programming Model: Visualizing Data with Charts](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/visualizing-data-with-charts)

:arrow_up_small: [Back to Content](#content)

---

### Harvey Micro Chart

*Search term:* `#HarveyMicroChart`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/op_harvey_mc.jpg" title="Harvey Micro Chart - Object Page" />

A harvey chart plots a single measure value against a maximum value.

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

Chart

```
// Search Term #HarveyMicroChart
@UI.chart: [
  {
    qualifier: 'harveyChart',
    title: 'Harvey Micro Chart (#HarveyMicroChart)',
    description: 'This is a micro chart',
    chartType: #PIE,
    measures: ['HarveyFieldWithPrice'],
    measureAttributes: [
      {
        measure: 'HarveyFieldWithPrice',
        role: #AXIS_1,
        asDataPoint: true
      }
    ]
  }
]
```

Data Point. For the semantic coloring, only the attribute `criticality` is supported.

```
//Search-Term: #HarveyMicroChart
@UI.dataPoint: {
  qualifier: 'HarveyFieldWithPrice',
  maximumValue: 5000,
  criticality: 'CriticalityCode'
}
HarveyFieldWithPrice;
```

Facet

```
// Search Term #HarveyMicroChart
@UI.facet: [
  {
    purpose: #HEADER, 
    type: #CHART_REFERENCE,
    targetQualifier: 'harveyChart'
  }
]
```

More Information: [ABAP RESTful Application Programming Model: Visualizing Data with Charts](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/visualizing-data-with-charts)

:arrow_up_small: [Back to Content](#content)

---

### Stacked Bar Micro Chart

*Search term:* `#StackedBarMicroChart`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/op_stackedbar_mc.jpg" title="Stacked Bar Micro Chart - Object Page" />

A stacked bar chart uses vertical bars to compare values of a dimension. The displayed values at the bottom of the chart are the boundary values of the `dimensions`. The values above the chart are the boundary values of the `measureAttributes`.

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_ChartTP**

```
// Search Term #StackedBarMicroChart
@UI.chart: [ {
  qualifier: 'stackedBarChart',
  title: 'StackedBar Micro Chart (#StackedBarMicroChart)',
  description: 'This is a micro chart',
  chartType: #BAR_STACKED,
  measures: ['IntegerValueForOtherCharts'],
  dimensions: ['Dimensions'],
  measureAttributes: [
    { 
      measure: 'IntegerValueForOtherCharts',
      role: #AXIS_1,
      asDataPoint: true
    }
  ]
}]
```

Data Point. Both `criticality` and `criticalityCalculation` are supported, but if both are given `criticality` overrides `criticalityCalculation`.

```
// Search Term #ColumnMicroChart, #StackedBarMicroChart, #ComparisonMicroChart
@UI.dataPoint: { 
  qualifier: 'IntegerValueForOtherCharts',
  criticality: 'CriticalityCode'
}
IntegerValueForOtherCharts;
```

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
// Search Term #StackedBarMicroChart
@UI.facet: [
  {
    purpose: #HEADER, 
    type: #CHART_REFERENCE,
    targetQualifier: 'stackedBarChart',
    targetElement: '_Chart'
  }
]
```

More Information: [ABAP RESTful Application Programming Model: Visualizing Data with Charts](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/visualizing-data-with-charts)

:arrow_up_small: [Back to Content](#content)

---

### Comparison Micro Chart

*Search term:* `#ComparisionMicroChart`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/op_comparison_mc.jpg" title="Comparison Micro Chart - Object Page" />

A comparison chart uses three horizontal bars to compare values of a dimension. If more values are defined in `dimensions`, they will only show up in the tooltip. The displayed values on the left represent the dimension value of each data point. The values on the right are the actual values. If a unit of measure is shown, then it is from the first data point to be plotted.

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_ChartTP**

```
// Search Term #ComparisonMicroChart
@UI.chart: [
  { 
    qualifier: 'comparisonChart',
    title: 'Comparison Micro Chart (#ComparisonMicroChart)',
    description: 'This is a micro chart',
    chartType: #BAR,
    measures: ['IntegerValueForOtherCharts'],
    dimensions: ['Dimensions'],
    measureAttributes: [
      { 
        measure: 'IntegerValueForOtherCharts',
        role: #AXIS_1,
        asDataPoint: true
      }
    ]
  }
]
```

Data Point. For semantic coloring, only the attribute `criticality` is supported.

```
// Search Term #ColumnMicroChart, #StackedBarMicroChart, #ComparisonMicroChart
@UI.dataPoint: { 
  qualifier: 'IntegerValueForOtherCharts',
  criticality: 'CriticalityCode'
}
IntegerValueForOtherCharts;
```

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
// Search Term #ComparisonMicroChart
@UI.facet: [
  {
    purpose: #HEADER, 
    type: #CHART_REFERENCE,
    targetQualifier: 'comparisonChart',
    targetElement: '_Chart'
  }
]
```

More Information: [ABAP RESTful Application Programming Model: Visualizing Data with Charts](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/visualizing-data-with-charts)

:arrow_up_small: [Back to Content](#content)

---

## Actions - Object Page Header Area

### Copy Action in Object Page

*Search term:* `#OPCopyAction`

> [!WARNING]  
> Only available with the latest [SAP BTP or SAP S/4HANA Cloud, public edition release](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-cloud) and for SAP S/4HANA, on-premise edition or SAP S/4HANA Cloud, private edition, from [release 2023](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-2023) onwards.

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/op_copy_action.jpg" title="Copy Action - Object Page" width="60%" height="60%" />

For a deep copy of an instance, the RAP framework does not provide a copy action out of the box, unlike create/edit/delete. However you can define a factory action in the BDEF that copies an instance, and by using the keyword `isCopyAction: true`, the action button will be rendered in UI harmoniously with Edit/Delete.

The cardinality of a factory action is always [1], that means, only one instance can be copied at a time.

When no label is provided, it is automatically set to 'Copy'. 

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
@UI.identification: [
  // Search Term #OPCopyAction
  {
    type:#FOR_ACTION,
    dataAction: 'copyInstance',
    isCopyAction: true
  }
]
```

> [!NOTE] 
> Source: Behaviour Definition **/DMO/FSA_R_RootTP**

```
factory action copyInstance [1];
```

:arrow_up_small: [Back to Content](#content)

---

### Regular Actions

*Search term:* `#OPHeaderAction`

Actions for the Object Page in general are annotated using `@UI.identification`. The criticality only supports the values 0 (normal), 1 (red) and 3 (green). For normal actions the Object Page content is passed and for static actions, no context is passed. 

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
// Search Term #OPHeaderAction
@UI.identification: [
  {
    type: #FOR_ACTION,  //Action in the RootEntities of the object page next to the edit button
    label: 'Change Criticality (#OPHeaderAction)',
    criticality: 'CriticalityCode',
    criticalityRepresentation: #WITH_ICON,
    dataAction: 'changeCriticality'
  }
]
ID;
```

> [!NOTE] 
> Source: Behaviour Definition  **/DMO/FSA_R_RootTP**

```
action changeCriticality parameter /DMO/FSA_D_ChangeCriticalityP result [1] $self;
```

More Information: [ABAP RESTful Application Programming Model: Action Implementation - UI Consumption of actions](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/action-implementation#ui-consumption-of-actions)

:arrow_up_small: [Back to Content](#content)

---

### Hide Standard Operations

*Search term:* `#DynamicCRUD`

> [!WARNING]  
> Only available with the latest [SAP BTP or SAP S/4HANA Cloud, public edition release](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-cloud) and for SAP S/4HANA, on-premise edition or SAP S/4HANA Cloud, private edition, from [release 2023](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-2023) onwards.

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/update_hidden.jpg" title="Update Hidden" width="80%" height="80%" />

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/upd_del_hidden.jpg" title="Update and Delete Hidden" width="80%" height="80%" />

The visibility of the "Edit", "Create" and "Delete" buttons in the Object Page can be dynamically adjusted. For example the delete operation can be dependent on a property of the entity, through the annotation `@UI.deleteHidden`. Fixed values true or false are also possible.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
// Search Term #DynamicCRUD
@UI.updateHidden: #(UpdateHidden)
@UI.deleteHidden: #(DeleteHidden)
```

:arrow_up_small: [Back to Content](#content)

---

### Datafield WithAction in Object Page

*Search term:* `#WithActionInOP`

> [!WARNING]  
> Only available with the latest [SAP BTP or SAP S/4HANA Cloud, public edition release](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-cloud) and for SAP S/4HANA, on-premise edition or SAP S/4HANA Cloud, private edition, from [release 2023](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-2023) onwards.

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/with_action_op.jpg" title="Datafield WithAction in Object Page" width="50%" height="50%" />

An action that is tied to a data value, which would be rendered as a hyperlink. Therefore it is crucial to specify the annotation at the desired element which has the data value.

The keyword to use for this is `type: #WITH_ACTION`.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
@UI.facet: [
  // Search Term #HeaderCollectionFacet
  {
    purpose: #HEADER,
    id: 'FacetCollection',
    type: #COLLECTION
  },
  // Search Term #HeaderFieldGroup
  {
    parentId   : 'FacetCollection',
    label      : 'General Data (#HeaderFieldGroup)',
    type       : #FIELDGROUP_REFERENCE,
    targetQualifier: 'HeaderData'
  }
]

@UI: {
  fieldGroup: [
    // Search Term #HeaderFieldGroup, #WithActionInOP
    {
      qualifier: 'HeaderData',
      criticality: 'CriticalityCode',
      position: 30,
      label: 'Change Criticality (#WithActionInOP)',
      dataAction: 'changeCriticality',
      type: #WITH_ACTION
    }
  ]
}
FieldWithCriticality;
```

> [!NOTE] 
> Source: Behaviour Definition **/DMO/FSA_R_RootTP**

```
action changeCriticality parameter /DMO/FSA_D_ChangeCriticalityP result [1] $self;
```

:arrow_up_small: [Back to Content](#content)

---