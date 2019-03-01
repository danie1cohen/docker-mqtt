#_______________________________________________________________
# _______________________________________________________________
#  _______________________/\\\\\\\\_______/\\\__________/\\\______
#   ____/\\\\\__/\\\\\____/\\\////\\\___/\\\\\\\\\\\__/\\\\\\\\\\\_
#    __/\\\///\\\\\///\\\_\//\\\\\\\\\__\////\\\////__\////\\\////__
#     _\/\\\_\//\\\__\/\\\__\///////\\\_____\/\\\_________\/\\\______
#      _\/\\\__\/\\\__\/\\\________\/\\\_____\/\\\_/\\_____\/\\\_/\\__
#       _\/\\\__\/\\\__\/\\\________\/\\\\____\//\\\\\______\//\\\\\___
#        _\///___\///___\///_________\////______\/////________\/////____

FROM resin/rpi-raspbian:latest

EXPOSE 1883 8883

RUN mkdir -p /mqtt /opt/mosquitto /ssl
WORKDIR /mqtt

RUN apt-get update && apt-get install -y \
  curl \
  net-tools \
  sed \
  apt-transport-http

RUN curl http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key \
  -o /tmp/mosquitto-repo.gpg.key

RUN apt-key add /tmp/mosquitto-repo.gpg.key && \
  rm /tmp/mosquitto-repo.gpg.key

RUN curl http://repo.mosquitto.org/debian/mosquitto-jessie.list \
  -o /etc/apt/sources.list.d/mosquitto-jessie.list

RUN apt-get update && apt-get install -y \
  mosquitto \
  mosquitto-clients

COPY . .

ENTRYPOINT ["bash", "/mqtt/entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mqtt/mosquitto.conf"]
