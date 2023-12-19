# Object Page - General Features

## Content
- [Object Page - General Features](#object-page---general-features)
    - [Annotations for Data Fields](#annotations-for-data-fields)
        - [Communication Properties](#communication-properties)
        - [Time and Date](#time-and-date)
        - [Multi line Text](#multi-line-text)
        - [Collective Value Help](#collective-value-help)
    - [Side Effects](#side-effects)
        - [Field affects field](#field-affects-field)
        - [Field affects entity](#field-affects-entity)
        - [Action affects field](#action-affects-field)
        - [Action affects permission](#action-affects-permission)
        - [Action affects entity](#action-affects-entity)
        - [Determine action executed on field affects messages](#determine-action-executed-on-field-affects-messages)
        - [Determine action executed on entity affects messages](#determine-action-executed-on-entity-affects-messages)

## Annotations for Data Fields

### Communication Properties

*Search term:* `#CommunicationFields`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/communication.jpg" title="Communication - Object Page" />

To display emails and phone numbers as a link, they are annotated with `@Semantics.email.address: true` or `@Semantics.telephone.type`

> [!NOTE] 
> Source: CDS View **/DMO/FSA_I_Root**

```
// Search Term #CommunicationFields
@Semantics.eMail.address: true
email                     as Email,

// Search Term #CommunicationFields
@Semantics.telephone.type: [#CELL]
telephone                 as Telephone,
```

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
// Search Term #Communication
@UI.facet: [
  {
    purpose: #HEADER, // or #STANDARD
    label      : 'Communication Subsection(#Communication)',
    type       : #FIELDGROUP_REFERENCE,
    targetQualifier: 'communication'
  }
]

@UI.fieldGroup: [{ qualifier: 'communication' }] // Search Term #Communication
Email;

@UI.fieldGroup: [{ qualifier: 'communication' }] // Search Term #Communication
Telephone;
```

More Information: [ABAP RESTful Application Programming Model - Contact Data](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/contact-data)

:arrow_up_small: [Back to Content](#content)

---

### Time and Date

*Search term:* `#TimeAndDate`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/time_and_date.jpg" title="Time and Date - Object Page" />

SAP Fiori Elements provides out of the box support for displaying and editing dates and times, as well as time stamps. No additional annotations are needed, the properties just need to have the corresponding data types.

The following annotations are used in the app, in order to group the time and date fields and show them in a facet.

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
// Search Term #TimeAndDate
@UI.facet: [
  {
    purpose: #HEADER, // or #STANDARD
    label      : 'Time and Date (#TimeAndDate)',
    type       : #FIELDGROUP_REFERENCE,
    targetQualifier: 'timeAndDate'
  }
]

@UI.fieldGroup: [{ qualifier: 'timeAndDate' }] // Search Term #TimeAndDate
ValidTo;

@UI.fieldGroup: [{ qualifier: 'timeAndDate' }] // Search Term #TimeAndDate
Time;

@UI.fieldGroup: [{ qualifier: 'timeAndDate' }] // Search Term #TimeAndDate  
Timestamp;
```

:arrow_up_small: [Back to Content](#content)

---

### Multi line Text

*Search term:* `#MultiLineText`

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/multilinetext.jpg" title="Multi Line Text - Object Page" />

With the annotation `@UI.multiLineText` longer strings are displayed in multiple lines.

> [!NOTE] 
> Source: Metadata Extension  **/DMO/FSA_C_RootTP**

```
@UI.multiLineText: true // Search Term #MultiLineText
Description;

@UI.multiLineText: true // Search Term #MultiLineText
DescriptionCustomGrowing;
```

More Information: [ABAP RESTful Application Programming Model - Multi-Line Text](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/multi-line-text)

:arrow_up_small: [Back to Content](#content)

---

### Collective Value Help

*Search term:* `#CollectiveValueHelp`

For SAP GUI-based applications it is possible to define a collective search help that combines several elementary search helps. You can choose one of several alternative search paths and retrieve input values from multiple sources/tables in a single dialog. In Fiori UI this is also possible via a collective value help using an **abstract entity** comprising a list of assigned elementary search helps and potential mappings of the bound field names.

The collective value help shall be annotated with `@ObjectModel.collectiveValueHelp.for.element` pointing to the field, for which the collective value help is defined. The field referenced by `@ObjectModel.collectiveValueHelp.for.element` shall be assigned at least a single elementary value help using annotation `@Consumption.valueHelpDefinition`.

Only the following keywords can be used for a collective value help: `entity.name`, `entity.element`, `additionalBinding.localElement`, `additionalBinding.element` and `qualifier`.

> [!NOTE] 
> Source: CDS Abstract Entity **/DMO/FSA_D_CountryCVH**

```
@EndUserText.label: 'Country Collective Value Help'
@ObjectModel.supportedCapabilities:[#COLLECTIVE_VALUE_HELP]
@ObjectModel.modelingPattern:#COLLECTIVE_VALUE_HELP
@ObjectModel.collectiveValueHelp.for.element: 'Country'

// Search Term #CollectiveValueHelp
define abstract entity /DMO/FSA_D_CountryCVH
{
  @Consumption.valueHelpDefinition:[
    // 'Default' VH
    { 
      entity: { name:'I_Country' },
      label: 'Search by Country' 
    },
    // additional VH, set qualifier
    { 
      entity: { name:'/DMO/FSA_I_ContactVH',
                element:'Country' },
      label: 'Search by Contact',
      qualifier: 'ContactSearch' 
    },
    // additional VH, set qualifier
    { 
      entity: { name:'I_RegionVH',
                element:'Country' },
      additionalBinding: [{ localElement:'Region',
                            element:'Region'  }],
      label: 'Search by Region',
      qualifier:  'RegionSearch' 
    }
  ]
  Country : land1;
  Region  : regio;
}
```

The consumer view of the collective value help has to define the same fields, that are used in the collective value help definition (respectively bind all corresponding local fields via @Consumption.valueHelpDefinition.additionalBinding... to the collective value help fields).

> [!NOTE] 
> Source: CDS View **/DMO/FSA_R_RootTP**

```
// Search Term #CollectiveValueHelp
@Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/FSA_D_CountryCVH',  element: 'Country' },
                                      additionalBinding: [{ element: 'Region', 
                                                            localElement: 'Region' }]  }]
Country,
...
Region,
```

:arrow_up_small: [Back to Content](#content)

---

## Side Effects

*Search term:* `#SideEffects, #SideEffectsSection`

> [!WARNING]  
> Only available with the latest [SAP BTP or SAP S/4HANA Cloud, public edition release](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-cloud) and for SAP S/4HANA, on-premise edition or SAP S/4HANA Cloud, private edition, from [release 2023](https://github.com/SAP-samples/abap-platform-fiori-feature-showcase/tree/ABAP-platform-2023) onwards.

Side Effects annotations specify to the UI, which targets to be refreshed in order to show updated values that arises from field changes, actions, or determine actions. Side effects are defined in the behaviour definition. There are a variety of ways to annotate side effects by combining the triggers and the affected components, and a few examples are shown in the app:

> [!WARNING]  
> If you use projection, remember to add the following to your projection behaviour definition.

```
projection...

use side effects;
define behavior for ProjectionView {
}
```

### Field affects field

*Fields from same level entity*

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/SideEffects/se-field-a-field.gif" title="Side Effects - Field affects Field" width="50%" height="50%" />

When the user changes the value of `IntegerValue`, the determination `setIntegerValue` is called and modifies the values of `ProgressIntegerValue` and `RadialIntegerValue`. In order for these 2 fields to show the updated values without a refresh, side effects is required to request UI to reload these 2 fields.

> [!NOTE] 
> Source: Behaviour Definition **/DMO/FSA_R_RootTP**

```
define behavior for /DMO/FSA_R_RootTP alias Root
...
{
  determination setIntegerValue on modify { field IntegerValue; }

  side effects {
    field IntegerValue affects field ProgressIntegerValue, field RadialIntegerValue;
  }
}
```

---

*Fields from associated entity*

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/SideEffects/se-field-a-afield.gif" title="Side Effects - Field affects Associated Field" />

It is also possible to define as target, a field from an assoicated entity. When the field `ChildPieces` in Child entity is modified, this will trigger the determination `calculateTotalPieces` to total up the pieces of all child instances. Side effects will trigger the refresh of field `TotalPieces` from the Root entity to show the calculated total every time user enters a value at the child instance.

> [!NOTE] 
> Source: Behaviour Definition **/DMO/FSA_R_RootTP**

```
define behavior for /DMO/FSA_R_ChildTP alias Child
persistent table /dmo/fsa_child_a
draft table /dmo/fsa_child_d
lock dependent by _Root
authorization dependent by _Root
{
  determination calculateTotalPieces on modify { field ChildPieces; }

  side effects {
    field ChildPieces affects field _Root.TotalPieces;
  }
}
```

---

### Field affects entity

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/SideEffects/se-field-a-entity.gif" title="Side Effects - Field affects Entity"/>

When `NavigationID` is changed, the associated entity `_Navigation` will reload and all fields of the association will change.

> [!NOTE] 
> Source: Behaviour Definition **/DMO/FSA_R_RootTP**

```
define behavior for /DMO/FSA_R_RootTP alias Root
...
{
  side effects {
    field NavigationID affects entity _Navigation;
  }
}
```

---

### Action affects field

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/SideEffects/se-action-a-field.gif" title="Side Effects - Action affects Field" />

When `resetTimesChildCreated` is executed, the field `TimesChildCreated` will be set to 0.

> [!NOTE] 
> Source: Behaviour Definition **/DMO/FSA_R_RootTP**

```
define behavior for /DMO/FSA_R_RootTP alias Root
...
{
  action ( features : instance ) resetTimesChildCreated;

  side effects {
    action resetTimesChildCreated affects field TimesChildCreated;
  }
}
```

---

### Action affects permission

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/SideEffects/se-action-a-permission.gif" title="Side Effects - Action affects Permission" />

When `resetTimesChildCreated` is executed, instance feature control will disable the action button `resetTimesChildCreated`.

> [!NOTE] 
> Source: Behaviour Definition **/DMO/FSA_R_RootTP**

```
define behavior for /DMO/FSA_R_RootTP alias Root
...
{
  action ( features : instance ) resetTimesChildCreated;

  side effects {
    action resetTimesChildCreated affects permissions ( action resetTimesChildCreated );
  }
}
```

---

### Action affects entity

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/SideEffects/se-action-a-entity.gif" title="Side Effects - Action affects Entity" />

When `createChildFromRoot` is executed, a new Child instance is created. Since the associated entity `_Child` is a list table, the list will reload to also show the newly created instance.

> [!NOTE] 
> Source: Behaviour Definition **/DMO/FSA_C_RootTP**

```
define behavior for /DMO/FSA_C_RootTP alias Root
{
  action ( features : instance ) createChildFromRoot result [0..1] entity /DMO/FSA_C_ChildTP;

  side effects {
    action createChildFromRoot affects entity _Child;
  }
}
```

> [!NOTE] 
> Source: Metadata Extension **/DMO/FSA_R_RootTP**

```
annotate entity /DMO/FSA_C_RootTP with
{
  @UI.facet: [
    {
      purpose: #STANDARD,
      type: #PRESENTATIONVARIANT_REFERENCE,
      targetElement: '_Child',
      targetQualifier: 'pVariant',
      label: 'Child Entity (1..n)(#OPTable)',
      id: 'childEntitiesSection'
    }
  ]
  ...
}
```

---

### Determine action executed on field affects messages

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/SideEffects/se-daction-e-field-a-messages.gif" title="Side Effects - Determine Action executed on Field affects Messages" />

When field `ValidTo` is modified, this will trigger the determine action, which is a validation in this case. Any error messages arising from the validation will pop up immediately via sticky messages.

> [!NOTE] 
> Source: Behaviour Definition **/DMO/FSA_R_RootTP**

```
define behavior for /DMO/FSA_R_RootTP alias Root
...
{
  validation validateValidTo on save   { create; update; field ValidTo; }
  determine action validateDate { validation validateValidTo; }

  side effects {
    determine action validateDate executed on field ValidTo affects messages;
  }
}
```

---

### Determine action executed on entity affects messages

<img src="https://raw.githubusercontent.com/SAP-samples/abap-platform-fiori-feature-showcase/main/Images/Guide/SideEffects/se-daction-e-entity-a-messages.gif" title="Side Effects - Determine Action executed on Entity affects Messages" />

When any fields from entity `_Child` is modified, this will trigger the determine action, which is a validation defined at Child. Any error messages arising from the validation will pop up immediately via sticky messages.

> [!NOTE] 
> Source: Behaviour Definition **/DMO/FSA_R_RootTP**

```
define behavior for /DMO/FSA_R_RootTP alias Root
...
{
  determine action validateChild { validation Child ~ validatePercentage; }

  side effects {
    determine action validateChild executed on entity _Child affects messages;
  }
}

define behavior for /DMO/FSA_R_ChildTP alias Child
...
{
  validation validatePercentage on save { create; update;  }
}
```

More Information: [ABAP RESTful Application Programming Model - Side Effects](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/side-effects)

:arrow_up_small: [Back to Content](#content)

---