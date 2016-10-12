# Docker-lambda that uses a REST Web Application

This lambda uses a [Sinatra](http://www.sinatrarb.com/) REST web application as a
way of responding to web requests with the instantiation of a docker image container.

The lambda defined in the docker-compose.yml runs a sinatra web application that
responds to three endpoints.

/echo
When a client posts a body, the server passes the body as arguments to the
docker 'echo' image, which passes the arguments to echo. The response is
echo'd back to the client.

/cat
When a client posts a body, the server passes the body in the STDIN of the
docker 'cat' image, which is passed to cat. The response is
echo'd back to the client.

/version
When a client gets this endpoint, information about the version of docker installed
on the host is returned to the caller.

Run the simulation
---
```bash
$ docker build -t echo echo
$ docker build -t cat cat
$ docker-compose build
$ docker-compose up -d
$ curl http://localhost:3000/version
$ curl -X POST -d 'THIS IS FOR ECHO' http://localhost:3000/echo
$ curl -X POST -d 'THIS IS FOR CAT' http://localhost:3000/cat

Principles
---
This lambda demonstrates how one or more web applications could be used to
instantiate dockerized lambda containers.  The basic idea is that a webserver
listens for an endpoint, and passes relevant information (url parameters,
posted body, request headers) off to a docker container for processing. The
rest endpoint can 'fire and forget', e.g. not worry about the response, or it
can return the response to the caller in the response body.
