FROM cm2network/steamcmd:root

ENV CONFIG_XMX 16
ENV SERVER_NAME ZomboidDocker
ENV ADMIN_PASSWORD ZomboidDockerAdmin
ENV STEAM_PORT_A 8766
ENV STEAM_PORT_B 8767

ENV STEAMAPPID 380870
ENV STEAMAPP project-zomboid
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

# ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && \
    mkdir -p /usr/share/man/man1 && \
    apt install -y \
        libsdl2-2.0-0:i386 \
        default-jre 

COPY entrypoint.sh ${HOMEDIR}/entrypoint.sh
COPY Server ${HOMEDIR}/Server
RUN chmod +x "${HOMEDIR}/entrypoint.sh" && chown -R "${USER}:${USER}" "${HOMEDIR}"

USER ${USER}
WORKDIR ${HOMEDIR}
VOLUME ${STEAMAPPDIR}

CMD ["bash", "entrypoint.sh"]

EXPOSE 16216/tcp 27020/tcp 27036/tcp 27020/udp 4380/udp 27036/udp