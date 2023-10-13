[![REUSE status](https://api.reuse.software/badge/github.com/sap-samples/abap-platform-fiori-feature-showcase)](https://api.reuse.software/info/github.com/sap-samples/abap-platform-fiori-feature-showcase)

# SAP Fiori Element Feature Showcase App for the ABAP RESTful Application Programming Model
![App List Report](/../main/Images/app-list.jpg)
![App Object Page](/../main/Images/app-objectpage.jpg)

The focus of this project is to demonstrate the features of annotation-driven SAP Fiori Elements for oData V4, using the ABAP RESTful Application Programming Model (RAP). The oData V4 app has been developed to be transactional- and draft- enabled.

To run the feature showcase app, pull the source code from GitHub into your system (see instructions below), locate the Service Binding and publish it locally. You can start the app preview by selecting the Root node. You can also run it by building your own Fiori app using the SAP Business Application Studio and connecting to the backend via the service binding.

<img src="/../main/Images/search.gif" alt="How to search" title="How to search" width="80%" height="80%">

When you see a feature that you would like to implement, copy or take note of the search term (e.g., **#SearchTermExample**) and perform a search in the [Guide](/../../wiki/Feature-Showcase-App-Guide). You will be presented with 

* a short description of the feature, 
* code snippets and where to find them in the source code, 
* and in some cases, a link to the official RAP documentation for more information.

Alternatively, you can search for an annotation in the [Guide](/../../wiki/Feature-Showcase-App-Guide), get the search term, and use it to locate the UI feature in the app. If the annotation cannot be found, it could simply mean that it is not showcased in the current release.

A number of issues have been identified and documented in the Wiki [Identified Constraints](/../../wiki/Identified-Constraints).

A corresponding app built using CAP can be found at https://github.com/SAP-samples/fiori-elements-feature-showcase.

## Prerequisites
Make sure to fulfill the following requirements:
* You are working on Application Server ABAP 7.58 or higher. 
* You have downloaded and installed ABAP Development Tools (ADT). Make sure to use the most recent version as indicated on the [installation page](https://tools.hana.ondemand.com/#abap). 
* You have created an ABAP Project in ADT that allows you to access your Application Server as mentioned above. Your log-on language is English.
* You have downloaded and installed the `zabapgit_standalone` report. Make sure to use the most recent version as indicated on the [installation page](https://docs.abapgit.org/). 
* You have installed the certificate files for github.com, see [abapGit Documentation](https://docs.abapgit.org/guide-ssl-setup.html). 

## Set Up Namespace
SAP uses a reserved namespace for the demo objects. 

To enable the namespace in your customer system, follow the steps described in [Setting Up a Namespace for Development](https://help.sap.com/docs/SAP_NETWEAVER_750/4a368c163b08418890a406d413933ba7/bdddbe08ac5c11d2850e0000e8a57770.html). For step 8, enter the following values: 
* Namespace: `/DMO/`
* Namespace Role : `C`
* Repair license: `32869948212895959389`
* Short Text: Enter a suitable description for the namespace  , for example `SAP Demo Scenarios`.
* Owner: `SAP` 

Choose `save` and write the changes to a transport. 

To be able to import /DMO/ objects into your system, set the system change option. Proceed as follows: 
1.	Go to  <em>Transport Organizer Tools</em> (transaction `SE03`) 
2.	Go to <em>Administration</em> and start the program `Set System Change Option`.
3.	In the table <em>Namespace/Name Range</em> table search for the <em>/DMO/</em> namespace. 
4.	In the column <em>Modifiable</em> change the entry to `Modifiable`. 
5.	Save the settings.

For more information, see [Setting the System Change Option](https://help.sap.com/docs/SAP_NETWEAVER_750/4a368c163b08418890a406d413933ba7/5738de9b4eb711d182bf0000e829fbfe.html). 

## Download
Use the <em>zabapgit_standalone</em> program to install the <em>Feature Showcase App</em> by executing the following steps:
1.	In your ABAP project, create the package `/DMO/FEATURE_SHOWCASE_APP` as target package for the demo content. Use `HOME` as software component. Assign it to a new transport request that you only use for the demo content import. 
2.	In your ABAP project, run the program `zabapgit_standalone`.  
3.	Choose `New Online` and enter the following URL of this repository  `https://github.com/SAP-samples/abap-platform-fiori-feature-showcase.git`. 
4.	In the package field, enter the newly created package `/DMO/FEATURE_SHOWCASE_APP`. In the branch field, select the branch `ABAP-platform-2023`.
5.	Leave the other fields unchanged and choose `Create Online Repo`.
6. Enter your credentials for abapgit. You will see the available artifacts to import into your ABAP system. 
7.	Choose `Pull` and confirm every subpackage on your transport request. 
8.	Select the package `/DMO/FEATURE_SHOWCASE_APP` to be overwritten with the demo content. In some cases, the shown ZABAPGIT dialogue offers you to delete the /DMO/ namespace locally. Do not delete the /DMO/ namespace locally because the pull operation will fail if no suitable namespace exists in your package.
9. You will get an information screen telling you to only make repairs when they are urgent, which you can confirm. You can also confirm the dialogue telling you that objects can only be created in the package of the namespace /DMO/.  
10. In the following screen, select all inactive objects and confirm the activation.
11.	Once the cloning has finished, refresh your project tree.

As a result of the installation procedure above, the ABAP system creates an inactive version of all artifacts from the demo content.

NOTE: The service binding of the app is imported with the warning: `To enable activation of local service endpoint, generate service artifacts`. 

NOTE: If you pull the repository again after a successfull import, make sure that you do not delete the local objects `G4BA`, `SUSH` and `NSPC`.

## Configuration
To generate service artifacts for the service binding `/DMO/UI_FEATURESHOWCASEAPP`:
1. Choose the button `Publish` or choose `Publish local service endpoint` in the top right corner of the editor.

To fill the demo database tables with sample data: 
1. Expand the package structure in the Project Explorer `/DMO/FEATURE_SHOWCASE_APP` > `Source Code Library` > `Classes`.
2. Select the data generator class `/DMO/FSA_CL_DATA_GENERATOR` and press `F9` (Run as Console Application). 

NOTE: The namespace /DMO/ is reserved for the demo content. Apart from the downloaded demo content, do not use the namespace /DMO/ and do not create any development objects in the downloaded packages. You can access the development objects in /DMO/ from your own namespace.

## How to obtain support
This project is provided "as-is": there is no guarantee that raised issues will be answered or addressed in future releases.

## License
Copyright (c) 2022 - 2023 SAP SE or an SAP affiliate company. All rights reserved. This project is licensed under the SAP Sample Code License except as noted otherwise in the [LICENSE](LICENSE) file.
