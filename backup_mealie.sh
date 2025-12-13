#!/bin/bash

set -euo pipefail

# Setup logging
log() {
  local message="$1"
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] $message" >> "$log_file"
}

if [[ $# -ne 1 ]]; then
  echo "ERROR: Parameter missing!" >&2
  echo "Usage: $0 <log_file_path>" >&2
  exit 1
fi

log_file="$1"
if [[ ! -f "$log_file" ]]; then
  touch "$log_file" || { echo "ERROR: Could not create $log_file"; exit 1; }
  echo "Created log file: $log_file"
fi

# Check if .env exists
script_dir="$(dirname "$0")"
env_file="$script_dir/.env"

echo "$script_dir"
if [[ ! -f "$env_file" ]]; then
  log "ERROR: .env file missing!" >&2
  exit 1
fi

# Load .env variables
set -a
source "$env_file"
set +a # disable export

# Validate environment
if [[ -z "${MEALIE_DOMAIN:-}" || -z "${MEALIE_API_TOKEN:-}" ]]; then
  log "ERROR: MEALIE_DOMAIN or MEALIE_API_TOKEN is not set"
  exit 1
fi

log "Starting Mealie backup..."

# Use Mealie API to backup
response=$(curl -X POST \
  -sS \
  -w "%{http_code}" \
  "https://$MEALIE_DOMAIN/api/admin/backups" \
  -H "accept: application/json" \
  -H "Authorization: Bearer $MEALIE_API_TOKEN" \
  -d "")

# Check HTTP status code
http_code="${response: -3}"

if [ "$http_code" -eq 201 ]; then
  log "Backup completed successfully!"
  exit 0
else
  log "Backup failed!"
  exit 1
fi
