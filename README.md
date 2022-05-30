# docker-7d2d
Linux Dedicated Server for the V Rising using Docker

## Features
- [x] **ServerHostSettings.json **ENV** variables.
- [x] **World-persistence** on container destruction.
- [ ] Mods and custom **mod-configuration**.
- [ ] Automatic update of game files.
- [ ] Automatic update of mod files.

## Examples

Here is an example of a docker run line that exposes all ports and mounts the data directory to persist world and configuration files.

```SHELL
docker run -it -d -e GAME_Name=MyGame -e GAME_Description='Example Server' -p '27015:27015/udp' -p '27016:27016/udp' -v `pwd`/data:'/data' --name vrising registry.home.divergentlogic.com/vrising:latest
```
