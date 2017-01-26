#!/bin/bash

alias __dedup_line=__linededup;

__script2base() { while read line;do echo $line|sed 's/^;//g;s/^/;/g';done } ;

__linededup(){ awk '!x[$0]++' ;};

__functionsfromhistory() { history |grep "()"|sed 's/^ //g'|cut -d" " -f2-|grep -v "^ history"|__linededup ;};__cuts(){ cut -d" " -f$1;};__ip4neigh(){ ip -4 n;}; 
__ip6neigh(){ ip -6 n|__cuts 1-3|sed 's/ dev /%/g';};__local.machine__explore__diskids() { ls -1fdi /dev/disk/*/* -f1d|sed 's/^ \+//g'|sort -n |uniq |grep -v ^$ ; } ;

__Y0L0:DISK:SCHNORCHEL(){ __local.machine__explore__diskids|cut -d" " -f1| while read inum;do echo -n "$inum@"; readlink -fem  $(find /dev/disk/ -type l -inum "$inum" 2>/dev/null)|tr -d '\n';echo -n "::TARGETID::";find /dev/disk/ -type l -inum "$inum" 2>/dev/null;done |sed 's/\//'$(echo -n "__Y0L0DSK::°::UID::")$(id -u)"::¹::aKa::"$(id -un)"::@::"$(hostname -a)'::DISK::\//'|cut -d"@" -f2-|__linededup;};__y0hdr(){ echo "__y0l0::{¥Ħ:"$(hostname -a)"::¥Þ:";};__y0pid(){ echo -n "::¥Ω:{¥↑:["$(id -u|cut -d" " -f1)"|"$(id -un)"]::¥↓:["$(id -g)"|"$(id -gn)"]::¥↓þ:"$$;};__real_y0pid(){ ( echo -n $(__y0pid 2>&1  );echo -n "::¥®ẞ:"$$"::¥↑þ:"$BASHPID"::¥←Þ:"$PPID"}" 2>&1 ) 2>&1;};__echotest(){ echo $(__y0hdr)"¿echotest?"$(__real_y0pid)"}::¥CMD:echotest::¥RES:BASHPID: "$BASHPID" ; blaPPID: "$PPID" ;"::æ°::\""$1"\"::æ¹::\""$2"\"::æ²::\"$3"\"::æ³::\"$4"\"::æ4::\"$5"\"" ;};echotest(){ __echotest $@;};echotest 1 2 3 4

__explore_upandopen() { ( for interface in $(ip -6 l |grep ^[0-9]|cut -d":" -f2);do echo pinging ipv6 localnodes on $interface;ping6 -c6 -w6 ff02::1%$interface 2>&1 |sed 's/: icmp_seq/%'$interface'_seq/g;s/ bytes/b/g;s/ from /__frm__/g;s/^/__sys.p6__/g' 2>&1 |grep -v "__$"  2>&1 &  (jobs ; ps -ALcF)|grep -e $$ -e ping6|grep -v -e ^$ -e "$SHELL" -e grep -e "ALcF"  ; done | while read line;do echo "^INTRPRT__"$line;done |sed 's/.\+__frm__fe80/fe/g'|grep -e "%" -e ^fe:: ;echo -n 443 >/dev/null )  |grep ^fe::|sed 's/^fe::/fe80::/g'|cut -d"=" -f1 |grep ^fe80|cut -d"_" -f1|sort|uniq|while read nmapped;do  nmap -6 -p 22,53,80,111,443,8080,8888,5900-5999 $( echo $nmapped  )|grep -v -e "scan report for" -e "tcp \+closed" -e ^$ -e "^PORT" -e  "Nmap done:" -e "Starting Nmap"|sed 's/^/'$nmapped'::³::/g';done|grep -v "ffff:ffff" ; } ;

##MOUNT CASPERFS (e.g. ubuntu usb partition) _mount_casperfs /media/usb/casper-rw /tmp/caspermountdirectory
_mount_casperfs() { sudo mount -o loop $1	 $2 ; } ;

##dpkg list all installed packages
_dpkg_installed_packages() { dpkg --get-selections|grep -v deinstall|cut -f1 ; } ;

##dpkg list packages with filenames that have files in directory
_dpkg_owning_packages_withfiles() { _dpkg_installed_packages|while read pkg ; do dpkg -L $pkg|grep ^$1|sed 's/^/'$pkg'\t/g' ; done ; } ;

###DPKG RESTORE DELETED DIRECTORY

##dpkg list package names that have files in directory 
_dpkg_owning_packages() { _dpkg_installed_packages|grep -v deinstall|cut -f1|while read pkg ; do dpkg -L $pkg|grep ^$1|sed 's/^/'$pkg'\t/g' ; done |cut -f1|uniq ; } ;

##reinstall packages that installe files in directory
_apt_reinstall_directory() { sudo apt-get install --reinstall $(_dpkg_owning_packages $1) ; } ;
