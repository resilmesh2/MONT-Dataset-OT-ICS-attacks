# PCAP processing and feature extraction using MMT

The [extract_features_pcap.py](extract_features_pcap.py) script automates the process of processing an input pcap file, generating reports using the [MMT-Probe](https://github.com/Montimage/mmt-probe) tool, aggregating the results, and extracting session-based features for network traffic analysis.

## Requirements

To run the script, you need the following dependencies:

- Python 3.8.10+
- MMT tools (using [prebuilt packages](mmt-packages)) 
- `pandas` library (check version in [requirements.txt](requirements.txt)) 

## Usage

```Bash
python extract_features_pcap.py <pcap_file> <is_malicious (True/False)>
```
