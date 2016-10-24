# Docker-lambda that uses a Kafka Queue

This lambda uses a [Lita Chatbot](https://docs.lita.io) connected to
a (slack)[slack.com] team. It takes message asked of the chat bot in the form
`@bot_name command args`, uses command to run a container of an image named
for the command, and passes everything in the string after command (args)
as a string joined with ' ' to the STDIN of the container.

You must [create a bot](https://github.com/litaio/lita-slack) in your slack
team for this lita bot to use. Once you create this, you can get the slack token,
and set it as an environment variable SLACK_TOKEN in a file called lita.secret.env,
rm and create a soft link from lita.env to lita.secret.env:
```bash
echo 'SLACK_TOKEN=fff0000xxxx' > lita.secret.env
rm lita.env
ln -s lita.secret.env
```
this file is set to be ignored by git in the .gitignore file.

Run Lita Lambda
---
Build one or both of the rest/cat or kafka/dockter images for lita to
use:
```bash
cd ../kafka
docker build -t dockter dockter
cd ../rest
docker build -t cat cat
cd ../lita
```

Build the base docker_lambda image
```bash
cd ..
docker-compose build
cd lita
```

Ensure you have created the bot and put the token in your lita.env, then
launch lita (this may pull down images the first time if they are not in your repo):
```bash
docker-compose up -d
```

You can watch the logs with
```bash
docker-compose logs -f lita
```

in your slack team, switch to a channel, and type commands to your bot (change
@bot_name to whatever you configured your bot to use in the team):
```
@bot_name cat FOO BAR BAZ
@bot_name dockter I want a puppy
@bot_name notanimage foo bar baz
```
It will return an error when the image does not exist, otherwise it will run
the container with your message, and return the response.

Principles
---
This lambda is much like the rest lambda, but uses a lita_bot instead. The biggest
value from this is that you do not need to write and update a special lita handler
to handle new commands. Simply create a docker image with the ability to take
commands as STDIN, and return a response.
