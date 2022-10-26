#!/bin/bash
url=$1

if [ ! -d "$url" ];then
	mkdir $url
fi

if [ ! -d "$url/report" ];then
	mkdir $url/report
fi

echo "[+]These are the alive subdomains..."
assetfinder $url >> $url/report/assets.txt
cat $url/report/assets.txt | grep $1 >> $url/report/domains.txt
rm $url/report/assets.txt


cat $url/report/domains.txt | sort -u | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ':443'
