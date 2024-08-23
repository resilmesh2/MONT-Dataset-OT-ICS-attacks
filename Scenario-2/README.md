# Scenario - Ransomware attack on OT/ICS Network

In order to create the Ransomware Attack on OT/ICS Network, the first thing that we are going to do is set up the environment in which the attack will occur. 

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXd18qRUC-DXJsdoXFjnPyyEjAnVn3k8QZVaU38sJqFaN4HW1uewLeUCTScyX5eT4s1JFU1Z2LX23zarHqDAlwDzW-TP-Xn_xkfwmwqTb4xbDf_ZmNMaa6Hll5y7bVAsv2DQY35yf4MIfjdIqmU8CpJecJDm?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 1**: Scenario network topology.


### **Setting up network environment**

To set up the network environment, first you should change the INTERFACE variable located in the .env file. the docker-compose.yml file available (setting up the new interfaces before).

Then run:
```
# creating vlans for network1 and network2
sudo ./create\_vlans.sh# setting up docker environmentssudo docker compose up |
```

### **M1 - CVE-2021-44228 (Log4Shell)**

#### **Description:**

The Log4Shell vulnerability affects the Apache Log4j 2 library, which is widely used for logging in Java applications. By sending a specially crafted request, an attacker can trigger the vulnerability to execute arbitrary code on the server.


#### Log4Shell Attack - How it works

1. **Vulnerability Identification**: The Log4j library is used extensively in Java applications for logging purposes. A flaw in the JNDI (Java Naming and Directory Interface) lookup functionality allows remote code execution by injecting a JNDI URL into a log message.

2. **Exploit Execution**: The attacker sends a request containing a malicious JNDI URL. When the vulnerable application logs this request, the JNDI lookup mechanism fetches and executes the code from the attacker-controlled server.

3. **Remote Code Execution**: The code fetched via the JNDI URL is executed on the target server, giving the attacker control over the system. This can be used to deploy further payloads, access sensitive information, or pivot to other parts of the network.

Available code at: <https://github.com/christophetd/log4shell-vulnerable-app.git> 

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcFRRQKAfeAFXAXRQhQdhwGr6ODcXhOT09Zyvvw0Vh90JR9AO1XxnsQNxinN5I-y8vNRRX2X9HXlBP3pjjEeR1xnZREl_WrPIJbefRvcICNvXTFYODN9Pey_UGvKcrkalWHBtkhrUqIr5ytXb6znYd4RgbP?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 2**: Vulnerable application set up.

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

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfvcFclzFT9sLv9eq0qYfhs_rXAMFTPInwJIRWCtzJeb7TomFkGN63NlaGlwmnrluXWp4PbOdRcQLUA9_WfK0EM4Kci1EVoXM2HHjDyWtn6wlX0_cbSeyi561NDl0kLzomEuajN_b21EE6gpqsk-EKvIKob?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 3**: Tomcat manager page.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeehwu5kIPtDXfTJY7wle59CoGmAkbvDjCj8D_nVDKWqTCVvQKUNp5kB_rBVg0Ciq84vzlKTkcEwB6yk2Ch5xc0PVBom44LknSnOE-ERD1sBA47CVX5Y_c-6BOh-HYmrxpSAvC2rJeCL2yduwcwCpLv8tw?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 4**: ScadaBR Human Machine Interface with the system installed in M3.


### **M3 - OpenPLC simulation Programmable Logic Controller** 

[OpenPLC](https://autonomylogic.com/) is an open-source software that emulates the functionality of a Programmable Logic Controller (PLC), commonly used in industrial automation. It allows for the simulation and testing of PLC programs on a computer, without needing physical hardware.

In this setup, OpenPLC (environment and editor) was used to simulate a real PLC that controls a simple process: two buttons (ON and OFF) that toggle an LED. This simulation is controlled via the MODBUS protocol, commonly used for communication in industrial environments. By using MODBUS protocol, OpenPLC can receive commands to switch the LED on or off, effectively mimicking a real-world PLC operation.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXd3j2fmj7u43gn895rYyUBpe2kDnTpZ2ORw8erTaxvaOlkPR3sCBFyad6pAYknkK4p9EvwkduMAf8VmdVUcyvTLFaAIs_59X2N4UL8NqSt6okMjXjGI0l_5B3SKu0PFZjRRxap-CzE4wm9vBn0SDncjyzk?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 5**: OpenPLC Environment - monitoring of the system.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcwa9WpWQkywAYlePsk9dHYcuoMlIiigEnyMLmqN-TzTEhURpsNP_uapIGKNMY--__CabOXYHJsCaU20hOrdV-db77V0qxotzKa7ATx0quswnwEvk3GBNvYpTp_1NOkAu29OMMkWljrZ9C90_yV7GURteo?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 6**: System created using openPLC editor.
