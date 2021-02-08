#!/bin/bash

package='openssl'
dpkg -s $package &> /dev/null

if [ $? -eq 0 ]; then
	#1. Create a self signed root certificate:
	echo "Creating CA certificate..."
	echo "Please enter the appropriate attributes"
	openssl req -x509 -newkey rsa:4096 -days 365 -keyout ca-key.pem -out ca-cert.pem

	echo -e "\n\nCongratulations! Your CA certificate is ready:"
	openssl x509 -in ca-cert.pem -noout -text

	#2. Create the server's private key and CSR
	echo -e "\n\n\nCreating CSR for the server..."
	echo "Please enter the appropriate attributes"
	openssl req -newkey rsa:4096 -keyout server-key.pem -out server-req.pem 

	echo -e "\n\n\nExamine and verify certificate request:"
	openssl req -in server-req.pem -text -verify -noout

	#3. Sign the server's certificate request
	echo -e "\n\n\nCreating server's certificate signed by local CA..."
	echo "Please enter the appropriate attributes"
	openssl x509 -req -in server-req.pem -days 365 -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile server-ext.conf

	echo -e "\n\n\nServer certificate signed by local CA:"
	openssl x509 -in server-cert.pem -text -noout

	#4. Verify a certificate
	echo -e "\n\n\nLet's verify the server certificate against CA certificate"
	openssl verify -CAfile ca-cert.pem server-cert.pem


else
    echo "\nOpenSSL Package is NOT installed!"
fi