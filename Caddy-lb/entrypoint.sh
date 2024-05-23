#!/bin/bash

keepalived -n -D -f /etc/keepalived/keepalived.conf &

# Ejecuta el comando original
exec "$@"