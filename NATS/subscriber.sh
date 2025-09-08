#!/bin/bash
# ----------------------------------------
# Robust subscriber.sh for NATS
# ----------------------------------------

# Resolve the script directory (works regardless of where you call it)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load NATS config
source "$SCRIPT_DIR/nats_config.conf"

# Activate virtual environment
source "$SCRIPT_DIR/natsenv/bin/activate"

# Run subscriber
python3 "$SCRIPT_DIR/nats_subscribe_print.py" \
  --url "$NATS_URL" \
  --user "$NATS_USER_VIEWER" \
  --password "$NATS_PASS_VIEWER" \
  --subject "$NATS_SUBJECT"

