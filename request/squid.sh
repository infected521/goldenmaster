#!/bin/bash
fun_trans () { 
local texto
local retorno
declare -A texto
[[ ! -e /etc/texto-adm ]] && touch /etc/texto-adm
source /etc/texto-adm
if [[ -z $(echo ${texto[$2]}) ]]; then
ENGINES=(aspell google deepl bing spell hunspell apertium yandex)
  while [[ -z $retorno ]]; do
    NUM="$(($RANDOM%${#ENGINES[@]}))"
    retorno="$(source trans -e ${ENGINES[$NUM]} -b pt:$1 "$2"|sed -e 's/[^a-z0-9 -]//ig' 2>/dev/null)"
  done
 echo "texto[$2]='$retorno'"  >> /etc/texto-adm
 echo "$retorno"
else
 echo "${texto[$2]}"
fi
}
declare -A cor=( [0]="\033[33m" [1]="\033[33m" [2]="\033[33m" [3]="\033[33m" [4]="\033[33m" )
barra="\033[0m\e[33m======================================================\033[1;37m"
[[ -z $1 ]] && exit || id=$1
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit
[[ -z $1 ]] && exit || id=$1
#LISTA PORTAS
mportas () {
unset portas
portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
while read port; do
var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e $portas|grep "$var1 $var2")" ]] || portas+="$var1 $var2\n"
done <<< "$portas_var"
i=1
echo -e "$portas"
}
fun_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP"
}
#ETHOOL SSH
fun_eth () {
eth=$(ifconfig | grep -v inet6 | grep -v lo | grep -v 127.0.0.1 | grep "encap:Ethernet" | awk '{print $1}')
    [[ $eth != "" ]] && {
    echo -e "$barra"
    echo -e "${cor[3]} $(fun_trans ${id} "Aplicar Sistema Para Melhorar Pacotes Ssh?")"
    echo -e "${cor[3]} $(fun_trans ${id} "Opcao Para Usuarios Avancados")"
    echo -e "$barra"
    read -p "[S/N]: " -e -i n sshsn
    tput cuu1 && tput dl1
           [[ "$sshsn" = @(s|S|y|Y) ]] && {
           echo -e "${cor[1]} $(fun_trans ${id} "Correcao de problemas de pacotes no SSH...")"
           echo -e " $(fun_trans ${id} "Qual A Taxa RX")"
           echo -ne "[ 1 - 999999999 ]: "; read rx
           [[ "$rx" = "" ]] && rx="999999999"
           echo -e " $(fun_trans ${id} "Qual A Taxa TX")"
           echo -ne "[ 1 - 999999999 ]: "; read tx
           [[ "$tx" = "" ]] && tx="999999999"
           apt-get install ethtool -y > /dev/null 2>&1
           ethtool -G $eth rx $rx tx $tx > /dev/null 2>&1
           echo -e "$barra"
           }
     }
}
fun_bar () {
comando="$1"
 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
echo -ne " \033[1;33m["
   for((i=0; i<10; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.2
   done
echo -ne "\033[1;33m]"
sleep 1s
echo
tput cuu1 && tput dl1
done
echo -e " \033[1;33m[\033[33m####################\033[1;33m] - \033[1;32m100%\033[0m"
sleep 1s
}
fun_squid  () {
  if [[ -e /etc/squid/squid.conf ]]; then
  var_squid="/etc/squid/squid.conf"
  elif [[ -e /etc/squid3/squid.conf ]]; then
  var_squid="/etc/squid3/squid.conf"
  fi
  [[ -e $var_squid ]] && {
  echo -e "\033[1;32m $(fun_trans ${id} "REMOVENDO SQUID")\n$barra"
  service squid stop > /dev/null 2>&1
  fun_bar "apt-get remove squid3 -y"
  echo -e "$barra\n\033[1;32m $(fun_trans ${id} "Procedimento Concluido")\n$barra"
  [[ -e $var_squid ]] && rm $var_squid
  return 0
  }
echo -e "\033[1;32m $(fun_trans ${id} "INSTALADOR SQUID GOLDEN ADM PRO")\n$barra"
fun_ip
echo -ne " $(fun_trans ${id} "Confirme seu ip")"; read -p ": " -e -i $IP ip
echo -e " $(fun_trans ${id} "Agora Escolha as Portas que Deseja No Squid")"
echo -e " $(fun_trans ${id} "Escolha As Portas Em Ordem Sequencial Exemplo: 80 8080 8799 3128")"
echo -ne " $(fun_trans ${id} "Digite as Portas:") "; read portasx
totalporta=($portasx)
unset PORT
   for((i=0; i<${#totalporta[@]}; i++)); do
        [[ $(mportas|grep "${totalporta[$i]}") = "" ]] && {
        echo -e "\033[1;33m $(fun_trans ${id} "Porta Escolhida:")\033[1;32m ${totalporta[$i]} OK"
        PORT+="${totalporta[$i]}\n"
        } || {
        echo -e "\033[1;33m $(fun_trans ${id} "Porta Escolhida:")\033[1;31m ${totalporta[$i]} FAIL"
        }
   done
  [[ -z $PORT ]] && {
  echo -e "\033[1;31m $(fun_trans ${id} "Nenhuma Porta Valida Foi Escolhida")\033[0m"
  return 1
  }
echo -e "$barra"
echo -e " $(fun_trans ${id} "INSTALANDO PROXY SQUID GOLDEN ADM PRO")"
echo -e "$barra"
fun_bar "apt-get install squid3 -y"
echo -e "$barra"
echo -e " $(fun_trans ${id} "INICIANDO CONFIGURACAO")"
echo -e ".bookclaro.com.br/\n.claro.com.ar/\n.claro.com.br/\n.claro.com.co/\n.claro.com.ec/\n.claro.com.gt/\n.cloudfront.net/\n.claro.com.ni/\n.claro.com.pe/\n.claro.com.sv/\n.claro.cr/\n.clarocurtas.com.br/\n.claroideas.com/\n.claroideias.com.br/\n.claromusica.com/\n.clarosomdechamada.com.br/\n.clarovideo.com/\n.facebook.net/\n.facebook.com/\n.netclaro.com.br/\n.oi.com.br/\n.oimusica.com.br/\n.speedtest.net/\n.tim.com.br/\n.timanamaria.com.br/\n.vivo.com.br/\n.rdio.com/\n.compute-1.amazonaws.com/\n.portalrecarga.vivo.com.br/\n.vivo.ddivulga.com/" > /etc/payloads
echo -e "$barra\n\033[1;32m $(fun_trans ${id} "Agora Escolha Uma Conf Para Seu Proxy")\n$barra"
echo -e "|1| $(fun_trans ${id} "Comum")"
echo -e "|2| $(fun_trans ${id} "Customizado") -\033[1;31m $(fun_trans ${id} "Usuario Deve Ajustar")\033[1;37m\n$barra"
read -p "[1/2]: " -e -i 1 proxy_opt
tput cuu1 && tput dl1
if [[ $proxy_opt = 1 ]]; then
echo -e " $(fun_trans ${id} "INSTALANDO SQUID COMUM")"
elif [[ $proxy_opt = 1 ]]; then
echo -e " $(fun_trans ${id} "INSTALANDO SQUID CUSTOMIZADO")"
else
echo -e " $(fun_trans ${id} "INSTALANDO SQUID COMUM")"
proxy_opt=1
fi
unset var_squid
if [[ -d /etc/squid ]]; then
var_squid="/etc/squid/squid.conf"
elif [[ -d /etc/squid3 ]]; then
var_squid="/etc/squid3/squid.conf"
fi
if [[ "$proxy_opt" = @(02|2) ]]; then
echo -e "#ConfiguracaoSquiD
acl url1 dstdomain -i $ip
acl url2 dstdomain -i 127.0.0.1
acl url3 url_regex -i '/etc/payloads'
acl url4 url_regex -i '/etc/opendns'
acl url5 dstdomain -i localhost
acl accept dstdomain -i GET
acl accept dstdomain -i POST
acl accept dstdomain -i OPTIONS
acl accept dstdomain -i CONNECT
acl accept dstdomain -i PUT
acl HEAD dstdomain -i HEAD
acl accept dstdomain -i TRACE
acl accept dstdomain -i OPTIONS
acl accept dstdomain -i PATCH
acl accept dstdomain -i PROPATCH
acl accept dstdomain -i DELETE
acl accept dstdomain -i REQUEST
acl accept dstdomain -i METHOD
acl accept dstdomain -i NETDATA
acl accept dstdomain -i MOVE
acl all src 0.0.0.0/0
http_access allow url1
http_access allow url2
http_access allow url3
http_access allow url4
http_access allow url5
http_access allow accept
http_access allow HEAD
http_access deny all

# Request Headers Forcing

request_header_access Allow allow all
request_header_access Authorization allow all
request_header_access WWW-Authenticate allow all
request_header_access Proxy-Authorization allow all
request_header_access Proxy-Authenticate allow all
request_header_access Cache-Control allow all
request_header_access Content-Encoding allow all
request_header_access Content-Length allow all
request_header_access Content-Type allow all
request_header_access Date allow all
request_header_access Expires allow all
request_header_access Host allow all
request_header_access If-Modified-Since allow all
request_header_access Last-Modified allow all
request_header_access Location allow all
request_header_access Pragma allow all
request_header_access Accept allow all
request_header_access Accept-Charset allow all
request_header_access Accept-Encoding allow all
request_header_access Accept-Language allow all
request_header_access Content-Language allow all
request_header_access Mime-Version allow all
request_header_access Retry-After allow all
request_header_access Title allow all
request_header_access Connection allow all
request_header_access Proxy-Connection allow all
request_header_access User-Agent allow all
request_header_access Cookie allow all
#request_header_access All deny all

# Response Headers Spoofing

#reply_header_access Via deny all
#reply_header_access X-Cache deny all
#reply_header_access X-Cache-Lookup deny all

#portas" > $var_squid
for pts in $(echo -e $PORT); do
echo -e "http_port $pts" >> $var_squid
done
echo -e "
#nome
visible_hostname GOLDEN-ADM
via off
forwarded_for off
pipeline_prefetch off" >> $var_squid
 else
echo -e "#ConfiguracaoSquiD
acl url1 dstdomain -i $ip
acl url2 dstdomain -i 127.0.0.1
acl url3 url_regex -i '/etc/payloads'
acl url4 url_regex -i '/etc/opendns'
acl url5 dstdomain -i localhost
acl all src 0.0.0.0/0
http_access allow url1
http_access allow url2
http_access allow url3
http_access allow url4
http_access allow url5
http_access deny all

#portas" > $var_squid
for pts in $(echo -e $PORT); do
echo -e "http_port $pts" >> $var_squid
done
echo -e "
#nome
visible_hostname GOLDEN-ADM

via off
forwarded_for off
pipeline_prefetch off" >> $var_squid
fi
touch /etc/opendns
fun_eth
echo -ne " \033[1;31m [ ! ] \033[1;33m$(fun_trans ${id} "REINICIANDO SERVICOS")"
squid3 -k reconfigure > /dev/null 2>&1
service ssh restart > /dev/null 2>&1
service squid3 restart > /dev/null 2>&1
echo -e " \033[1;32m[OK]"
echo -e "$barra\n ${cor[3]}$(fun_trans ${id} "SQUID CONFIGURADO")\n$barra"
#UFW
for ufww in $(mportas|awk '{print $2}'); do
ufw allow $ufww > /dev/null 2>&1
done
}
online_squid () {
payload="/etc/payloads"
echo -e "\033[33m$(fun_trans ${id} "PROXY SQUID CONFIGURADO")\n$barra"
echo -e "${cor[2]} [1] >${cor[3]} $(fun_trans ${id} "Colocar Host no Squid")"
echo -e "${cor[2]} [2] >${cor[3]} $(fun_trans ${id} "Remover Host do Squid")"
echo -e "${cor[2]} [3] >${cor[3]} $(fun_trans ${id} "Desinstalar o Squid")"
echo -e "${cor[2]} [0] >${cor[3]} $(fun_trans ${id} "Voltar")\n$barra"
while [[ $varpay != @(0|[1-3]) ]]; do
read -p "[0/3]: " varpay
tput cuu1 && tput dl1
done
if [[ "$varpay" = "0" ]]; then
return 1
elif [[ "$varpay" = "1" ]]; then
echo -e "${cor[4]} $(fun_trans ${id} "Hosts Atuais Dentro do Squid")\n$barra"
cat $payload | awk -F "/" '{print $1,$2,$3,$4}'
echo -e "$barra"
while [[ $hos != \.* ]]; do
echo -ne "${cor[4]}$(fun_trans ${id} "Digite a Nova Host"): " && read hos
tput cuu1 && tput dl1
[[ $hos = \.* ]] && continue
echo -e "${cor[4]}$(fun_trans ${id} "Comece com") .${cor[0]}"
sleep 2s
tput cuu1 && tput dl1
done
host="$hos/"
[[ -z $host ]] && return 1
[[ `grep -c "^$host" $payload` -eq 1 ]] &&:echo -e "${cor[4]}$(fun_trans ${id} "Host Ja Existe")${cor[0]}" && return 1
echo "$host" >> $payload && grep -v "^$" $payload > /tmp/a && mv /tmp/a $payload
echo -e "${cor[4]}$(fun_trans ${id} "Host Adicionada Com Sucesso")${cor[0]}\n$barra"
cat $payload | awk -F "/" '{print $1,$2,$3,$4}'
echo -e "$barra"
if [[ ! -f "/etc/init.d/squid" ]]; then
service squid3 reload
service squid3 restart
else
/etc/init.d/squid reload
service squid restart
fi	
return 0
elif [[ "$varpay" = "2" ]]; then
echo -e "${cor[4]} $(fun_trans ${id} "Hosts Atuais Dentro do Squid")\n$barra"
cat $payload | awk -F "/" '{print $1,$2,$3,$4}'
echo -e "$barra"
while [[ $hos != \.* ]]; do
echo -ne "${cor[4]}$(fun_trans ${id} "Digite a Host"): " && read hos
tput cuu1 && tput dl1
[[ $hos = \.* ]] && continue
echo -e "${cor[4]}$(fun_trans ${id} "Comece com") .${cor[0]}"
sleep 2s
tput cuu1 && tput dl1
done
host="$hos/"
[[ -z $host ]] && return 1
[[ `grep -c "^$host" $payload` -ne 1 ]] &&!echo -e "${cor[5]}$(fun_trans ${id} "Host Nao Encontrada")" && return 1
grep -v "^$host" $payload > /tmp/a && mv /tmp/a $payload
echo -e "${cor[4]}$(fun_trans ${id} "Host Removida Com Sucesso")${cor[0]}\n$barra"
cat $payload | awk -F "/" '{print $1,$2,$3,$4}'
echo -e "$barra"
if [[ ! -f "/etc/init.d/squid" ]]; then
service squid3 reload
service squid3 restart
else
/etc/init.d/squid reload
service squid restart
fi	
return 0
elif [[ "$varpay" = "3" ]]; then
fun_squid
fi
}
if [[ -e /etc/squid/squid.conf ]]; then
online_squid
elif [[ -e /etc/squid3/squid.conf ]]; then
online_squid
else
fun_squid
fi
