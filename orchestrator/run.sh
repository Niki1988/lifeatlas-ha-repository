#!/usr/bin/with-contenv bashio

# Log the start of the script
bashio::log.info "Starting LifeAtlas Orchestrator..."

# Get configuration from add-on options
DATABASE_URL=$(bashio::config 'database_url')
GOOGLE_API_KEY=$(bashio::config 'google_api_key')
GOOGLE_DRIVE_CREDENTIALS=$(bashio::config 'google_drive_credentials')

# Export variables for the application to use
export DATABASE_URL
export GOOGLE_API_KEY
export GOOGLE_DRIVE_CREDENTIALS

# Log which database is being used
bashio::log.info "Using database: ${DATABASE_URL}"

# Start the Uvicorn server using pdm
# We bind to port 8000 as defined in config.json
# We bind to host 0.0.0.0 to make it accessible from outside the container
exec pdm run uvicorn app.main:app --host 0.0.0.0 --port 8000
