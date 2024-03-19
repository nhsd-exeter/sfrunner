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
└── taskfile.yml                # tasks for building and running sfrunner, locally and used by github actions
└── taskfile-infra.yml          # for execution by Terraform to create ECR repo

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
                                        
It is preferred to install sfrunner from ECR, as it is quicker.  

In order to do this,

1. please find the ECR repository *host* that contains the sfrunner image, so that you can give it
as a parameter.  You would expect this to have the format:

`AWSACCOUNTID.dkr.ecr.eu-west-2.amazonaws.com`

2. please find the ECR repository *repository name* (excluding the host).  You would expect this to look
like:

`some-thing/sfrunner`
                                                          
3. assume to the correct aws account

Then:
```bash
task ecr-install ECR_HOST=AWSACCOUNTID.dkr.ecr.eu-west-2.amazonaws.com REPO_NAME=some-thing/sfrunner
echo 'export WITH_DOCKER=true #automatically run sfrunner with docker support' >> ~/.zshrc
```

Where `<ECR_REPO>` is the name of the ECR repository you want to install from.

However, you can install sfrunner directly, clone the repository and run the following commands from inside the 
`sfrunner` directory

```bash
task build PLATFORM=linux/arm64/v8 PLATFORM_SUMMARY=arm64 AWS_ACC=[AWSACCOUNTID] SFRUNNER_VER=[SFRUNNER_VER]
task install
echo 'export WITH_DOCKER=true #automatically run sfrunner with docker support' >> ~/.zshrc
```
Take care to substitute the AWS account ID for the mgmt account in place of `[AWSACCOUNTID]`.  

Subsitute a version number in the place of `[SFRUNNER_VER]` - this will be accessible inside
the container in the environment variable `SFRUNNER_VER`. 

The example above is assuming Apple Silicon, but substitute different values for `PLATFORM` and `PLATFORM_SUMMARY` as 
appropriate.

| Architecture  | PLATFORM       | PLATFORM_SUMMARY |
|---------------|----------------|------------------|
| Apple Silicon | linux/arm64/v8 | arm64            |
| x86           | linux/amd64    | amd64            |



## Usage

From then on, whenever you want to use sfrunner, you can just run `sfrunner` from the command line,
from the root of the service finder source directory, or any other project you are working on.

When sfrunner is run, it will connect to the docker daemon on your host machine in order to run
docker images.  The `WITH_DOCKER` environment variable is used to tell sfrunner to run with docker in
this way.

## Testing

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


