# sfrunner

This is a docker image that contains everything needed to build,
run, and test service finder.

## Why does this exist?

Service finder was previously run through a huge series
of makefiles.  This was both slow to run and difficult to
debug and maintain.  One approach of those makefiles was
to run every command inside a separate docker container.

This system takes the opposite approach of that, with one
docker container that contains every dependency, such that
all development and testing can be done inside the container.
          
## Structure of project

```
├── .github                     # github actions
│   └── workflows
│       ├── docker-build.yml
│       └── sts.yml
├── src                         # definition of sfrunner image
│ └── Dockerfile
├── infrastructure              # infrastructure
│ └── stacks                    # terraform roots
│    └── ecr                    # terraform root for creating ecr repo
└── taskfile.yml                # tasks for building and running sfrunner

```


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



## Installation

To install sfrunner, clone the repository and run the following commands from inside the `sfrunner` directory:

```bash
task build
task install
echo 'export WITH_DOCKER=true #automatically run sfrunner with docker support' >> ~/.zshrc
```
       
From then on, whenever you want to use sfrunner, you can just run `sfrunner` from the command line,
from the root of the service finder source directory, or any other project you are working on.

When sfrunner is run, it will connect to the docker daemon on your host machine in order to run
docker images.  The `WITH_DOCKER` environment variable is used to tell sfrunner to run with docker in
this way.

To test sfrunner, you can do the following: 
1. start a new shell so that WITH_DOCKER is set
2. Open Leapp, and click the play button next to the mgmt profile
3. Go into the service finder source directory, and run `sfrunner`
4. You should see the sfrunner prompt, and be able to run commands inside the container

Note: the prompt changes depending on whether sfrunner can see you have the correct role assumed:

```
 ✗ . [none] (HOST) service-finder ⨠     # it is showing X and no profile
 
 log on using leap, then press enter 
 
 √ . [default] (HOST) service-finder ⨠  # you now have a tick and the name of the profile
```

5. Run `aws sts get-caller-identity` to check that you are running as the assumed role


## Usage

Before building the docker image, make sure you are running docker desktop.

To build the docker image, run the following command:

```bash
task build
```
          
To then install sfrunner to your machine, so you can run `sfrunner` from the command line:

```bash
task install
```


### List existing tasks

```bash
task build
```

