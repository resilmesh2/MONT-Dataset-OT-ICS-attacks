#!/bin/bash
# ----------------------------------------
# Robust publisher.sh for NATS
# ----------------------------------------

# Resolve the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load NATS config
source "$SCRIPT_DIR/nats_config.conf"

# Check CSV argument
if [ -z "$1" ]; then
    echo "Usage: $0 <csv_file_or_url> [subject]"
    exit 1
fi

CSV_FILE="$1"
SUBJECT="${2:-$NATS_SUBJECT}"  # default to NATS_SUBJECT if not provided

# Activate virtual environment
source "$SCRIPT_DIR/natsenv/bin/activate"

# Run publisher
python3 "$SCRIPT_DIR/nats_publish_csv.py" \
  --url "$NATS_URL" \
  --user "$NATS_USER_INGESTOR" \
  --password "$NATS_PASS_INGESTOR" \
  --subject "$SUBJECT" \
  --csv "$CSV_FILE"

