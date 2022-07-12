#!/usr/bin/env bash

set -ex

function install()
{
  mkdir -p $VRISING_HOME
  steamcmd \
    +@ShutdownOnFailedCommand 1 \
    +force_install_dir $VRISING_HOME \
    +login anonymous \
    +app_update 1829350 \
    $([ -n "$VRISING_BRANCH" ] && printf %s "-beta $VRISING_BRANCH") \
    $([ -n "$VRISING_BRANCH_PASSWORD" ] && printf %s "-betapassword $VRISING_BRANCH_PASSWORD") \
    validate \
    +quit  \
    && rm -rf $HOME/.steam/logs $HOME/.steam/appcache/httpcache \
    && find $HOME/.steam/steamcmd/package -type f ! -name "steam_cmd_linux.installed" ! -name "steam_cmd_linux.manifest" -delete
}

function copy-config()
{
  local shareddir="/usr/share/vrising/"
  local datadir="/data/save-data/"
  if [ ! -d "$datadir/Settings" ]; then
    mkdir -p "$datadir/Settings"
  fi
  cp "$shareddir/Settings/ServerHostSettings.json" "$datadir/Settings/ServerHostSettings.json"
  if [ ! -f "$datadir/Settings/adminlist.txt" ]; then
    cp "$shareddir/Settings/adminlist.txt" "$datadir/Settings/adminlist.txt"
  fi
  if [ ! -f "$datadir/Settings/banlist.txt" ]; then
    cp "$shareddir/Settings/banlist.txt" "$datadir/Settings/banlist.txt"
  fi
  sed -i "s/GAME_Name/$GAME_Name/" $datadir/Settings/ServerHostSettings.json
  sed -i "s/GAME_Description/$GAME_Description/" $datadir/Settings/ServerHostSettings.json
  sed -i "s/GAME_Port/$GAME_Port/" $datadir/Settings/ServerHostSettings.json
  sed -i "s/GAME_QueryPort/$GAME_QueryPort/" $datadir/Settings/ServerHostSettings.json
  sed -i "s/GAME_MaxConnectedUsers/$GAME_MaxConnectedUsers/" $datadir/Settings/ServerHostSettings.json
  sed -i "s/GAME_MaxConnectedAdmins/$GAME_MaxConnectedAdmins/" $datadir/Settings/ServerHostSettings.json
  sed -i "s/GAME_SaveName/$GAME_SaveName/" $datadir/Settings/ServerHostSettings.json
  sed -i "s/GAME_Password/$GAME_Password/" $datadir/Settings/ServerHostSettings.json
  sed -i "s/GAME_ListOnMasterServer/$GAME_ListOnMasterServer/" $datadir/Settings/ServerHostSettings.json
  sed -i "s/GAME_AutoSaveCount/$GAME_AutoSaveCount/" $datadir/Settings/ServerHostSettings.json
  sed -i "s/GAME_AutoSaveInterval/$GAME_AutoSaveInterval/" $datadir/Settings/ServerHostSettings.json
  if [ -z "$GAME_GameSettingsPreset" ]; then
    sed -i "s/GAME_GameSettingsPreset//" $datadir/Settings/ServerHostSettings.json
  else
    sed -i "s/GAME_GameSettingsPreset/$GAME_GameSettingsPreset/" $datadir/Settings/ServerHostSettings.json
  fi
  sed -i "s/GAME_ServerFps/$GAME_ServerFps/" $datadir/Settings/ServerHostSettings.json
  sed -i "s/GAME_Secure/$GAME_Secure/" $datadir/Settings/ServerHostSettings.json
  sed -i "s/GAME_AdminOnlyDebugEvents/$GAME_AdminOnlyDebugEvents/" $datadir/Settings/ServerHostSettings.json
  sed -i "s/GAME_DisableDebugEvents/$GAME_DisableDebugEvents/" $datadir/Settings/ServerHostSettings.json
}

if [ "$1" = 'validate' ]; then
  install
  exit 0
fi

if [ "$1" = 'copy' ]; then
  copy-config
  exit 0
fi

if [ "$1" = 'run' ]; then
  if [ ! -f "$VRISING_HOME/VRisingServer.exe" ]
  then
    install
  fi
  copy-config
  rm -rf /tmp/.X0-lock
  cd /opt/vrising
  Xvfb :0 -screen 0 1024x768x16 & \
    DISPLAY=:0.0 SteamAppId=1604030 wine VRisingServer.exe -persistentDataPath z:\\data\\save-data
fi

exec "$@"
