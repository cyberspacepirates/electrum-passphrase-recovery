#!/usr/bin/bash

filename="wordlist.txt"

SEED="magic canoe normal aware extend earn jewel fresh detail peanut dice viable"

expected_address="bc1quhkf7wg82lamc0avjct0rt2s2k23wca4wtmnss"
end_address="tmnss"

electrum daemon -d 2> /dev/null

while IFS= read -r line
do
  electrum restore "$SEED" --passphrase "$line" > /dev/null
  electrum load_wallet -w ~/.electrum/wallets/default_wallet > /dev/null
  address=$(electrum getunusedaddress)
  if [[ "$address" == *"$end_address" ]]; then
    echo "The wallet was found, the passphrase is: ($line)"
    break
  else
    electrum close_wallet > /dev/null
    rm -rf ~/.electrum/wallets/default_wallet
  fi
done < "$filename"