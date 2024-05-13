# List Report - Content Area

## Content
- [List Report - Content Area](#list-report---content-area)
    - [Configuring Tables](#configuring-tables)
        - [Actions - List](#actions---list)
            - [Actions in Toolbar](#actions-in-toolbar)
            - [Inline Actions in Line Item](#inline-actions-in-line-item)
            - [Copy Action in Line Item](#copy-action-in-line-item)
            - [Navigation Button](#navigation-button)
            - [Datafield WithAction in Line Item](#datafield-withaction-in-line-item)
        - [Presentation Variant - List Report](#presentation-variant---list-report)
        - [Selection Variant - List Report](#selection-variant---list-report)
        - [Selection Presentation Variant - List Report](#selection-presentation-variant---list-report)
        - [Defining the Default Sort Order](#defining-the-default-sort-order)
        - [Highlighting Line Items Based on Criticality](#highlighting-line-items-based-on-criticality)
        - [Adding a Rating Indicator to a Table](#adding-a-rating-indicator-to-a-table)
        - [Adding a Progress Indicator to a Table](#adding-a-progress-indicator-to-a-table)
        - [Adding a Smart Micro Chart to a Table](#adding-a-smart-micro-chart-to-a-table)
            - [Bullet Micro Chart - Table](#bullet-micro-chart---table)
            - [Radial Micro Chart - Table](#radial-micro-chart---table)
        - [Adding a Contact Quick View to a Table](#adding-a-contact-quick-view-to-a-table)
        - [Adding a Quick View to a Table](#adding-a-quick-view-to-a-table)
        - [Adding Multiple Fields to one Column in a Table](#adding-multiple-fields-to-one-column-in-a-table)
        - [Adding Images to a Table](#adding-images-to-a-table)
        - [Adding Currency or UoM Fields to a Table](#adding-currency-or-uom-fields-to-a-table)
        - [Adding Large Object/Stream Property to a Table](#adding-large-objectstream-property-to-a-table)
          - [Static Field Control for Large Object/Stream Property](#static-field-control-for-large-objectstream-property)
          - [Dynamic Field Control for Large Object/Stream Property](#dynamic-field-control-for-large-objectstream-property)
        - [Adding Navigation with URL to a Table](#adding-navigation-with-url-to-a-table)

## Configuring Tables

To see columns in your table, you would first have to define them with the annotation `@UI.lineItem` at the property, either in the CDS view or in a metadata extension. The most basic setting you can use would be:
- the order of the column in the table and 
- changing the column label, if you do not want to use the label from underlying views.

In the example below, `StringProperty` would be the second column in the table (the numbering used here is 10, 20, etc. You could also start with 1, 2, etc. ), defined using `position`. `label` would be the column label/heading.

`importance` denotes the importance of the property. With `#HIGH`, this means that the property will always be shown even if the table is rendered on a small display.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
@UI.lineItem: [
  {
    position: 20,
    importance: #HIGH,
    label: 'Field with Sem. Key(#SemanticKey)'
  }
]
StringProperty;
```

More information: [ABAP RESTful Application Programming Model - Tables](https://help.sap.com/docs/abap-cloud/abap-rap/tables)

:arrow_up_small: [Back to Content](#content)

---

### Actions - List

#### Actions in Toolbar

*Search term:* `#ActionInLineItem`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/action_line_item.jpg" title="Action - Line Item" />

With this `@UI.lineItem` annotation, the action is displayed above the table on the right, with other possible actions.  

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
// Search Term #ActionInLineItem
@UI.lineItem: [
  {
    type:#FOR_ACTION,
    label: 'Change Criticality (#ActionInLineItem)',
    dataAction: 'changeCriticality',
    position: 10
  }
]
LastChangedAt;
```

> [!NOTE] 
> Source: Behaviour Definition **/DMO/FSA_R_RootTP**

```
action changeCriticality parameter /DMO/FSA_D_ChangeCriticalityP result [1] $self;
```

A regular action requires a line item to be selected before the button is activated but a static action is always active.

More information: [ABAP RESTful Application Programming Model - Actions](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/actions)

:arrow_up_small: [Back to Content](#content)

---

#### Inline Actions in Line Item

*Search term:* `#InlineActionInLineItem`

> [!WARNING]  
> Only available with the latest [SAP BTP or SAP S/4HANA Cloud, public edition release](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-cloud) and for SAP S/4HANA, on-premise edition or SAP S/4HANA Cloud, private edition, from [release 2023](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-2023) onwards.

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/inline_action_line_item.jpg" title="Inline Action - Line Item" />

Inline actions are used to trigger actions directly for a single line item. When declaring an inline action, the action button will show up in the table row within its own column.

The keyword to use for this is `inline: true` in `@UI.lineItem`, `@UI.fieldGroup`, etc in conjunction with an action.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
// Search Term #InlineActionInLineItem
@UI.lineItem: [
  {
    type:#FOR_ACTION,
    label: 'Change Progress(#InlineActionInLineItem)',
    dataAction: 'changeProgress',
    inline: true,
    emphasized: true,
    importance: #HIGH,
    position: 100
  }
]
LastChangedAt;
```

> [!NOTE] 
> Source: Behaviour Definition **/DMO/FSA_R_RootTP**

```
action changeProgress parameter /DMO/FSA_D_ChangeProgressP result [1] $self;
```

:arrow_up_small: [Back to Content](#content)

---

#### Copy Action in Line Item

*Search term:* `#CopyActionInLineItem`

> [!WARNING]  
> Only available with the latest [SAP BTP or SAP S/4HANA Cloud, public edition release](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-cloud) and for SAP S/4HANA, on-premise edition or SAP S/4HANA Cloud, private edition, from [release 2023](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-2023) onwards.

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/copy_action_line_item.jpg" title="Copy Action - Line Item" />

For a deep copy of an instance, the RAP framework does not provide a copy action out of the box, unlike create/edit/delete. However you can define a factory action in the BDEF that copies an instance, and by using the keyword `isCopyAction: true`, the action button will be rendered in UI harmoniously with Create/Delete. When no label is provided, it is automatically set to 'Copy'. 

The cardinality of a factory action is always [1], that means, only one instance can be copied at a time.

When used in conjunction with `inline: true` to render the Copy button at individual line items, a label must be provided by you.


> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
// Search Term #CopyActionInLineItem
@UI.lineItem: [
  {
    type:#FOR_ACTION,
    dataAction: 'copyInstance',
    isCopyAction: true
  }
]
LastChangedAt;
```

> [!NOTE] 
> Source: Behaviour Definition **/DMO/FSA_R_RootTP**

```
factory action copyInstance [1];
```

:arrow_up_small: [Back to Content](#content)

---

#### Navigation Button

*Search term:* `#Navigation-IBN`

An action navigating to a published app of an associated entity can be added, through Intent Based Navigation using `@UI.lineItem`. When the navigation is setup properly, a button will be rendered at the table toolbar. Since this feature requires Fiori Launchpad and a destination app that has been published, the following is just an example of how it can be coded, as this navigation does not work in a FE App Preview.

Here "FeatureShowcaseNavigation" is the semantic object to be referenced.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
// Search Tern #Navigation-IBN
@Consumption.semanticObject: 'FeatureShowcaseNavigation'
@UI.lineItem: [
  {
    label: 'IntentBased Navigation (#NavAction-IBN)',
    type: #FOR_INTENT_BASED_NAVIGATION,
    semanticObjectAction: 'manage',
    requiresContext: true
  }
]
NavigationID;
```

More information: [ABAP RESTful Application Programming Model - Based on Intent](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/based-on-intent)

:arrow_up_small: [Back to Content](#content)

---

#### Datafield WithAction in Line Item

*Search term:* `#WithActionInLineItem`

> [!WARNING]  
> Only available with the latest [SAP BTP or SAP S/4HANA Cloud, public edition release](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-cloud) and for SAP S/4HANA, on-premise edition or SAP S/4HANA Cloud, private edition, from [release 2023](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-2023) onwards.

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/with_action_lineitem.jpg" title="Datafield WithAction in Line Item" />

An action that is tied to a data value, which would be rendered as a hyperlink. Therefore it is crucial to specify the annotation at the desired element which has the data value.

The keyword to use for this is `type: #WITH_ACTION`.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
@UI: {
  lineItem: [
    {
      position: 50,
      criticality: 'CriticalityCode',
      label: 'Change Criticality (#WithActionInLineItem)',
      type: #WITH_ACTION,
      dataAction: 'changeCriticality',
      importance: #LOW
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

### Presentation Variant - List Report

*Search term:* `#PresentationVariant`

A presentation variant defines how the result of a queried collection of entities is shaped and how this result is displayed, for example as a list report or a chart (`@UI.presentationVariant.visualizations`), the sorting order (`@UI.presentationVariant.sortOrder`), or the number of items (`@UI.presentationVariant.maxItems`) to display per segment.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
// Search Term #PresentationVariant
@UI.presentationVariant: [
  {
    qualifier: 'pvariant',
    maxItems: 5,
    // Search Term #DefaultSort
    sortOrder: [
      {
        by: 'StringProperty',
        direction: #ASC
      }
    ],
    visualizations: [{type: #AS_LINEITEM}]
  }
]
```

:arrow_up_small: [Back to Content](#content)

---

### Selection Variant - List Report

*Search term:* `#SelectionVariant`

With a selection variant, you can define how the properties of an entity set should be filtered. The attribute `text` of the annotation is the title of the view and the attribute `filter` contains all filter parameters.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
// Search Term #SelectionVariant
@UI.selectionVariant: [
  {
    qualifier: 'svariant',
    text: 'Selection (Criticality between 0 and 2)',
    filter: 'CriticalityCode GE 0 and CriticalityCode LE 2'
  }
]
```

:arrow_up_small: [Back to Content](#content)

---

### Selection Presentation Variant - List Report

*Search term:* `#SelectionPresentationVariant`

A SelectionPresentationVariant bundles a Selection Variant and a Presentation Variant.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
@UI.presentationVariant: [
  {
    qualifier: 'pvariant',
    maxItems: 5,
    // Search Term #DefaultSort
    sortOrder: [
      {
        by: 'StringProperty',
        direction: #ASC
      }
    ],
    visualizations: [{type: #AS_LINEITEM}]
  }
]

@UI.selectionVariant: [
  {
    qualifier: 'svariant',
    text: 'Selection (Criticality between 0 and 2)',
    filter: 'CriticalityCode GE 0 and CriticalityCode LE 2'
  }
]

// Search Term #SelectionPresentationVariant
@UI.selectionPresentationVariant: [
  {
    text: 'SPresVariant (Criticality between 0 and 2)',
    presentationVariantQualifier: 'pvariant',
    selectionVariantQualifier: 'svariant'
  }
]
```

:arrow_up_small: [Back to Content](#content)

---

### Defining the Default Sort Order

*Search term:* `#DefaultSort`

Use the `@UI.presentationVariant` annotation to define a default sort order. The attribute `by` defines, on which property the sort order should be applied.

Without a sort order defined with `direction`, the values are ascending. 

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
@UI.presentationVariant: [
  {
    // Search Term #DefaultSort
    sortOrder: [
      {
        by: 'StringProperty',
        direction: #ASC
      }
    ]
  }
]
```

:arrow_up_small: [Back to Content](#content)

---

### Highlighting Line Items Based on Criticality

*Search term:* `#LineItemHighlight`

Line items can be highlighted based on criticality. The `@UI.lineItem` annotation should be annotated at ***Entity level***.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
// Search Term #LineItemHighlight
@UI.lineItem: [{criticality: 'CriticalityCode'}] // Annotation, so that the line item row has a criticality
```

:arrow_up_small: [Back to Content](#content)

---

### Adding a Rating Indicator to a Table

*Search term:* `#DataPointRatingTable`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/table_rating_ind.jpg" title="Bullet Micro Chart in Table" />

To add a rating indicator (stars) to the table, you first need to define a datapoint with `@UI.dataPoint`. The property where datapoint is defined sets how many stars are visible. Values between x.25 and x.74 are displayed as a half star. The attribute `targetValue` defines how many stars are possible. **Most importantly, the qualifier needs to match the property name.**

To show it in the table, `@UI.lineItem` annotation is needed.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
@UI: { 
  // Search Term #DataPointRating, #DataPointRatingTable
  dataPoint: {
    qualifier: 'StarsValue',
    targetValue: 4,
    visualization: #RATING,
    title: 'Rating Indicator (#DataPointRating)'
  },
  // Search Term #DataPointRatingTable
  lineItem: [
    {
      type: #AS_DATAPOINT,
      label: 'Rating Indicator (#DataPointRatingTable)',
      importance: #LOW,
      position: 70
    }
  ]
}
StarsValue;
```

Example: [ABAP RESTful Application Programming Model - Develop Node Extensions - Extension Node with Rating](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/develop-node-extensions#extension-node)

:arrow_up_small: [Back to Content](#content)

---

### Adding a Progress Indicator to a Table

*Search term:* `#DataPointProgressTable`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/table_progress_ind.jpg" title="Progress Indicator in Table" />

To add a progress indicator to the table, you first need to define a datapoint with `@UI.dataPoint`. The property where datapoint is defined sets the current progress and the attribute `targetValue`, the maximum progress. Additionally, a criticality can be given, if wanted. **Most importantly, the qualifier needs to match the property name.**

To show it in the table, `@UI.lineItem` annotation is needed.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
// Search Term #DataPointProgress, #DataPointProgressTable
@UI: {
  dataPoint: {
    qualifier: 'ProgressIntegerValue',
    targetValue: 100,
    visualization: #PROGRESS,
    criticality: 'CriticalityCode',
    title: 'Progress Indicator (#DataPointProgress)'
  },
  // Search Term #DataPointProgressTable
  lineItem: [
    {
      type:#AS_DATAPOINT,
      label: 'Progress Ind. (#DataPointProgressTable)',
      importance: #LOW,
      position: 60
    }
  ]
}
ProgressIntegerValue;
```

Example: [ABAP RESTful Application Programming Model - Develop Node Extensions - Extension Node with Progress](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/develop-node-extensions#extension-node)

:arrow_up_small: [Back to Content](#content)

---

### Adding a Smart Micro Chart to a Table

#### Bullet Micro Chart - Table

*Search term:* `#BulletMicroChartTable`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/table_bullet.jpg" title="Bullet Micro Chart in Table" />

To add a bullet micro chart to a table you have to first define a data point at the property where the value is to be taken from, which is the actual bar. The following attributes are also mandatory: `minimumValue` to render the chart properly, `forecastValue` for the bar in the background with a lower opacity, `targetValue` (or `targetValueElement`) for the dark line and  `qualifier` (**qualifier must be set to the name of the property**). Criticality is optional.

To show the chart, the property must then be annotated with `@UI.lineItem`.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
/// Search Term: #BulletMicroChart, #BulletMicroChartTable
@UI: {
  dataPoint: {
    qualifier: 'IntegerValue', //IntegerValue: horizontal bar in relation to the goal line
    targetValueElement: 'TargetValue', //visual goal line in the UI
    forecastValue: 'ForecastValue', //horizontal bar behind the value bar with, slightly larger with higher transparency
    criticality: 'CriticalityCode',
    minimumValue: 0 //Minimal value, needed for output rendering
  },
  // Search Term #BulletMicroChartTable
  lineItem: [{
    type:#AS_CHART,
    label: 'Bullet Chart (#BulletMicroChartTable)',
    valueQualifier: 'bulletChart',
    importance: #HIGH,
    position: 80
  }]
}
IntegerValue;
```

The data point needs to be referenced in a `@UI.chart` annotation in the measure attributes. The `chartType` must have value `#BULLET` for a bullet chart, attributes `measures` and `measureAttributes` are mandatory.

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

:arrow_up_small: [Back to Content](#content)

---

#### Radial Micro Chart - Table

*Search term:* `#RadialMicroChartTable`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/table_radial.jpg" title="Radial Micro Chart in Table" />

To add a radial micro chart to a table you have to first define a data point at the property where the value is to be taken from. The percentage value is the fraction of the property value and the target value, which is set in attribute `targetValue` (or `targetValueElement`). Both `criticality` and `criticalityCalculation` are supported, but if both are given `criticality` overrides `criticalityCalculation`. **Qualifier must be set to the name of the property.**

To show the chart, the property must then be annotated with `@UI.lineItem`.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
// Search Term #RadialMicroChart, #RadialMicroChartTable
@UI: {
  dataPoint: {
    qualifier: 'RadialIntegerValue',
    targetValueElement: 'TargetValue', //The relation between the value and the target value will be displayed as a percentage
    criticality: 'CriticalityCode'
  },
  // Search Term #RadialMicroChartTable
  lineItem: [
    {
      type: #AS_CHART,
      label: 'Radial Chart (#RadialMicroChartTable)',
      valueQualifier: 'radialChart',
      position: 110
    }
  ]
}
RadialIntegerValue;
```

The data point needs to be referenced in a `@UI.chart` annotation in the measure attributes. The `chartType` must have value `#Donut` for a radial chart, attributes `measures` and `measureAttributes` are mandatory.

```
// Search Term #RadialMicroChart, #RadialMicroChartTable
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

:arrow_up_small: [Back to Content](#content)

---

### Adding a Contact Quick View to a Table

*Search term:* `#ContactInHeader, #ContactInLineItem, #Contact`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/table_contact.jpg" title="Contact Quickview in Table" width="70%" height="70%" />

To have a data field which shows a contact with a contact quick view, the contact quick view needs to be implemented first. An example would be:

> [!NOTE] 
> Source: CDS View **/DMO/FSA_I_Contact**

```
// Search Term #Contact
define view entity /DMO/FSA_I_Contact
{
      @ObjectModel.text.element: ['Name'] // Search Term #DisplayTextAndID
  key id            as ID,

      @Semantics.name.fullName: true
      name          as Name,

      @Semantics.telephone.type: [#PREF]
      phone         as Phone,

      @Semantics.address.country: true
      country       as Country,

      @Semantics.address.street: true
      street        as Street,

      @Semantics.address.city: true
      city          as City,

      @Semantics.address.zipCode: true
      postcode      as Postcode,

      @Semantics.address.label: true
      address_label as AddressLabel
}
```

To show the contact card in the table you need to annotate the contact property with `@UI.lineItem` or if in a facet, with `@UI.fieldGroup`.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
@UI.facet: [
  {
    purpose    : #HEADER, // or #STANDARD
    label      : 'General Data (#HeaderFieldGroup)',
    type       : #FIELDGROUP_REFERENCE,
    targetQualifier: 'HeaderData'
  }
]

// Search Term #ContactInHeader
@UI.fieldGroup: [
  {
    qualifier: 'HeaderData',
    type: #AS_CONTACT,
    label: 'Contact QuickView (#ContactInHeader)',
    position: 70,
    value: '_Contact'
  }
]

// Search Term #ContactInLineItem
@UI.lineItem: [
  {
    type:#AS_CONTACT,
    label: 'Contact QuickView (#ContactInLineItem)',
    value: '_Contact',
    position: 120
  }
]
ContactID; 
```

More Information: [ABAP RESTful Application Programming Model - Contact Data](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/contact-data)

:arrow_up_small: [Back to Content](#content)

---

### Adding a Quick View to a Table

*Search term:* `#QuickViewTable`

> [!WARNING]  
> Only available with the latest [SAP BTP or SAP S/4HANA Cloud, public edition release](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-cloud) and for SAP S/4HANA, on-premise edition or SAP S/4HANA Cloud, private edition, from [release 2023](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-2023) onwards.

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/quickview_table.jpg" title="QuickView - Table" width="70%" height="70%" />

A quick view is a pop up that shows more information, when you click on an entry in a column or an object page. Typically, it is used in combination with one-to-one or zero-to-one associations. By clicking on the link, more information about the associated entity can be displayed. 

To set up an entity as QuickView, follow the steps here: [Setting up QuickView](/01_general_features.md#setting-up-quickview)

To show the QuickView in a table, just use annotation `@UI.lineItem` to add the property, with has referential constraint defined, into the table.

```
// Search Tern #QuickViewTable
@UI.lineItem: [
  { 
    label: 'Navigation (#QuickViewTable)',
    importance: #HIGH,
    position: 90
  }
]
NavigationID;
```

:arrow_up_small: [Back to Content](#content)

---

### Adding Multiple Fields to one Column in a Table

*Search term:* `#MultiFieldsCol`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/table_multi_field.jpg" title="Multi Field Column in Table" />

Multiple fields can be shown in one column, if a field group is added to line item (with annotations `@UI.lineItem` and `@UI.fieldGroup`). First you must define the field group and secondly the line item.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
@UI.fieldGroup: [{ qualifier: 'AdminData' }] // Search Term #MultiFieldsCol
CreatedAt;

@UI.fieldGroup: [{ qualifier: 'AdminData' }] // Search Term #MultiFieldsCol
LocalLastChangedBy;

@UI.fieldGroup: [{ qualifier: 'AdminData' }] // Search Term #MultiFieldsCol
LocalLastChangedAt;

// Search Term #MultiFieldsCol
@UI: { 
  fieldGroup: [{ qualifier: 'AdminData' }],
  lineItem: [
    {
      type: #AS_FIELDGROUP,
      label: 'Admin Data (#MultiFieldsCol)',
      valueQualifier: 'AdminData',
      importance: #HIGH,
      position: 100
    }
  ]
}
CreatedBy;
```

:arrow_up_small: [Back to Content](#content)

---

### Adding Images to a Table

*Search term:* `#Image`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/table_image.jpg" title="Image in Table" />

Images are typically the first column in a table and help to visually guide the user. An image can be added to a table by just adding a normal property to the line items.

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_RootTP**

```
// Search Term #Image
@UI.lineItem: [
  {
    cssDefault.width: '5em',
    position: 10,
    importance: #HIGH,
    label: '(#Image)'
  }
]
@EndUserText.quickInfo: '(#Image)'
ImageUrl;
```

The property which contains the image url has to, additionally, be annotated with `@Semantics.imageURL: true`.

> [!NOTE] 
> Source: CDS View **/DMO/FSA_I_Root**

```
@Semantics.imageUrl: true
image_url                 as ImageUrl,
```

:arrow_up_small: [Back to Content](#content)

---

### Adding Currency or UoM Fields to a Table

*Search term:* `#Units`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/table_currency.jpg" title="Field with Currency in Table" />

The special thing about quantity or price properties, is that they have an additional property of unit/currency. The property containing the quantity/price should be linked with the property for unit/currency. For units of measure the annotation is `@Semantic.quantity.unitOfMeasure` and for currency, it is `@Semantic.amount.currencyCode`.

> [!NOTE] 
> Source: CDS View **/DMO/FSA_I_Root**

```
// Search Term #Units
@Semantics.quantity.unitOfMeasure: 'Uom'
field_with_quantity       as FieldWithQuantity,

// Search Term #Units
@Semantics.amount.currencyCode: 'IsoCurrency'
field_with_price          as FieldWithPrice,
```

More Information: [ABAP RESTful Application Programming Model - Interaction with Other Annotations](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/interaction-with-other-annotations)

:arrow_up_small: [Back to Content](#content)

---

### Adding Large Object/Stream Property to a Table

*Search term:* `#Stream, #StreamTable`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/streams_table.jpg" title="Large Object/Streams - Table" />

You can enable your RAP application for maintaining large objects (LOBs). By doing so, you provide end users the option to incorporate external binary files or text files when editing entity instances. First the appropriate fields should be added into the database table and the CDS view, and also the annotations `@Semantics.largeObject` and `@Semantics.mimeType`. To show it in a table, you will need annotation `@UI.lineItem`. Lastly, you should also update the mapping and the draft table in your behaviour definition.

> [!NOTE] 
> Source: Database Table **/DMO/FSA_ChildA**

```
stream_filename    : abap.char(128);
stream_mimetype    : abap.char(128);
stream_file        : abap.rawstring(0);
```

> [!NOTE] 
> Source: CDS View **/DMO/FSA_C_ChildTP**

```
StreamFilename, // Search Term #Stream

// Search Term #Stream
@Semantics.largeObject: {
  acceptableMimeTypes: [ 'image/*', 'application/*' ],
  cacheControl.maxAge: #MEDIUM,
  contentDispositionPreference: #INLINE, // #ATTACHMENT - download as file
                                             // #INLINE - open in new window
  fileName: 'StreamFilename',
  mimeType: 'StreamMimeType'
}
StreamFile,

// Search Term #Stream
@Semantics.mimeType: true
StreamMimeType,
```

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_ChildTP**

```
// Search Term #Stream
@UI.hidden: true
StreamMimeType;

@UI.lineItem: [{ position: 40, label: 'Attachment (#StreamTable)' }] // Search Term #StreamTable
StreamFile;

// Search Term #Stream
@UI.hidden: true
StreamFilename;
```

> [!NOTE] 
> Source: BDEF **/DMO/FSA_R_ROOTTP**

```
define behavior for /DMO/FSA_R_ChildTP alias Child {
...
mapping for /dmo/fsa_child_a {
  ..
  StreamFile = stream_file;
  StreamFilename = stream_filename;
  StreamMimeType = stream_mimetype;
}
```

More Information: [ABAP RESTful Application Programming Model - Working with Large Objects](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/working-with-large-objects)

:arrow_up_small: [Back to Content](#content)

---

#### Static Field Control for Large Object/Stream Property

*Search term:* `#StreamStaticFeatureCtrl`

> [!WARNING]  
> Only available with the latest [SAP BTP or SAP S/4HANA Cloud, public edition release](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-cloud).

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/lr_stream_static_fc.jpg" title="Streams - Static Feature Control" />

It is possible to enable static field control for your large object property/attachment. This is done by adding the control in the behaviour definition.

In our example, we have set the stream property to readonly.

> [!NOTE] 
> Source: CDS View **/DMO/FSA_C_ChildTP**

```
// Search Term #StreamStaticFeatureCtrl
@Semantics.largeObject: {
  acceptableMimeTypes: [ 'image/*', 'application/*' ],
  cacheControl.maxAge: #MEDIUM,
  contentDispositionPreference: #ATTACHMENT , // #ATTACHMENT - download as file
                                              // #INLINE - open in new window
  fileName: 'StreamFilename',
  mimeType: 'StreamMimeType'
}
StreamFileReadonly,

StreamFilename, 

@Semantics.mimeType: true
StreamMimeType,
```

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_ChildTP**

```
// Search Term #StreamStaticFeatureCtrl
@UI: {
  lineItem: [
    { 
      position: 70, 
      label: 'Attachment (#StreamStaticFeatureCtrl)' 
    }
  ]
}
StreamFileReadonly;

// Search Term #Stream
@UI.hidden: true
StreamMimeType;

// Search Term #Stream
@UI.hidden: true
StreamFilename;
```

> [!NOTE] 
> Source: BDEF **/DMO/FSA_R_ROOTTP**

```
define behavior for /DMO/FSA_R_ChildTP alias Child .. {
  field ( readonly ) StreamFileReadonly; // Search Term #StreamStaticFeatureCtrl
}
```

More Information: [ABAP RESTful Application Programming Model - Static Feature Control](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/instance-feature-control#static-feature-control)

:arrow_up_small: [Back to Content](#content)

---

#### Dynamic Field Control for Large Object/Stream Property

*Search term:* `#StreamDynamicFeatureCtrl`

> [!WARNING]  
> Only available with the latest [SAP BTP or SAP S/4HANA Cloud, public edition release](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-cloud).

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/lr_stream_dynamic_fc.jpg" title="Streams - Dynamic Feature Control" />

It is possible to enable dynamic field control for your large object property/attachment. This is done by adding the control in the behaviour definition.

In our example, we set the stream property to readonly, when the boolean property `StreamIsReadOnly` is set to `true`. This can only be done when creating a new child instance, as the property `StreamIsReadOnly` itself has field control `readonly : update, mandatory : create`.

> [!NOTE] 
> Source: Database Table **/DMO/FSA_ChildA**

```
stream_filename    : abap.char(128);
stream_mimetype    : abap.char(128);
stream_file        : abap.rawstring(0);
stream_is_readonly : abap_boolean;
```

> [!NOTE] 
> Source: CDS View **/DMO/FSA_C_ChildTP**

```
StreamIsReadOnly, // Search Term #StreamDynamicFeatureCtrl
StreamFilename, // Search Term #Stream

// Search Term #Stream
@Semantics.largeObject: {
  acceptableMimeTypes: [ 'image/*', 'application/*' ],
  cacheControl.maxAge: #MEDIUM,
  contentDispositionPreference: #INLINE, // #ATTACHMENT - download as file
                                             // #INLINE - open in new window
  fileName: 'StreamFilename',
  mimeType: 'StreamMimeType'
}
StreamFile,

// Search Term #Stream
@Semantics.mimeType: true
StreamMimeType,
```

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_C_ChildTP**

```
// Search Term #StreamDynamicFeatureCtrl
@UI: {
  lineItem: [
    { 
      position: 50, 
      label: 'Stream readonly? (#StreamDynFeatureCtrl)' 
    }
  ]
}
@EndUserText: { 
  label: 'Stream readonly? Caution - cannot be changed after create',
  quickInfo: 'Stream readonly?'
}
StreamIsReadOnly;

// Search Term #Stream
@UI.hidden: true
StreamMimeType;

@UI: {
  // Search Term #StreamTable
  lineItem: [
    { 
      position: 60, 
      label: 'Attachment (#StreamTable)' 
    }
  ]
}
StreamFile;

// Search Term #Stream
@UI.hidden: true
StreamFilename;
```

> [!NOTE] 
> Source: BDEF **/DMO/FSA_R_ROOTTP**

```
define behavior for /DMO/FSA_R_ChildTP alias Child ... {
  field ( readonly : update, mandatory : create ) StreamIsReadOnly;
  ...
  mapping for /dmo/fsa_child_a {
    StreamFile = stream_file;
    StreamFilename = stream_filename;
    StreamMimeType = stream_mimetype;
  }
}
```

> [!NOTE] 
> Source: Behaviour Implementation **/DMO/FSA_BP_R_ROOTTP**

```
CLASS lhc_child IMPLEMENTATION.
  METHOD get_instance_features.
    READ ENTITIES OF /DMO/FSA_R_RootTP IN LOCAL MODE
      ENTITY Child
        FIELDS ( StreamIsReadOnly )
        WITH CORRESPONDING #(  keys  )
      RESULT DATA(children).

    result = VALUE #( FOR child IN children
                        ( %tky              = child-%tky
                          %field-StreamFile = COND #( WHEN child-StreamIsReadOnly  = abap_true
                                                        THEN if_abap_behv=>fc-f-read_only
                                                        ELSE if_abap_behv=>fc-f-unrestricted  )
                         ) ).
  ENDMETHOD.
ENDCLASS.
```

More Information: [ABAP RESTful Application Programming Model - Dynamic Feature Control](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/instance-feature-control#dynamic-feature-control)

:arrow_up_small: [Back to Content](#content)

---

### Adding Navigation with URL to a Table

*Search term:* `#Navigation-URL`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/url_navigation_table.jpg" title="URL Navigation - Table" />

You can set the text of a property as a link to an external website using the annotation `@UI.lineItem.type: #WITH_URL`.

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
// Search Term #Navigation-URL
@UI.lineItem: [
  {
    url: 'FieldWithUrl', //Target, when pressing the text
    label: 'URL Property (#Navigation-URL)',
    type: #WITH_URL,
    importance: #MEDIUM,
    position: 130
  }
]
FieldWithUrlText;
```

More Information: [ABAP RESTful Application Programming Model - With URL](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/with-url)

:arrow_up_small: [Back to Content](#content)

---