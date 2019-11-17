#!/bin/bash
# Author: Jrohy
# github: https://github.com/Jrohy/multi-v2ray
SCPdir="/etc/newadm"
SCPusr="${SCPdir}/ger-user"
SCPfrm="/etc/ger-frm"
SCPinst="/etc/ger-inst"
SCPidioma="${SCPdir}/idioma"
backv2ray="$HOME/backv2ray"
src_v2ray="/etc/v2ray/config.json"
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/

#COLORES
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"
rst="$(tput sgr0)"

txt[1]="PANEL V2RAY"
txt[2]="ACTUALIZAR V2RAY MANTENIENDO USUARIOS"
txt[3]="BACKUP DE USUARIOS"
txt[4]="RESTAURACION DE BACKUP"
txt[5]="DESINSTALAR !"
txt[6]="REGRESAR"

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

echo "${red} MENU DE ADMINISTRACION V2RAY"
echo " [1] > $blue ${txt[1]}"
echo " [2] > $blue ${txt[2]}"
echo " [3] > $blue ${txt[3]}"
echo " [4] > $blue ${txt[4]}"
echo " [5] > [!] $yellow ${txt[5]}"
echo " [0] > $magenta ${txt[6]}"

unset selection
while [[ ${selection} != @([0-5]) ]]; do
echo -ne "\033[33m${txt[7]}: " && read selection
tput cuu1 && tput dl1
done
if [[ ${selection} = "1" ]]; then
clear
[[ ! -e /usr/local/bin/v2ray ]] && source <(curl -sL https://git.io/fNgqx)
v2ray
exit 0
elif [[ ${selection} = "2" ]]; then
source <(curl -sL https://git.io/fNgqx) -k
elif [[ ${selection} = "3" ]]; then {
if [[ ! -d ${backv2ray} ]]; then
mkdir ${backv2ray}
elif [[ ! -e ${backv2ray}/config.json ]]; then
read -p "NO EXISTE BACKUP PREVIO, SE REALIZARA BACKUP DE USUARIOS [presiona enter para continuar]: " enter
cp -f ${src_v2ray} ${backv2ray} 
elif [[ -e ${backv2ray}/config.json ]]; then
read -p "EXISTE UN BACKUP PREVIO AL CONTINAR SE REMPLAZARA LA BASE DE DATOS RESPALDADA [presiona enter para continuar]: " enter
cp -f ${src_v2ray} ${backv2ray}
fi
}
elif [[ ${selection} = "4" ]]; then
[[ -e ${backv2ray}/config.json ]] && read -p "BACKUP ENCONTRADO, SE REMPLAZARA LA BASE DE DATOS ACTUAL POR LA DEL BACKUP [enter para continuar]: " enter && cp -f {backv2ray}/config.json ${src_v2ray}
elif [[ ${selection} = "5" ]]; then
source <(curl -sL https://git.io/fNgqx) --remove
elif [[ ${selection} = "0" ]]; then
cd $HOME
exit 0
fi
${SCPdir}/menu
