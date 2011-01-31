#!/bin/bash

export AWS_ACCESS_KEY_ID=0G8H1DCEY714XH9S22G2

# This will prompt for the decryption passphrase
export AWS_ACCESS_KEY_SECRET=$(openssl enc -d -a -aes-256-cbc -salt <<EOF
U2FsdGVkX1+T/GI71g2HU69dKtAXRuvffYD3y8QD+7NT2Fu1AkQ2V6G4DE+ekgnY
9bLbiXQwnDdvWJ0/bfoC+w==
EOF
)

export AWS_SECRET_ACCESS_KEY=${AWS_ACCESS_KEY_SECRET}
