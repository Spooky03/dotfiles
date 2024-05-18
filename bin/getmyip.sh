#!/bin/bash

#broken
input=$(echo $(ifconfig))

regex='([a-zA-Z0-9]+):(?=.*?inet)'

# Use grep with Perl-compatible regular expressions to match non-overlapping Ethernet objects
echo "$input" | grep -Po "$regex" | while read -r adapter; do
    ip_address=$(grep -oP "$adapter:.*?inet \K[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" <<< "$input")
    netmask=$(grep -oP "$adapter:.*?netmask \K[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" <<< "$input")
    echo "Adapter: $adapter"
    echo "IP Address: $ip_address"
    echo "Netmask: $netmask"
    echo "---"
done
