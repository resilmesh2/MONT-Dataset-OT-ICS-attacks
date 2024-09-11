# Initial Access

## Scenario Overview

In this phase, the attacker uses the malicious USB device created in the **Resource Development** phase to gain initial access to the OT environment. The attacker mails the USB thumb drive to the individual responsible for the OT system, posing as the legitimate manufacturer.

- **MITRE ATT&CK Technique**: [T1091 - Initial Access: Replication Through Removable Media](https://attack.mitre.org/techniques/T1091/)

## Objective

The objective is to gain access to the OT environment by exploiting the trust of the responsible personnel. Once the USB device is inserted, the malware payload is executed, giving the attacker an initial foothold in the system.

## Steps to Execute Initial Access

### 1. Craft the Phishing Package

Using the information gathered during the **Reconnaissance** phase, the attacker sends a phishing package containing the USB thumb drive. This package includes:

- The malicious USB device loaded with the fake firmware update (`PLC_Firmware_Update.exe`).
- A letter or email appearing to be from the legitimate manufacturer of the OT system, requesting a firmware update.
- Contact information, logos, and other branding that mimics the actual manufacturer, making the phishing attempt more convincing.

### 2. Spoof the Manufacturer's Identity

To enhance the credibility of the phishing attempt, the attacker can spoof the email address or physical address of the manufacturer. For email-based phishing, the attacker could:

1. Use a fake email domain that looks similar to the real manufacturer's domain (e.g., `support@manufacturer-update.com` instead of `support@manufacturer.com`).
2. Create professional-looking communication that instructs the target to perform the firmware update using the enclosed USB device.

### 3. Deliver the USB Device

The phishing package is delivered to the target either by mail or email. The USB drive is disguised as a legitimate firmware update:

- If mailed, the package contains a physical USB drive with instructions to update the OT system.
- If emailed, instructions direct the target to download a link that mimics an official firmware update page.

### 4. The Target Inserts the USB into the OT System

The responsible person, believing the USB drive or download link to be legitimate, follows the instructions and inserts the USB drive into the workstation responsible for the OT system (**M1**). This workstation has access to SCADA systems (M2) and OpenPLC systems (M3).

- Once the USB is inserted, the system reads the `PLC_Firmware_Update.exe` file.
- The malware is executed, either manually or automatically (if autorun is configured).

### 5. Attacker Gains Access to the OT Environment

Upon execution, the attacker’s malware:

- Initiates a reverse shell or command-and-control (C2) connection to the attacker's machine (**M1**).
- The attacker now has remote access to the OT environment, beginning with the compromised workstation.

## Next Steps
Once the attacker has gained access to the OT system, the next phase is Execution of the malware on the compromised system.

## Summary
In the Initial Access (T1091) phase, the attacker successfully delivers a malicious USB device to the target. The responsible person for the OT system unknowingly inserts the device, triggering the malware and giving the attacker access to the OT environment.

```
This `README.md` outlines how the attacker gains **Initial Access** through the delivery of a malicious USB device and the subsequent compromise of the OT system.
```
