# Mosquitto Server

> A raspberry pi friendly containerized mosquitto server

[![Build Status](https://travis-ci.org/danie1cohen/docker-mqtt.svg?branch=master)](https://travis-ci.org/danie1cohen/docker-mqtt)


## Transport Layer Security
You may mount SSL certificates to /ssl. They must be named ca.crt, mqtt-server.crt, mqtt-server.key.

Otherwise, a set of certificates will be generated automatically

You may specify a space-separated list of hostnames for automatically
generated certificates with the environment variable MQTT_HOSTLIST, and
likewise for IPs with MQTT_IPLIST


## Authentication
You may specify a username and password using environment variables
$MQTT_USER and $MQTT_PWD. If not values are supplied, root user and a
random password will be generated.

Alternatively, you may mount a custom password file as a volume at
/opt/mosquitto with the filename passwd

This container also comes with a useful tool (provided by
Owntracks) to generate TLS certificates.
To generate a user certificate, you may RUN

    docker run --rm mqtt -it bash /mqtt/generate_user_key.sh username


## Configuration
You may also ignore the default configuration and substitute your own config file by mounting a file to /mqtt/mosquitto.conf.
