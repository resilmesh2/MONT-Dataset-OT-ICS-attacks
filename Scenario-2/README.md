# Setting Up Scenario - Operational Disruption in OT/ICS Network

In order to create the Operational Disruption in OT/ICS Network, the first thing that we are going to do is set up the environment in which the attack will occur. 

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfZeXnsPO-eepvSEfmZoJWTHtoupgzmZpGrs6Ovt6iCZnC8Xa0Qqr1SRz6Hr67Qzj0VCsouUTkICOAPfRi9tmVFQ47-A_YhsJc1YHhBzA5UUtcWmYR_lCztiAgC6oc9hb9H0OTcTExPTKXx_f1ICfp_OzrN?key=ZVE4yllmhIbKOidz4k1V_g)

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

- Vulnerable Web Aplication at \<IP>:8081  # Whitelabel Error Page

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

For the VulnerableWeb App and the TomcatManager nothing needs to be done.


### **M1 - CVE-2021-44228 (Log4Shell)**

#### **Description:**

The Log4Shell vulnerability affects the Apache Log4j 2 library, which is widely used for logging in Java applications. By sending a specially crafted request, an attacker can trigger the vulnerability to execute arbitrary code on the server.


#### Log4Shell Attack - How it works

1. **Vulnerability Identification**: The Log4j library is used extensively in Java applications for logging purposes. A flaw in the JNDI (Java Naming and Directory Interface) lookup functionality allows remote code execution by injecting a JNDI URL into a log message.

2. **Exploit Execution**: The attacker sends a request containing a malicious JNDI URL. When the vulnerable application logs this request, the JNDI lookup mechanism fetches and executes the code from the attacker-controlled server.

3. **Remote Code Execution**: The code fetched via the JNDI URL is executed on the target server, giving the attacker control over the system. This can be used to deploy further payloads, access sensitive information, or pivot to other parts of the network.

Available code at: <https://github.com/christophetd/log4shell-vulnerable-app.git> 

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfvdGhPV3kqMM_DToL7uCWKchUZ5xlOuEbjC7x-5WyIuAvHrWEhvYNcMYXeGTaiycXN8P4qccazqQexuCgVsTvTdQNve04lECISSImc81rvhAbxdBSkzA01hif3O5gb0glv6CmiVk95NHhfY9LQe1_Q1zrR?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 6**: Vulnerable application set up.

M1 is in the same network as M2.


### **M2 - CVE-2009-3548 (WeakCredentials in Apache Manager of ScadaBR)**

In M2 there is a [ScadaBR](https://www.scadabr.com.br/) application for visualization of the system installed in M3. Also, weak credentials to the manager session  were set to simulate a WAR File Upload Attack to get later Remote Code Execution over M2.


#### **Description:**

The WAR File Upload Attack targets Apache Tomcat servers with weak or default credentials. This attack leverages the ability to upload a malicious Web Application Archive (WAR) file via the Tomcat Manager interface. Once uploaded, the WAR file is deployed as a web application, and it can include a script that grants the attacker remote code execution (RCE) capabilities on the server.


#### **RCE Using WAR Files in Apache Tomcat with Weak Credentials - How it Works:**

##### Vulnerability Identification:

Apache Tomcat provides a Manager application that allows administrators to deploy, undeploy, and manage web applications via a web interface. If this Manager interface is exposed to the internet and protected by weak or default credentials (e.g., `admin:admin`), attackers can gain unauthorized access to it. Once authenticated, the attacker can leverage the Manager interface to upload and deploy web applications.


##### Exploit Execution:

The attacker crafts a malicious WAR file, typically containing a script or a backdoor (e.g., `shell.jsp`). This WAR file can be created using tools like `msfvenom` or manually by packaging a `.jsp` file that provides shell access. The attacker then logs into the Tomcat Manager using weak or default credentials and uploads the malicious WAR file.


##### Remote Code Execution:

Once the WAR file is uploaded and deployed, it is accessible as a web application on the server. The attacker can then access the malicious script (e.g., `http://target-server:8080/shell/`) via a web browser or an HTTP request. This script allows the attacker to execute arbitrary commands on the server with the privileges of the Tomcat process.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdxXHCPKU6Qgei0zYi5Kt5qvIL9TVNK5m1sERbgBzpUhgmzbO-giZWlzEXEH4TSFXuwh_QNKTdy186qwle5V-992PP-yTP4jaTHz1zkL3OlSiZin4tPxQFGvlB1FvnQ0xdv8z3GMm28eIkM9pCionG366vu?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 7**: Tomcat manager page.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdWmasRN9D0yZwuO040pp8hJ3AxxSRoBXyOTPffCve1HjH_6lIvQOz5Rzp8GIpnC4jq37q59g-FSl8J9wRO_sSC_I79iR16g5SIcKDgtP3xZma9opzLX_VxZPveIgXI8R6KWR9t5eRFqHx6VAwRLlznSIk?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 8**: ScadaBR Human Machine Interface with the system installed in M3.


### **M3 - OpenPLC simulation Programmable Logic Controller** 

[OpenPLC](https://autonomylogic.com/) is an open-source software that emulates the functionality of a Programmable Logic Controller (PLC), commonly used in industrial automation. It allows for the simulation and testing of PLC programs on a computer, without needing physical hardware.

In this setup, OpenPLC (environment and editor) was used to simulate a real PLC that controls a simple process: two buttons (ON and OFF) that toggle an LED. This simulation is controlled via the MODBUS protocol, commonly used for communication in industrial environments. By using MODBUS protocol, OpenPLC can receive commands to switch the LED on or off, effectively mimicking a real-world PLC operation.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcbsT2koVdQ-Gl3kbpQvuGPCXtCa37hTSC0-qE8jTSBWRcijW7GmXOzXv-b-8Vg6Op0v4KMibtJhh7JlvVOfbPEEdMkKCaMv-LO3SHXXpYBMQMD6tSkBFiicZhDirCKBSVqeGfIj9JUBRu3AIeFUw8zt7s?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 9**: OpenPLC Environment - monitoring of the system.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeV2FW9bVmZLa2JXCsPUkMHJSMkLi6jk-8aWAB8h8qjwd5lYK4vdN2QkyryExyhwb8lA1mg9ntBAhtxmOMRhOwLNhE1nv9QFtlOPTJF2HTFWJxhwK3-0Dngm3dHqfYRn7O0Y4kk2J7Ddv91cq2PF6xb5Yc?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 10**: System created using openPLC editor.
