# Team Development on the SFDC Platform #

>	This repo contains a demo project developed in Salesforce.com APEX, Javascript
>	VisualForce for demonstrating how a team dedicated to building applications
>	on the SFDC platform and releasing them via the embedded distribution channel
>	the AppExchange.

## Getting Started ##

Developers should have a general understanding of the following development concepts 
to better understand the material presented here:

+ Salesforce.com APEX, Visualforce in the Force.com IDE
+ Git (Version control)
+ Amazon AWS (Hosted virtual machine for running intermediary applications)
+ Jenkins (Continuous development build manager)
+ ANT (Java framework for automating the deployment of SFDC 'Meta-data' between orgs)

### Developing ###

The SFDC Platform uses the concept of an 'organization' for development purposes. This is 
semi-analogous to an installation of the application stack in any other web-based platform.

These 'organizations' are delimited by a username in for the format of an email address.

A developer 'org' can be optained from: http://developer.salesforce.com

The process for team developement relys on a series of orgs to develop and test applications
and ulimately a specially annointed org, (aka "Packaging Org") where an application that is 
'packaged' for distribution to the AppExchange.

In total, this team development process recommends a total of 3 SFDC Orgs (naming convention is
useful but non-critical):

1. developer@project_developer.com (individual developer org) 
2. developer@project_test.com (testing environment, for UAT's)
3. developer@project.com (packaging org, manaaged package origin, beta package origin)

#### Phase 1 - Joining the development cycle ####

Clone or establish a Git repository into the Force.com IDE workspace, using the following file
structure:

>project_name/src

Example:

	git clone https://github.com/BracketLabs/AppExchange-Team-Development-on-Force.com-Platform-Demo jordan@dfjordan.com/src

Next, establish a new Force.com Project with the same name as the directory that is the parent of the 'src' folder:

![Create Project in Force.com IDE](https://github.com/BracketLabs/AppExchange-Team-Development-on-Force.com-Platform-Demo/blob/master/-image/create_a_forcecom_project.png?raw=true)

And choose not to download any components (granted the repo has already been established):

![Choose Initial Components](https://github.com/BracketLabs/AppExchange-Team-Development-on-Force.com-Platform-Demo/blob/master/-image/choose_initial_project_contents.png?raw=true)

And you have a development environment ready to go.

![Choose Initial Components](https://github.com/BracketLabs/AppExchange-Team-Development-on-Force.com-Platform-Demo/blob/master/-image/jordan@dfjordancom_ide.png?raw=true)

_Initializing your Force.com Org by right-clicking the directory tree and clicking 'Save to Server'._ (The metadata API may complain about previous components having been replaced, or having been updated since you last 'Saved to Server'. Since Git is the standard for where our development code base is at, goahead and replace the elements on the 
server as necessary.)

#### Phase 2 - Building the source code for testing ####

Git acts as the traffic-light when it comes to checking in changes you've made on the individual developer org. I won't go into the specifics of Git source control, but once you (as the individual developer) have completed the changes you wish to make to the source control, you need to contribute your changes to the centralized repository.

Since Git and hosted Git repositories are seperate and apart from SFDC's developer environments, we need to use a tool from SFDC to move raw source-code into other orgs, 
without repeating the same process we just used for populating the individual developer org.

For this we'll use SFDC's *Ant Migration Tool* and a build-manager called Jenkins hosted on a 'Cloud Virtual Machine'

To save you some time use this Amazon AWS AMI that is preinstalled with a few of the tools necessary.

In our Jenkins Project, we will 'watch' the hosted Git repository and trigger a build when a new commit has been pushed into the repo.

![Choose Initial Components](https://github.com/BracketLabs/AppExchange-Team-Development-on-Force.com-Platform-Demo/blob/master/-image/jenkins_github_configuration.png?raw=true)

The Jenkin's build project basically runs 2 operations from the shell to populate our 'Test Org'

	git clone https://github.com/BracketLabs/AppExchange-Team-Development-on-Force.com-Platform-Demo sourceCode
	ant deployUnpackaged

The first step, copies the source-code from the hosted github repo, and the second uses the SFDC Ant Migration plugin to deploy the sourceCode in the 'sourceCode' directory to the test org.

Configurations for the Ant Migration tool are stored in 'build.xml' and 'build.properties'

They can be customized as needed, and there are more methods in the ANT migration tool for invoking test methods, etc. However, they are not being used for this process.

![Choose Initial Components](https://github.com/BracketLabs/AppExchange-Team-Development-on-Force.com-Platform-Demo/blob/master/-image/jenkins_console_output.png?raw=true)

Once the build has completed, the testing org is ready for UAT. The product owner can approve the team's work in a single org.

![Choose Initial Components](https://github.com/BracketLabs/AppExchange-Team-Development-on-Force.com-Platform-Demo/blob/master/-image/app_deployed_in_test_org.png?raw=true)

#### Phase 3 - Building the managed package and namespacing ####

The final step in building an App for the AppExchange is migrating it to the 'Packaging Org'. 

Apps that use the 'managed package' system on SFDC must have a namespace prefix. More about that here: https://github.com/jordanbaucke/sfdc-namespace-prefix

In addition to namespacing, to keep our App's code functioning normally once it has been installed into a customer's org, developers need to account for a number of items such as testing for specific Salesforce features that may or may-not be enabled in that customer's organization.

Before _uploading_ your managed package, add all components, and review dependencies.

![Review Dependencies](https://github.com/BracketLabs/AppExchange-Team-Development-on-Force.com-Platform-Demo/blob/master/-image/packaging_add_review_dependencies.png?raw=true)

Once the managed package includes components and these dependencies cannot be changed.
![Review Information](https://github.com/BracketLabs/AppExchange-Team-Development-on-Force.com-Platform-Demo/blob/master/-image/dependency_information_review.png?raw=true)




