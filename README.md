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

- [Docker](https://www.docker.com/) to build and run the docker image
- [Taskfile](https://taskfile.dev/#/installation) to run the tasks

## Usage

### List existing tasks

```bash
task build
```

