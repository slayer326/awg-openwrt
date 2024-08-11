#!/bin/sh
#setup
target="ramips"
subtarget="mt7621"
tag="23.05.4"

#read info

#feeds="feeds.buildinfo"
profiles="profiles.json"
manifest="openwrt-${tag}-${target}-${subtarget}.manifest"

#download url
base="https://downloads.openwrt.org/releases/${tag}/targets/${target}/${subtarget}"
# echo "$base/$manifest"
#get arch
#echo "wget -q $base/$profiles -O-" 
#exit 0
arch=$(wget -q $base/$profiles -O- | tr ',' '\n' |grep "arch_packages"| awk -F: '{print $2}' | tr -d '"') #need jq -r '.arch_packages' but jq is not in base
vermagic=$(wget -q $base/$manifest -O- | grep "kernel -"  | awk -F- '{print $NF}')

echo "### OpenWrt build info for $tag/$target/$subtarget:"
echo "arch: $arch"
echo "vermagic: $vermagic"
 


