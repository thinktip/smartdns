#! /bin/sh
#
# Update GFWList

# GFWlist Download Link
URL="https://cokebar.github.io/gfwlist2dnsmasq/gfwlist_domain.txt"

# DNS Server Group
PROXYDNS_NAME="foreign"

# Smartdns Config File Path
CONFIG_FLODER="/etc/smartdns"
CONFIG_FILE="gfwlist.conf"

INPUT_FILE=$(mktemp)
OUTPUT_FILE="$CONFIG_FLODER/$CONFIG_FILE"

if [ "$1" != "" ]; then
	PROXYDNS_NAME="$1"
fi

wget -O $INPUT_FILE $URL 
if [ $? -eq 0 ]
then
	echo "Download successful, updating..."
	mkdir -p $CONFIG_FLODER
	cat /dev/null > $OUTPUT_FILE

	cat $INPUT_FILE | while read line
	do
		echo "domain-rules /$line/ -address #6 -namesever $PROXYDNS_NAME" >> $OUTPUT_FILE
	done
fi

rm $INPUT_FILE
