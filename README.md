# sfrunner

This is a docker image that contains everything needed to build,
run, and test service finder.

# Why does this exist?

Service finder was previously run through a huge series
of makefiles.  This was both slow to run and difficult to
debug and maintain.  One approach of those makefiles was
to run every command inside a separate docker container.

This system takes the opposite approach of that, with one
docker container that contains every dependency, such that
all development and testing can be done inside the container.
      
## Prerequisites

You need to have the following installed:
                                                                  
### Docker

Download Docker desktop from [Docker](https://www.docker.com/) 

### Taskfile

If you want to be able to build and run the tasks for sfrunner itself,
it helps to have taskfile installed.  You can follow the instructions at
[Taskfile](https://taskfile.dev/#/installation) to install it.

### Leapp
        
This enables you to 'assume' using a friendly UI, and use the assumed role inside sfrunner

Download from [Leapp](https://www.leapp.cloud/download/desktop-app) 

Once installed, set Leapp up:
   
First, add the integration
* Run Leapp
* Under 'Integrations' in the left sidebar, click +
* Add new integration dialog comes up
* Set integration type to be AWS Single Sign-On
* Set Alias to be 'nhs'
* Set Portal URL to be https://d-9c67018f89.awsapps.com/start#/
* Set AWS region to be eu-west-2
* Set Auth method to 'In-browser' (but you could try in-app)
* Click on 'Add integration'
  
Then try to use the integration:
* NHS should be on the sidebar
* Click on three dots
* Select login to AWS
* Authorization requested screen should come up
* Click confirm and continue
* You may need to sign into NHS and use MFA
* After you have signed in, all possible sessions should now be displayed in Leapp

Now try to test this inside sfrunner:
* Click the play button next to a profile (such as the mgmt one) 
* Enter sfrunner using `sfrunner --with-docker`
* Check your assumed role using `aws sts get-caller-identity`


## Usage

Before building the docker image, make sure you are running docker desktop.

To build the docker image, run the following command:

```bash
task build
```



### List existing tasks

```bash
task build
```

