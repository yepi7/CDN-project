#!/bin/sh

# Actualizar certificados de CA
update-ca-certificates

# Ejecutar Caddy
exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
