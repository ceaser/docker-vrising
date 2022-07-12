FROM fragsoc/steamcmd-wine-xvfb

ARG VRISING_HOME
ENV VRISING_HOME ${VRISING_HOME:-"/opt/vrising"}

ARG VRISING_BRANCH
ENV VRISING_BRANCH ${VRISING_BRANCH}
ARG VRISING_BRANCH_PASSWORD
ENV VRISING_BRANCH_PASSWORD ${VRISING_BRANCH_PASSWORD}

ARG STEAM_USER
ENV STEAM_USER ${STEAM_USER:-"steam"}
ARG STEAM_HOME
ENV STEAM_HOME ${STEAM_HOME:-"/opt/steam"}

RUN DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install --no-install-recommends -y iproute2 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV GAME_Name "My V Rising Server"
ENV GAME_Description "My V Rising Server"
ENV GAME_Port "27015"
ENV GAME_QueryPort "27016"
ENV GAME_MaxConnectedUsers "10"
ENV GAME_MaxConnectedAdmins "4"
ENV GAME_SaveName "world1"
ENV GAME_Password ""
ENV GAME_ListOnMasterServer "true"
ENV GAME_AutoSaveCount "40"
ENV GAME_AutoSaveInterval "120"
ENV GAME_GameSettingsPreset ""
ENV GAME_ServerFps "30"
ENV GAME_Secure "true"
ENV GAME_AdminOnlyDebugEvents "true"
ENV GAME_DisableDebugEvents "false"

ADD docker-entrypoint.sh /
ADD adminlist.txt /usr/share/vrising/Settings/
ADD banlist.txt /usr/share/vrising/Settings/
ADD ServerHostSettings.json /usr/share/vrising/Settings/

RUN set -x \
  && mkdir -p $VRISING_HOME /data /usr/share/vrising/Settings

HEALTHCHECK --interval=1m --timeout=30s --retries=3 CMD bash -c "ss -ulpn | grep -q [2]7015"
EXPOSE 27015-27016/udp
VOLUME [ "/data", "/opt/vrising" ]
WORKDIR $VRISING_HOME
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "run" ]
