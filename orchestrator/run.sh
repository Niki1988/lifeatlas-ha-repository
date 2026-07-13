#!/usr/bin/with-contenv bashio

# Log the start of the script
bashio::log.info "Starting LifeAtlas Orchestrator..."

# Get the database URL from the add-on options
# The default value is set in config.json
DATABASE_URL=$(bashio::config 'database_url')
export DATABASE_URL

# Log which database is being used
bashio::log.info "Using database: ${DATABASE_URL}"

# Start the Uvicorn server
# We bind to port 8000 as defined in config.json
# We bind to host 0.0.0.0 to make it accessible from outside the container
exec uvicorn app.main:app --host 0.0.0.0 --port 8000
