# docker entrypoint script

DEFAULT_USER=mosquitto
DEFAULT_PWD=$(head /dev/urandom | base64 | cut -c1-20 | head -n1)


adduser mosquitto

export MOSQUITTOUSER=${MQTT_USER:-$DEFAULT_USER}
PWD=${MQTT_PWD:-$DEFAULT_PWD}

if [ ! -f /opt/mosquitto/passwd ]; then
    echo "No mqtt user database found. Creating a new one."
    touch /opt/mosquitto/passwd
    mosquitto_passwd -b /opt/mosquitto/passwd $MOSQUITTOUSER $PWD
fi

if [ ! -f /ssl/mqtt-ca.crt ]; then
    echo "Generating TLS certificates..."
    HOSTLIST=$MQTT_HOSTLIST
    IPLIST=$MQTT_IPLIST
    cd /ssl && bash /mqtt/generate-CA.sh mqtt-server
fi

chown -R mosquitto /opt/mosquitto/ /mqtt/

exec "$@"
