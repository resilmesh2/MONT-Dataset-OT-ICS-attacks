# Setting Up Scenario - OT Firmware Update from USB Memory Device

In order to create the OT Firmware Update from USB Memory Device, the first thing that we are going to do is set up the environment in which the attack will occur. 



**Img 1**: Scenario network topology.


### **Setting up network environment**

To set up the network environment, first you should change the INTERFACE variable located in the .env file. the docker-compose.yml file available (setting up the new interfaces before).

Then run:
```
# creating vlans for network1 and network2
sudo ./create\_vlans.sh
# setting up docker environment
sudo docker compose up
```


### **Once set up you will have the following services:**

* OpenPLC Dashboard at \<IP>:8080 # username:password = openplc:openplc

* Scada Web Aplication at \<IP>:9090/ScadaBR # username:password = admin:admin

* TomcatManager at \<IP>:9090/Manager # username:password = admin:admin


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


M1 is in the same network as M2.
