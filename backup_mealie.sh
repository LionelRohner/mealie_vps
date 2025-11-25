#!/bin/bash

# Enable automatic export of all variables
set -a

# Source the .env file
source .env

# Disable automatic export
set +a

# Use Mealie API to backup
curl -X "POST" \
  "https://$MEALIE_DOMAIN/api/admin/backups" \
  -H "accept: application/json" \
  -H "Authorization: Bearer $MEALIE_API_TOKEN" \
  -d ""
