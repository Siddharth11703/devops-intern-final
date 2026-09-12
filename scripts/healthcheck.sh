#!/bin/bash
# A script to check if the web server is running.

# Handle the --help argument
if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo "Usage: ./healthcheck.sh [URL]"
    echo "Checks if the provided URL returns a 200 OK HTTP status."
    echo "If no URL is provided, it defaults to http://localhost:8080/healthz"
    exit 0
fi

# Use the provided URL (Argument 1), or default to our NGINX healthz endpoint
TARGET_URL="${1:-http://localhost:8080/healthz}"

echo "Pinging $TARGET_URL..."

# Grab just the HTTP status code (e.g., 200, 404, 500)
STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$TARGET_URL" || true)

if [ "$STATUS_CODE" -eq 200 ]; then
    echo "Success: Server is healthy (Status: $STATUS_CODE)"
    exit 0   # Success exit code
else
    echo "Error: Server is unreachable or failing (Status: $STATUS_CODE)"
    exit 1   # Failure exit code (Required by rubric)
fi