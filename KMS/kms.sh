#!/bin/bash


aws kms create-key
aws kms encrypt --plaintext "hello" --key-id <arn>

aws iam create-user --user-name dave
aws iam create-access-key --user-name dave

aws configure --profile dave
aws kms encrypt --plaintext "hello" --key-id <arn> --profile dave

aws iam get-user --user-name dave
aws kms create-grant --key-id <arn> --grantee-principal <dave-arn> --operations "Encrypt"

aws kms encrypt --plaintext "hello" --key-id <arn> --grant-tokens <token> --profile dave

aws kms list-grants --key-id <arn>
aws kms revoke-grant --key-id <arn> --grant-id <grant-id>


