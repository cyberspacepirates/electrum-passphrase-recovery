#!/usr/bin/bash

electrum close_wallet
electrum stop
rm -rf ~/.electrum/wallets/default_wallet