# Docker Container for Project Zomboid Dedicated Server



# How to run it

Best way is to use a composer file like this:

```yml
version: '3.8'

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
      - ./Server:/home/steam/Server
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
```

and run `docker-compose up -d`.