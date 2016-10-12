### Docker Lambdas

This repository contains examples for a variety of ways that docker containers
can be used as lambda functions. The base docker_lambda intrface generally
demonstrates the kind of things that would be needed in a lambda implementation:

- the /var/run/docker.sock docker socket must be passed to the lambda container
  at runtime
- the lambda image must have docker installed, or a suitable docker client

In addition, it is suggested that the lambda specify the mode in which its lambda
passes its events to the docker image container, either as STDIN, or Arguments.

Finally, it may be useful for some lambda's to allow secrets and other important
configuration for the lambda docker container to be passed through the lambda
manager container.

Rest
---
This docker lambda demonstrates how a rest application can call out to a docker
lambda in response to a request to an endpoint.

Kakfa
---
This docker lambda demonstrates how a kafka consumer can respond to events in a
kafka topic queue, and pass the event body to a docker lambda.
