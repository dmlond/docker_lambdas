# Docker-lambda that uses a Kafka Queue

This lambda uses a [Kafka](http://kafka.apache.org/documentation.html) queue as a
way of responding to an event with the instantiation of a docker image container.

It models the framework of a doctor-patient interaction.

The lambda defined in the docker-compose.yml runs a ruby client that listens to
a 'patient' kafka topic, receives messages from patients, calls out to the dockter
docker image, and returns the response to the user as an event in the 'dockter'
queue.

The patient defined in the docker-compose.yml runs a ruby client which prompts
the patient to describe their problem, sends the patient response to the 'patient'
queue, and then listens on the 'dockter' queue for responses from the doctor.

With each response from the doctor, the patient application
- prompts the user with each doctor response,
- gathers the patients new response
- reports the new response to the dockter queue

Run the simulation
---

Note, unfortunately there are issues in the way that docker-compose links the lambda
and the patient to the kafka and zookeeper containers that break it, so we have
to run them using docker run instead of docker-compose run.

1. Set up kafka and zookeeper, then initialize the dockter and patient topics
```bash
$ docker-compose up -d kafka
$ docker-compose run kafka initialize.sh
```
2. Build the lambda and patient images
```bash
docker-compose build lambda patient
```
3. Launch the lambda (the dockter listener)
```bash
docker run -d --link kafka_kafka_1:kafka --link zookeeper:zookeeper -v /var/run/docker.sock:/var/run/docker.sock docker_lambda_kafka
```bash
3. Launch the patient
```bash
docker run -ti --rm --link kafka_kafka_1:kafka --link zookeeper:zookeeper docker_lambda_patient
```

Principles
---
This lambda demonstrates how a kafka consumer can be connected to a dockerized
lambda.  The basic idea is that a kafka consumer listens for messages in a topic,
and passes the body of each message to the dockerized lambda. This one passes the
body to STDIN, but it could also pass it as arguments, or even environment variables.
The lambda may or may not need to publish a message to a kafka queue. It might even
delegate this to the underlying docker lambda process.
