#!/usr/bin/env bash

docker run -it -d -e GAME_Name=MyGame -e GAME_Description='Example Server' -p '27015:27015/udp' -p '27016:27016/udp' -v `pwd`/data:'/data' --name vrising registry.home.divergentlogic.com/vrising:latest
