# Setting Up Scenario - OT Firmware Update from USB Memory Device

In order to create the OT Firmware Update from USB Memory Device, the first thing that we are going to do is set up the environment in which the attack will occur. 



**Img 1**: Scenario network topology.


### **Setting up network environment**

To set up the network environment, first you should change the INTERFACE variable located in the .env file. the docker-compose.yml file available (setting up the new interfaces before).

Then run:
```
# creating vlans for 3 network
sudo ./create\_vlans.sh
# setting up docker environment
sudo docker compose up
```


### **Once set up you will have the following services:**

Docker Containers

 **M1 - Attacker**
   - **Role:** Performs reconnaissance and conducts phishing attacks to gather information.
   - **Image:** `kalilinux/kali-rolling`
   - **Networks:**
     - `bridge_network`
     - `network1` (IP: 192.168.51.10)
   - **Ports:** 8082:8080
   - **Description:** M1 is used by the attacker to run Social-Engineer Toolkit (SET) for phishing and other attack activities.

**M2 - SCADA System (ScadaBR)**
   - **Role:** Simulates a SCADA system in the OT environment.
   - **Image:** `montimage/resilmesh:vulnerable_scadabr`
   - **Networks:**
     - `bridge_network`
     - `network1` (IP: 192.168.51.5)
     - `network2` (IP: 192.168.52.5)
   - **Ports:** 9090:9090

**M3 - OpenPLC**
   - **Role:** Simulates an OpenPLC system in the OT environment.
   - **Image:** `montimage/resilmesh:openplc`
   - **Networks:**
     - `bridge_network`
     - `network2` (IP: 192.168.52.6)
   - **Ports:** 8080:8080

**M4 - IT Workstation**
   - **Role:** Responsible for the OT system and receives phishing emails from M1.
   - **Image:** `ubuntu:latest`
   - **Networks:**
     - `bridge_network`
     - `network1` (IP: 192.168.51.2)
   - **Ports:** 8081:8080


## Accessing the Components

1. **OpenPLC Dashboard**:
   - URL: `http://192.168.52.6:8080`
   - **Username**: `openplc`
   - **Password**: `openplc`

2. **Scada Web Application**:
   - URL: `http://192.168.51.5:9090/ScadaBR`
   - **Username**: `admin`
   - **Password**: `admin`

3. **Tomcat Manager**:
   - URL: `http://192.168.51.5:9090/Manager`
   - **Username**: `admin`
   - **Password**: `admin`


### **OpenPLC:**

For the OpenPLC, you will have to upload the system program to the platform. So enter at openplc:openplc and:

**Programs > Browse >** Select the **On\_off.st** file > Give it a name > **Upload**

Then go to the Dashboard and Run it.

**Go to Dashboard > Start PLC (Left corner of Dashboard)**

Now you should be able to see it in the **Monitoring tab,** be aware that it can take some seconds to be visible on the tab.![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcMEMYa-mq4n05ATBqIZrDSxezq6i6tzEz7hRoz-tzCq4dA-jKHEmoNww1tqDhovrpFS4xqAYodvrjjdmY7JUan7DLr6RC4vCcFyO9hkvFAo5BM_A6wAJtloeOP_Ck7UbnFnKVffXrwM096zHneL8O4CjGO?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 2:** Monitoring of On\_off.st program running.

**ScadaBR:**

Once in ScadaBR, at the “Graphical Views” tab, a warning sign might be appearing in the icons of the Graphical View:

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfSW6vnR3jUlgsj4usQJcpkDJ41nkKcWto_1wsGit0KpzZ27XbATvC8lJP2004L3f94zP1T18FTjW-q_THyHYF0Y7UaaHv5EBNfpsv0ZNe997TDCh8ThRrRT2MeNYJCyTzNV9RnUp5uxVPQiaukMhcbizvi?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 3:** Warning sign in Graphical View.

If so, the following steps must be done:

Go to **Data Sources** and disable and enable the data source, this will reload the system, connecting the HMI with the PLC program.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXe1C2lTl-NkwbV42Ae9q41LH3SPvjltNOkwcCganDQrtAtkAHTvY2hlep5Qb2TDh99ucInNuv6FuUceg-hswDhsqA_YqTBL-Lhfxhg8Ey4WLOd_XAHOMh9fwWI1vEyvg3B7yWRF34RkT_xGcUTjucGRhN0?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 4:** Data sources table, to disable and enable click in the status icon, making it red and then green again.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeGN2d1ZLXYwxpBjMV3ZR03anSoBmzcELIyI0nrB5SKMEMVbxmryroN1aVjFAiHQf7kUkX5QzxDybHue5QzDCqCD4pjrIoo-dDH2wnn4fD2kdGTCJqXSJylddQI8XgflfSGkSciIFdeGIsZ5qAOTG4OGU31?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 5:** The Graphical View now is connected. You can interact with the system by clicking in “ON - Released” or “OFF - Released”. The result will be seen in the Graphical View and also in the OpenPLC Monitoring.

For the TomcatManager nothing needs to be done.
