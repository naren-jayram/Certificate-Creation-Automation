# Certificate Creation Automation

### Description
Tiny script to automate the process of creating certificates (from CA certificate to server's certificate)

### Usage
1. You can add extensions to the server's certificate. If you are planning to add them, please place it in **server-ext.conf**
2. ./certificate_creation_automation.sh

**Note:** Feel free to tweak the parameters in the script as per your needs 

### Output Files
CA Private Key: ca-key.pem 
CA Root Certificate: ca-cert.pem
Server's Private Key: server-key.pem 
Server's CSR: server-req.pem
Server's certificate signed by CA: server-cert.pem