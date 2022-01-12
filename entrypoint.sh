#!/bin/bash
# VARIABLES
export LD_LIBRARY_PATH=${STEAMAPPDIR}/jre64:$LD_LIBRARY_PATH
CONFIG_PATH=${STEAMAPPDIR}/ProjectZomboid64.json


echo "COPY configuration from <${HOMEDIR}/Server/ZomboidDocker*> to </home/steam/Zomboid/Server/${SERVER_NAME}*>"
test -d /home/steam/Zomboid/Server || mkdir -p /home/steam/Zomboid/Server

cp ${HOMEDIR}/Server/ZomboidDocker.ini /home/steam/Zomboid/Server/${SERVER_NAME}.ini
cp ${HOMEDIR}/Server/ZomboidDocker_SandboxVars.lua /home/steam/Zomboid/Server/${SERVER_NAME}_SandboxVars.lua
cp ${HOMEDIR}/Server/ZomboidDocker_spawnpoints.lua /home/steam/Zomboid/Server/${SERVER_NAME}_spawnpoints.lua
cp ${HOMEDIR}/Server/ZomboidDocker_spawnregions.lua /home/steam/Zomboid/Server/${SERVER_NAME}_spawnregions.lua


# Steamcmd install
echo "APP <ID:${STEAMAPPID}> Install directory will be ${STEAMAPPDIR}"
${STEAMCMDDIR}/steamcmd.sh +force_install_dir ${STEAMAPPDIR} +login anonymous +app_update ${STEAMAPPID} validate +quit

# Update config (will reset on each steamcmd update)
sed -i "s=Xmx8g=Xmx${CONFIG_XMX}g=g" ${CONFIG_PATH}
sed -i "s=UseZGC=UseG1GC=g" ${CONFIG_PATH}

${STEAMAPPDIR}/start-server.sh -servername ${SERVER_NAME} -adminpassword ${ADMIN_PASSWORD} -steamport1 ${STEAM_PORT_A} -steamport2 ${STEAM_PORT_B}