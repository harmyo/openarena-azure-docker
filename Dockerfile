FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# "universe"-Repository sicherstellen (enthält openarena-server)
RUN apt-get update && apt-get install -y --no-install-recommends software-properties-common \
    && add-apt-repository -y universe \
    && apt-get update

# OpenArena Dedicated Server inkl. ioquake3-Engine und baseoa-Spieldaten
RUN apt-get install -y openarena-server \
    && apt-get purge -y software-properties-common \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.openarena/baseoa

EXPOSE 27960/udp

ENTRYPOINT ["/usr/games/openarena-server"]
CMD ["+set", "dedicated", "2", "+set", "net_port", "27960", "+exec", "server.cfg"]
