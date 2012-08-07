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

![Choose Initial Components](https://github.com/BracketLabs/AppExchange-Team-Development-on-Force.com-Platform-Demo/blob/master/-image/choose_initial_project_conents.png?raw=true)

And you have a development environment ready to go. Initializing your Force.com Org by right-clicking the directory tree and clicking 'Save to Server'.

![Choose Initial Components](https://github.com/BracketLabs/AppExchange-Team-Development-on-Force.com-Platform-Demo/blob/master/-image/jordan@dfjordancom_ide.png?raw=true)




