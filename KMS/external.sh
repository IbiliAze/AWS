#!/bin/bash

openssl --version #make sure OpenSSL is installed

aws s3 cp s3://kms-bucket-for-ibi /home/ec-user --recursive

openssl rand -out PlaintextKeyMaterial.bin 32 #generate plain-text key material

openssl rsautl -encrypt -in PlaintextKeyMaterial.bin -oaep -inkey PublicKey.bin -keyform DER -pubin -out EncryptedKeyMaterial.bin #replace the PublicKey.bin with the wrapping-key

aws s3 cp /home/ec2-user s3://kms-bucket-for-ibi --recursive #after that, download the EncryptedKeyMaterial.bin file, and upload that and the import token to KMS
