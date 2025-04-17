# Create a CLTV script with a timestamp of 1495584032 and public key below:
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

timestamp=1495584032
pubkey="02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277"

# Convert timestamp to little-endian hex (4 bytes)
timestamp_hex=$(printf '%08x\n' "$timestamp" | sed 's/../& /g' | awk '{for(i=4;i>=1;i--) printf $i}'; echo)

# HASH160 of the pubkey (SHA256 -> RIPEMD160)
pubkey_hash=$(echo "$pubkey" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -ripemd160 -binary | xxd -p -c 40)

# script: <timestamp> CLTV DROP DUP HASH160 <pubkey_hash> EQUALVERIFY CHECKSIG
script="04${timestamp_hex}b17576a914${pubkey_hash}88ac"
echo "$script"

