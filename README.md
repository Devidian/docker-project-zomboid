# Docker Container for Project Zomboid Dedicated Server

Another docker solution for a `Project Zomboid` dedicated server. If you need help, have suggestions or issues please visit github.

# Intentions

I was running into errors because of a misconfigured java parameter in the default game, which is not fixed in other docker solutions, so i tried to get my own docker image running.

# Plans

Currently i'm very new to the game (december 2021), but it makes fun. I had an idea to include (optional) an web interface to config the server, but im not sure yet if i can afford time to do so.

# How to run it

Best way is to use a composer file like this:

```yml
version: "3.8"

services:
  project-zomboid-ds-docker:
    # build: .
    image: devidian/project-zomboid-ds:latest
    container_name: project-zomboid-ds-docker
    restart: unless-stopped
    volumes:
      # left side: your docker-host machine
      # right side: the paths in the image (!!do not change!!)
      - /appdata/project-zomboid/dedicated:/home/steam/project-zomboid-dedicated
      - /appdata/project-zomboid/data:/home/steam/Zomboid
      # Use this to override the default docker configuration
      # - ./Server:/home/steam/Server
    ports:
      - "8766:8766/udp"
      - "8767:8767/udp"
      - "16261:16261/udp"
      - "27015:27015/tcp"
      - "16262-16272:16262-16272/tcp"
    environment:
      - SERVER_NAME=ZomboidDocker
      - ADMIN_PASSWORD=ZomboidDockerAdmin22
      - STEAM_PORT_A=8766
      - STEAM_PORT_B=8767
      # change this to change the amount of GB for jre, default 8
      - CONFIG_XMX=8
```

and run `docker-compose up -d`.

# How to configurate

To start of, visit github. You can download the `Server` directory which contains the default configuration. Drop it into your `docker-compose.yml` directory and alter the file contents. Do not rename them!
The startup file will copy and rename the config from the source config directoy on each restart. Don't forget to uncomment the volume line in your compose file!