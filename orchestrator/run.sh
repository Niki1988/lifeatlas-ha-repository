#!/usr/bin/with-contenv bashio

# Log the start of the script
bashio::log.info "Starting LifeAtlas Orchestrator..."

# Get configuration from add-on options (use || true for optional fields)
DATABASE_URL=$(bashio::config 'database_url')
GOOGLE_API_KEY=$(bashio::config 'google_api_key' || true)
GOOGLE_DRIVE_CREDENTIALS=$(bashio::config 'google_drive_credentials' || true)

# Export variables for the application to use (only if not empty)
export DATABASE_URL
if [ -n "$GOOGLE_API_KEY" ] && [ "$GOOGLE_API_KEY" != "null" ]; then
    export GOOGLE_API_KEY
fi
if [ -n "$GOOGLE_DRIVE_CREDENTIALS" ] && [ "$GOOGLE_DRIVE_CREDENTIALS" != "null" ]; then
    export GOOGLE_DRIVE_CREDENTIALS
fi

# Log which database is being used
bashio::log.info "Using database: ${DATABASE_URL}"

# Start the Uvicorn server directly from the virtual environment
# We bind to port 8000 as defined in config.json
# We bind to host 0.0.0.0 to make it accessible from outside the container
exec /usr/src/app/.venv/bin/uvicorn app.main:app --host 0.0.0.0 --port 8000
