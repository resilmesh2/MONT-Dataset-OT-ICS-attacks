# Use the Kali Linux image as base
FROM kalilinux/kali-rolling

# Install necessary packages
RUN apt-get update && \
    apt-get install -y git curl python3-pip && \
    curl https://raw.githubusercontent.com/rapid7/metasploit-framework/master/scripts/msfupdate | bash && \
    git clone https://github.com/trustedsec/social-engineer-toolkit.git /opt/set && \
    cd /opt/set && pip3 install -r requirements.txt && python3 setup.py install

# Initialize Metasploit database
RUN /opt/metasploit-framework/msfdb init

# Set the entrypoint to keep container running
CMD ["bash", "-c", "echo 'M1: Attacker with SET and Metasploit ready.' && sleep infinity"]
