#!/bin/bash
# Author: Jrohy
# github: https://github.com/Jrohy/multi-v2ray
SCPdir="/etc/newadm"
SCPusr="${SCPdir}/ger-user"
SCPfrm="/etc/ger-frm"
SCPinst="/etc/ger-inst"
SCPidioma="${SCPdir}/idioma"
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/

meu_ip () {
if [[ -e /etc/MEUIPADM ]]; then
echo "$(cat /etc/MEUIPADM)"
else
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && echo "$MEU_IP2" || echo "$MEU_IP"
echo "$MEU_IP2" > /etc/MEUIPADM
fi
}
IP="$(meu_ip)"

fun_V2ray () {
if [[ -e /usr/local/bin/v2ray ]]; then
 clear
   v2ray
else
source <(curl -sL https://git.io/fNgqx)
fi
}
fun_V2ray
