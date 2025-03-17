import sys
import asyncio
import json
import pandas as pd
from nats.aio.client import Client as NATS

# NATS Configuration
NATS_URL = "nats://localhost:4222"
PUBLISH_SUBJECT = "ai4triage.logs"

async def send_to_nats(csv_file):
    """Reads a CSV file and sends each row as a JSON message to NATS."""
    try:
        df = pd.read_csv(csv_file)  # here we  Load the CSV
    except Exception as e:
        print(f" Error reading CSV file: {e}")
        return

    if df.empty:
        print("CSV file is empty, no data to send!")
        return

    data = df.to_dict(orient="records")  # Convert CSV rows to JSON format

    nc = NATS()
    try:
        await nc.connect(NATS_URL)
        for entry in data:
            await nc.publish(PUBLISH_SUBJECT, json.dumps(entry).encode())

        await nc.flush()
        print(f"{len(data)} messages sent to NATS on '{PUBLISH_SUBJECT}'")
    except Exception as e:
        print(f" Error sending data to NATS: {e}")
    finally:
        await nc.close()

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(" Usage: python3 nats_publisher.py <csv_file>")
        sys.exit(1)

    csv_file = sys.argv[1]  # Get CSV file from command line
    asyncio.run(send_to_nats(csv_file))

