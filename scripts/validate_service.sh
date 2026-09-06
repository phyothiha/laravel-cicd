#!/usr/bin/env bash

set -euo pipefail

HEALTH_URL="http://127.0.0.1:80/health"
MAX_ATTEMPTS=10
RETRY_DELAY=3

for ((attempt = 1; attempt <= MAX_ATTEMPTS; attempt++)); do
    echo "Health check attempt $attempt/$MAX_ATTEMPTS: $HEALTH_URL"

    if response="$(curl --fail --silent --show-error --max-time 5 "$HEALTH_URL")"; then
        if [[ "$response" == "ok" ]]; then
            echo "Laravel health check passed."
            exit 0
        fi

        echo "Health endpoint returned an unexpected response: $response"
    fi

    if ((attempt < MAX_ATTEMPTS)); then
        sleep "$RETRY_DELAY"
    fi
done

echo "ERROR: Laravel health check failed after $MAX_ATTEMPTS attempts."
exit 1
