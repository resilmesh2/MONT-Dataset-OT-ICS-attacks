#!/bin/bash
# ----------------------------------------
# Setup script for NATS Python environment
# ----------------------------------------

# Exit on any error
set -e

echo "=== Step 1: Remove any existing natsenv ==="
rm -rf natsenv
echo "Removed old natsenv if it existed."

echo "=== Step 2: Create a new Python virtual environment ==="
python3.8 -m venv natsenv
echo "Created new virtual environment in natsenv/"

echo "=== Step 3: Activate the virtual environment ==="
# shellcheck disable=SC1091
source natsenv/bin/activate
echo "Virtual environment activated."

echo "=== Step 4: Upgrade pip and install dependencies ==="
pip install --upgrade pip
pip install nats-py asyncio
echo "Dependencies installed: nats-py, asyncio"

echo "=== Setup completed successfully ==="
echo "To activate the environment in the future, run:"
echo "source natsenv/bin/activate"

