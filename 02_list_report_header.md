# List Report - Header Area

## Content
- [List Report - Header Area](#list-report---header-area)
    - [Define Filters](#define-filters)
        - [Default Values](#default-values)
        - [Hide Filters](#hide-filters)
        - [Filter Facets](#filter-facets)
        - [Selection Fields](#selection-fields)

## Define Filters

### Default Values

*Search term:* `#FilterDefault`

With the annotation `@Consumption.filter.defaultValue` default values can be defined. This Annotation does not allow complex values and when switching variants, the annotation is no longer considered. For complex values the `@UI.selectionVariant` annotation is a better solution. 

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
@Consumption.filter.defaultValue: '3' // Search term #FilterDefault
CriticalityCode;
```

More information: [ABAP RESTful Application Programming Model - Consumption Annotations](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/consumption-annotations)

:arrow_up_small: [Back to Content](#content)

---

### Hide Filters

*Search term:* `#HideFilter`

To reduce the amount of available filters in a List Report, properties can be annotated with `@Consumption.filter.hidden: true` to hide them. 

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_ChartTP**

```
//Search Term: #HideFilter
@Consumption.filter.hidden: true
AreachartTolUpperboundValue;
  
@Consumption.filter.hidden: true
AreachartTolLowerboundValue;
  
@Consumption.filter.hidden: true
AreachartDevUpperboundValue;

@Consumption.filter.hidden: true
AreachartDevLowerboundValue;
```

:arrow_up_small: [Back to Content](#content)

---

### Filter Facets

*Search term:* `#FilterGrouping`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/filter_facet.jpg" title="Filter Facets" width="50%" height="50%" />

Another nice feature is filter facet, which allows one to structure the available properties of the entity into groups, so that filter adaptation is easier.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
@UI.facet: [
  // Search term #FilterGrouping
  {
    purpose: #FILTER,
    type: #FIELDGROUP_REFERENCE,
    targetQualifier: 'chartData',
    label: 'Chart Data (#FilterGrouping)'
  },
  // Search term #FilterGrouping, #Location
  {
    purpose: #FILTER,
    type: #FIELDGROUP_REFERENCE,
    targetQualifier: 'location',
    label: 'Location (#FilterGrouping)'
  }
]

@UI.fieldGroup: [{ qualifier: 'chartData' }] // Search term #FilterGrouping
IntegerValue;

@UI.fieldGroup: [{ qualifier: 'chartData' }] // Search term #FilterGrouping
ForecastValue;

@UI.fieldGroup: [{ qualifier: 'chartData' }] // Search term #FilterGrouping
TargetValue;

@UI.fieldGroup: [{ qualifier: 'chartData' }] // Search term #FilterGrouping
Dimensions;
```

:arrow_up_small: [Back to Content](#content)

---

### Selection Fields

*Search term:* `#VisibleFilters`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/selection_field.jpg" title="Selection Fields" />

`@UI.selectionField` is the annotation which allows one to specify an array of fields, which should by default be shown in the List Report filter bar as a filter, so that the user does not need to adapt the filters. 

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
@UI.selectionField: [{ position: 10 }] // Search term #VisibleFilters
StringProperty;

@UI.selectionField: [{ position: 20 }] // Search term #VisibleFilters
FieldWithPrice;

@UI.selectionField: [{ position: 30 }] // Search term #VisibleFilters
IsoCurrency;

@UI.selectionField: [{ position: 40 }] // Search term #VisibleFilters
CriticalityCode;
```

More information: [ABAP RESTful Application Programming Model - Adding Selection Fields](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/adding-selection-fields)

:arrow_up_small: [Back to Content](#content)

---