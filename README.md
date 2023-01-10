[![REUSE status](https://api.reuse.software/badge/github.com/sap-samples/abap-platform-fiori-feature-showcase)](https://api.reuse.software/info/github.com/sap-samples/abap-platform-fiori-feature-showcase)

# Fiori Element Feature Showcase App for the ABAP RESTful Application Programming Model
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
* You have access to an SAP BTP ABAP Environment instance (see [here](https://blogs.sap.com/2018/09/04/sap-cloud-platform-abap-environment) for additional information).
* You have downloaded and installed ABAP Development Tools (ADT). Make sure to use the most recent version as indicated on the [installation page](https://tools.hana.ondemand.com/#abap). 
* You have created an ABAP Cloud Project in ADT that allows you to access your SAP BTP ABAP Environment instance (see [here](https://help.sap.com/viewer/5371047f1273405bb46725a417f95433/Cloud/en-US/99cc54393e4c4e77a5b7f05567d4d14c.html) for additional information). Your log-on language is English.
* You have installed the [abapGit](https://github.com/abapGit/eclipse.abapgit.org) plug-in for ADT from the update site `http://eclipse.abapgit.org/updatesite/`.

## Download
Use the abapGit plug-in to install the <em>Feature Showcase App</em> by executing the following steps:
1. In your ABAP cloud project, create the ABAP package `/DMO/FEATURE_SHOWCASE_APP` (using the superpackage `/DMO/SAP`) as the target package for the demo content to be downloaded (leave the suggested values unchanged when following the steps in the package creation wizard).
2. To add the <em>abapGit Repositories</em> view to the <em>ABAP</em> perspective, click `Window` > `Show View` > `Other...` from the menu bar and choose `abapGit Repositories`.
3. In the <em>abapGit Repositories</em> view, click the `+` icon to clone an abapGit repository.
4. Enter the following URL of this repository: `https://github.com/SAP-samples/abap-platform-fiori-feature-showcase.git` and choose <em>Next</em>.
5. Select the branch `ABAP-platform-cloud` and enter the newly created package `/DMO/FEATURE_SHOWCASE_APP` as the target package and choose <em>Next</em>.
6. Use the transport request that you have created for the package for this demo content installation (recommendation) and choose <em>Finish</em> to link the Git repository to your ABAP cloud project. The repository appears in the abapGit Repositories View with status <em>Linked</em>.
7. Right-click on the new ABAP repository and choose `pull` to start the cloning of the repository contents. Note that this procedure may take a few minutes. 
8. Once the cloning has finished, the status is set to `Pulled Successfully`. (Refresh the `abapGit Repositories` view to see the progress of the import). Then refresh your project tree. 

As a result of the installation procedure above, the ABAP system creates an inactive version of all artifacts from the demo content.

NOTE: The service binding of the app is imported with the warning: `To enable activation of local service endpoint, generate service artifacts`. 

## Configuration

### Activation
To activate all development objects from the `/DMO/FEATURE_SHOWCASE_APP` package: 
1. Click the mass-activation icon (<em>Activate Inactive ABAP Development Objects</em>) in the toolbar.  
2. In the dialog that appears, select all development objects in the transport request (that you created for the demo content installation) and choose `Activate`. Please ignore the error messages that appear after this mass activation.
3. Perform the mass-activation again. 

### Publishing the service binding
To generate service artifacts for the service binding `/DMO/UI_FEATURESHOWCASEAPP`:
1. Choose the button `Publish` or choose `Publish local service endpoint` in the top right corner of the editor.

### Generate data
To fill the demo database tables with sample data: 
1. Expand the package structure in the Project Explorer `/DMO/FEATURE_SHOWCASE_APP` > `Source Code Library` > `Classes`.
2. Select the data generator class `/DMO/FSA_CL_DATA_GENERATOR` and press `F9` (Run as Console Application). 

NOTE: The namespace /DMO/ is reserved for the demo content. Apart from the downloaded demo content, do not use the namespace /DMO/ and do not create any development objects in the downloaded packages. You can access the development objects in /DMO/ from your own namespace.

## How to obtain support
This project is provided "as-is": there is no guarantee that raised issues will be answered or addressed in future releases.

## License
Copyright (c) 2022 SAP SE or an SAP affiliate company. All rights reserved. This project is licensed under the SAP Sample Code License except as noted otherwise in the [LICENSE](LICENSE) file.
