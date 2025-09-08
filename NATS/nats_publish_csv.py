#!/usr/bin/env python3
import argparse, asyncio, csv, json, io, urllib.request
import nats

async def main():
    p = argparse.ArgumentParser()
    p.add_argument("--url", default="nats://127.0.0.1:4222", help="NATS server URL")
    p.add_argument("--user", help="Username")
    p.add_argument("--password", help="Password")
    p.add_argument("--subject", required=True, help="Subject to publish to")
    p.add_argument("--csv", required=True, help="Path or HTTP(S) URL of CSV file")
    args = p.parse_args()

    nc = await nats.connect(servers=[args.url], user=args.user, password=args.password)

    # load CSV (support local file or http URL)
    if args.csv.startswith("http"):
        with urllib.request.urlopen(args.csv) as resp:
            content = resp.read().decode("utf-8")
        rows = csv.DictReader(io.StringIO(content))
    else:
        rows = csv.DictReader(open(args.csv, newline="", encoding="utf-8"))

    count = 0
    for row in rows:
        await nc.publish(args.subject, json.dumps(row).encode())
        count += 1
    await nc.flush()
    await nc.close()
    print(f"✅ Sent {count} rows to {args.subject}")

if __name__ == "__main__":
    asyncio.run(main())

