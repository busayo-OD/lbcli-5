# Create a CSV script that would lock funds until one hundred and fifty blocks had passed
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

delay_blocks=150
pubkey="02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277"

# Convert delay to little-endian hex (2 bytes)
delay_hex=$(printf '%04x' "$delay_blocks")
delay_hex_le=$(echo "$delay_hex" | sed 's/../& /g' | awk '{for(i=2;i>=1;i--) printf $i}')

# HASH160 of the pubkey
pubkey_hash=$(echo "$pubkey" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -ripemd160 -binary | xxd -p -c 40)

# script
script="02${delay_hex_le}b27576a914${pubkey_hash}88ac"
echo "$script"