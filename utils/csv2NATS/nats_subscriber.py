import asyncio
from nats.aio.client import Client as NATS

NATS_URL = "nats://localhost:4222"
SUBSCRIBE_SUBJECT = "ai4triage.logs"

# Variable pour suivre le nombre de messages
message_count = 0

async def message_handler(msg):
    """Callback pour traiter les messages reçus."""
    global message_count
    message_count += 1
    print(f"Reçu (Message numéro {message_count}) : {msg.data.decode()}")

async def main():
    """Connexion et abonnement au sujet NATS."""
    global message_count
    nc = NATS()

    # Connexion au serveur NATS
    await nc.connect(NATS_URL)
    await nc.subscribe(SUBSCRIBE_SUBJECT, cb=message_handler)
    print(f"Abonné au sujet '{SUBSCRIBE_SUBJECT}'")

    # Attendre les messages pendant un certain temps ou jusqu'à une condition
    await asyncio.sleep(10)  # Exécution pendant 10 secondes can be adjusted  

    # Afficher le total à la fin
    print(f"\n Nombre total de messages reçus from Nats : {message_count}")
    await nc.close()

if __name__ == '__main__':
    asyncio.run(main())


