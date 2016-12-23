# Dockerized Runestone Server

This repository contains a dockerfile that produces a container
to build and then run the Runestone Server.

## Deploying Runestone Server

The primary benefit of running the Runestone Interactive bulid system
within docker is deploying a Runestone server with less complexity and
not screwing up or adding to your local python setup (virtualenv not withstanding).

Eventually, this container is intended to be paired with the **runestone-build** system
which can be used to "compile" a book.

A single container, **runestone-server**, is used to produced by
running `make build`. Once the container is built, you can
deploy a sample runestone-server either using **postgres** or **sqlite3**.

### Using SQLite3

When using SQLite, you need to create a data directory to hold the SQLite
files and pass that directory into the container as the **/run** directory.
The files in `./datadir` will be owned by a user other than you if you
invoke the container directly. Instead, it's recommended you use the
`runestone-server` script, which passes arguments to the the container
to create a user with your UID and then run the container as that user.

The following steps show how to do this:

    % mkdir datadir  
    % docker pull dirkcgrunwald/runestone-build
    % docker run --rm dirkcgrunwald/runestone-build > runestone-server
    % sh runestone-server datadir

The first time you run the **runestone-server** container with no arguments,
it will emit a shell script that you should then use to deploy your
server. The shell script will determine your current user id and
insure that the files in your data directory are owned by you.

### Deploying using postgres

This part is still in progress. There's a sample **Docker-compose.yml**
file that launches a postgres container & a dockerfile.

The steps that are missing right now are automatically initializing
the database if it doesn't exist

## Running the server

The server lunaches on port 8000 on your local machine. If you want to change the port,
edit the ./runestone-build script in the obvious place.

When you're done running the server, just hit Ctrl-c to kill the
container.
