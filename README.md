# docker-vrising
Linux Dedicated Server for the V Rising using Docker

## Features
- [x] **ServerHostSettings.json** **ENV** variables.
- [x] **World-persistence** on container destruction.
- [ ] Mods and custom **mod-configuration**.
- [ ] Automatic update of game files.
- [ ] Automatic update of mod files.

## Examples

Here is an example of a docker run line that exposes all ports and mounts the data directory to persist world and configuration files.

```SHELL
docker run -it -d -e GAME_Name=MyGame -e GAME_Description='Example Server' -p '27015:27015/udp' -p '27016:27016/udp' -v `pwd`/data:'/data' --name vrising ceaser/vrising:latest
```

docker-compose

```YAML
version: "2"
services:
  7d2d:
    image: ceaser/vrising:latest
    container_name: vrising
    hostname: vrising
    tty: true
    stdin_open: true
    restart: unless-stopped
    environment:
      - GAME_Name=My V Rising Server
      - GAME_Description=My V Rising Server
      - GAME_Port=27015
      - GAME_QueryPort=27016
      - GAME_MaxConnectedUsers=10
      - GAME_MaxConnectedAdmins=4
      - GAME_SaveName=world1
      - GAME_Password=
      - GAME_ListOnMasterServer=true
      - GAME_AutoSaveCount=40
      - GAME_AutoSaveInterval=120
      - GAME_GameSettingsPreset=StandardPvP
      - GAME_ServerFps=30
      - GAME_Secure=true
      - GAME_AdminOnlyDebugEvents=true
      - GAME_DisableDebugEvents=false
    ports:
      - "27016:27016/udp"
      - "27015:27015/udp"
    volumes:
      - ./data:/data
      - ./app:/opt/vrising
    logging:
      options:
        max-size: "100k"
        max-file: "2"
```

## Environment Variables

| Variable | Default | Description |
| - | - | - |
| GAME_Name | "My V Rising Server" | Name of server |
| GAME_Description | "My V Rising Server" | Short description of server purpose, rules, message of the day |
| GAME_Port | 27015 | UDP port for game traffic |
| GAME_QueryPort | 27016 | UDP port for Steam server list features |
| GAME_MaxConnectedUsers | 10 | Max number of concurrent players on server |
| GAME_MaxConnectedAdmins | 4 | Max number of admins to allow connect even when server is full |
| GAME_SaveName | world1 | Name of save file/directory |
| GAME_Password |  | Set a password or leave empty |
| GAME_ListOnMasterServer | true | Set to true to list on server list, else set to false |
| GAME_AutoSaveCount | 40 | Number of autosaves to keep |
| GAME_AutoSaveInterval | 120 | Interval in seconds between each auto save |
| GAME_GameSettingsPreset | StandardPvP | Name of a GameSettings preset found in the GameSettingPresets folder |
| VRISING_BRANCH | | Use a specific beta version |
| VRISING_BRANCH_PASSWORD | | Password to access beta version |
