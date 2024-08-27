# **Impact** 

### **MITRE Technique: T0826 - Modify Control Logic**

This technique involves **altering the control logic or modifying system states**, such as turning off specific processes or causing unexpected machine behavior. The attacker leverages their deep access to the system to introduce faulty logic or undesirable state changes into the process control, leading to **physical disruptions** in operations.


#### **Disturbing Process Control by Altering Machine States**

The attacker is now able to disrupt the operational process by changing the machine states using the **MODBUS/TCP protocol**, effectively manipulating the physical systems controlled by the industrial control system (ICS). This phase of the attack can cause critical disruptions to the affected infrastructure, such as turning off essential processes or causing physical damage to equipment and/or people.


### **Step-by-Step Manipulation:**

1. **Command Execution:**

- The attacker issues the following **Modpoll** command to change the state of machines on **M3** (machine with IP `192.168.52.6`):

```
# step 1 
modpoll -m tcp -0 -r 1 -t 0 -c 3 192.168.52.6 0 0 0
```
- **Explanation of Command:**

`-m tcp`: Specifies MODBUS over TCP communication.

`-0`: Sets the output state to **0**, effectively turning off or deactivating the system.

`-r 1`: Specifies the starting register.

`-t 0`: Specifies the data type (coil/output). 

`-c 3`: Number of registers to be modified.

**- IP**: `192.168.52.6` is the IP address of the machine being targeted.

**Resulting Impact:**

Exploring a scenario in which the attacker does not know exactly what each register is used for, he attempts to just modify them by setting all to 0. ****

- This command has the potential to stop operations, cause malfunctions, or create dangerous situations within a physical environment.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfjiBHdXeihEGxTHuIYMXE658qYe8UCjs2W3fGhY6tDLJQSNkMQ8Ltsy0O1lvmF_hKict63Ane6FZKBwLdS9ykJynePMo0LX0Ynm3Mz8EYxP8XwAadkLvM74yzq84VKxM0qDn4PqVzMgOi884pUNB8E91dq?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 15:** The attacker successfully changed the state of the process, however as we can see the \[1] register is still on, since \[3] has to be true to turn the LED off. With more consecutives tries this could easily be achieved. ****

****![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdj1eNdvBQAsBYczypajes6QYsj5pgipcZGv11cm_bBzsn7OGK-2Obwyy1cwfe6tvls5hvIwFYOulD_jsez-ps_Vz-6ooMeudEFbk0UGx963G9Hm1MCtoUDDz3bA7NRWVuuoC-26KkxWPrm_zBkEal4jB8?key=ZVE4yllmhIbKOidz4k1V_g)****

**Img 16:** The result of those actions could also be seen in the openPLC Dashboard.
