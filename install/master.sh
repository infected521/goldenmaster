#!/bin/bash
#titulo:        Instalador Master
#descripcion:    
#author:        La Casita Del Terror
#created:       Mayo 15 2019
#updated:       Noviembre 4 2019
#version:       1.2
#usage:         
#==========================================================================
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/
rm -Rf /etc/SCRIPT/* /usr/bin/gerar* /usr/bin/master* /etc/texto-adm /etc/newadm-in*
clear
IVAR="/etc/http-instas"
SCPT_DIR="/etc/SCRIPT"
SCPresq="aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2luZmVjdGVkNTIxL2dvbGRlbm1hc3Rlci9tYXN0ZXIvcmVxdWVzdAo="
CRIMSON="aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2luZmVjdGVkNTIxL2dvbGRlbm1hc3Rlci9tYXN0ZXIvcmVxdWVzdC9nZXJhci5zaAo="
SABBATH="aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2luZmVjdGVkNTIxL2dvbGRlbm1hc3Rlci9tYXN0ZXIvcmVxdWVzdC9odHRwLXNlcnZlci5weQo="
FLOYD="aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2luZmVjdGVkNTIxL2dvbGRlbm1hc3Rlci9tYXN0ZXIvcmVxdWVzdC9tYXN0ZXIuc2gK"
SUB_DOM='base64 -d'
rm $(pwd)/$0
ofus () {
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="+";;
"+")txt[$i]=".";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"3")txt[$i]="%";;
"%")txt[$i]="3";;
"/")txt[$i]="K";;
"K")txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}
veryfy_fun () {
[[ ! -d ${IVAR} ]] && touch ${IVAR}
[[ ! -d ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
unset ARQ
case $1 in
"gerar.sh")ARQ="/usr/bin/";;
"master.sh")ARQ="/usr/bin/";;
"http-server.py")ARQ="/bin/";;
*)ARQ="${SCPT_DIR}/";;
esac
mv -f $HOME/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo "$IP" > /usr/bin/vendor_code
}
meu_ip
echo -e "\033[1;33mInstalando Archivos... "
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
cd $HOME
REQUEST=$(echo $SCPresq|$SUB_DOM)
wget -O "$HOME/lista-arq" ${REQUEST}/GERADOR > /dev/null 2>&1
sleep .8s
[[ -e $HOME/lista-arq ]] && {
for arqx in `cat $HOME/lista-arq`; do
echo -ne "\033[1;33m Descargando Archivos \033[1;31m[$arqx] "
wget -O $HOME/$arqx ${REQUEST}/${arqx} > /dev/null 2>&1 && {
echo -e "\033[1;31m- \033[1;32mRecebido Con Exito!"
#TOOLBAND=$(echo $CRIMSON|$SUB_DOM)
#wget -O /etc/SCRIPT/gerar.sh $TOOLBAND  &> /dev/null && chmod 755 /etc/SCRIPT/gerar.sh
#BLACK=$(echo $SABBATH|$SUB_DOM)
#wget -O /etc/SCRIPT/http-server.py $BLACK  &> /dev/null && chmod 755 /etc/SCRIPT/http-server.py
#PINK=$(echo $FLOYD|$SUB_DOM)
#wget -O /usr/bin/master.sh $PINK  &> /dev/null && chmod 755 /usr/bin/master.sh
[[ -e $HOME/$arqx ]] && veryfy_fun $arqx
} || echo -e "\033[1;31m- \033[1;31mFalla (no recebido!)"
done
[[ ! -e /usr/bin/trans ]] && wget -O /usr/bin/trans https://github.com/infected521/Generador/blob/master/Install/trans &> /dev/null
[[ -e /bin/http-server.py ]] && mv -f /bin/http-server.py /bin/http-server.sh && chmod +x /bin/http-server.sh
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] || apt-get install screen -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] || apt-get install nano -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || apt-get install netcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || apt-get install apache2 -y &>/dev/null
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1 &
IVAR2="/etc/key-gerador"
echo "$Key" > $IVAR2
rm $HOME/lista-arq
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo "/usr/bin/master.sh" > /usr/bin/master && chmod +x /usr/bin/master
#cp /etc/SCRIPT/gerar.sh /usr/bin/gerar.sh
echo "/usr/bin/gerar.sh" > /usr/bin/gerar && chmod +x /usr/bin/gerar

echo -e "\033[1;33mInstalacion finalizada\n\n"

echo -e "\033[1:33mUsar los Comandos para acceder a los generadores\n"

echo -e "\033[1;31m [ master ] \033[1;33mpara abrir el generador de keys master"

echo -e "\033[1;31m [ gerar ] \033[1;33mpara abrir el generador de keys para ADM"


echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
} || {
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;33mKey Invalida!"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
}
echo -ne "\033[0m"
apt-get install netcat -y &>/dev/null
sleep 2.8

