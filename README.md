[![REUSE status](https://api.reuse.software/badge/github.com/sap-samples/abap-platform-fiori-feature-showcase)](https://api.reuse.software/info/github.com/sap-samples/abap-platform-fiori-feature-showcase)

# SAP Fiori Element Feature Showcase App for the ABAP RESTful Application Programming Model
![App List Report](/Images/app-list.jpg)
![App Object Page](/Images/app-objectpage.jpg)

The focus of this project is to demonstrate the features of annotation-driven SAP Fiori Elements for oData V4, using the ABAP RESTful Application Programming Model (RAP). The oData V4 app has been developed to be transactional- and draft- enabled.

To run the feature showcase app, pull the source code from GitHub into your system (see instructions below for different system types), locate the Service Binding and publish it locally. You can start the app preview by selecting the Root node. You can also run it by building your own Fiori app using the SAP Business Application Studio and connecting to the backend via the service binding.

> [!TIP]  
> A corresponding app built using CAP can be found at https://github.com/SAP-samples/fiori-elements-feature-showcase.

> [!IMPORTANT]  
> A number of issues have been identified and documented in the Wiki [Identified Constraints](/../../wiki/Identified-Constraints).

---
<br/>

## :wrench: How To... Build

### For ABAP Platform Cloud
Choose this if you are working on SAP BTP or SAP S/4HANA Cloud, public edition. 

To import the feature showcase app into your ABAP Environment, follow the steps in the [README](../ABAP-platform-cloud/README.md) file of the branch <em>ABAP-platform-cloud</em> and download the sources from this branch. 

### For ABAP Platform
Choose this if you are working on SAP S/4HANA, on-premise edition or SAP S/4HANA Cloud, private edition.

To import the feature showcase app into your ABAP system, follow the steps in the relevant README file and download the sources from the branch corresponding to your backend version: 

* [README](../ABAP-platform-2022/README.md) of branch <em>ABAP-platform-2022</em> (Application Server ABAP 7.57)
* [README](../ABAP-platform-2023/README.md) of branch <em>ABAP-platform-2023</em> (Application Server ABAP 7.58)

### SAP BTP ABAP Environment Trial

If you don’t have a system available, you could also try it out in the SAP BTP ABAP Environment Trial systems. Check out this [tutorial](https://developers.sap.com/tutorials/abap-environment-trial-onboarding.html) on how to get a trial user.

<br/>

## :book: How To... Use the Guide

The Guide is divided into 6 sections

| Documentation | Description |
| ----- | ----- |
| [General Features](/01_general_features.md)  | Describes the features that are generally used throughout, be it in the List Report or Object Page |
| [List Report - Header](/02_list_report_header.md)  | Describes the features that are for the header area of the List Report |
| [List Report - Content](/03_list_report_content.md)  | Describes the features that are for the content area of the List Report  |
| [Object Page - General](/04_object_page_general.md)  | Describes the features that are generally used for Object Page |
| [Object Page - Header](/05_object_page_header.md)  | Describes the features that are for the header area of the Object Page  |
| [Object Page - Content](/06_object_page_content.md)  | Describes the features that are for the content area of the Object Page  |

When you see a feature that you would like to implement, copy or take note of the search term (e.g., **#SearchTermExample**) and perform a search in the Repository. Clicking on a result brings you to the markdown code of the respective Guide, so just click on the Preview and search for the term again.

<img src="/Images/search.gif" alt="How to search" title="How to search" >

From the Guide, you will get 

* a short description of the feature, 
* code snippets and where to find them in the source code, 
* and in some cases, a link to the official RAP documentation for more information.

Alternatively, you can search for an annotation in the Guide, get the search term, and use it to locate the UI feature in the app. If the annotation cannot be found, it could simply mean that it is not showcased in the current release.

<br/>

## :telephone_receiver: How To... Obtain Support
This project is provided "as-is": there is no guarantee that raised issues will be answered or addressed in future releases. However we do welcome your comments or reports, so please use the Issues feature to report them.

<br/>

## :memo: License
Copyright (c) 2022 - 2024 SAP SE or an SAP affiliate company. All rights reserved. This project is licensed under the SAP Sample Code License except as noted otherwise in the [LICENSE](/LICENSES/Apache-2.0.txt) file.
