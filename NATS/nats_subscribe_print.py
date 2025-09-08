#!/usr/bin/env python3
import argparse, asyncio
import nats

async def main():
    p = argparse.ArgumentParser()
    p.add_argument("--url", default="nats://127.0.0.1:4222", help="NATS server URL")
    p.add_argument("--user", help="Username")
    p.add_argument("--password", help="Password")
    p.add_argument("--subject", default="otics.ingest.>", help="Subject to subscribe to")
    args = p.parse_args()

    nc = await nats.connect(servers=[args.url], user=args.user, password=args.password)

    async def handler(msg):
        print(f"[{msg.subject}] {msg.data.decode()}")

    await nc.subscribe(args.subject, cb=handler)
    print(f"✅ Subscribed to {args.subject}, waiting for messages...")
    while True:
        await asyncio.sleep(1)

if __name__ == "__main__":
    asyncio.run(main())

