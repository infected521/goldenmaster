#!/bin/bash
#  GENERADOR MASTER
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/
clear

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

#cabecera
txt1="  GENERADOR MASTER"
txt2="LA CASITA"
txt2_1=" DEL TERROR"
txt3="  INSTALACIONES"
txt4=""
txt5=""
#colores
fg_black="$(tput setaf 0)"
fg_red="$(tput setaf 1)"
fg_green="$(tput setaf 2)"
fg_yellow="$(tput setaf 3)"
fg_blue="$(tput setaf 4)" 
fg_magenta="$(tput setaf 5)" 
fg_cyan="$(tput setaf 6)"
fg_white="$(tput setaf 7)"
reset="$(tput sgr0)"

BASICINST="menu PGet.py ports.sh ADMbot.sh message.txt usercodes sockspy.sh POpen.py PPriv.py PPub.py PDirect.py speedtest.py speed.sh utils.sh dropbear.sh apacheon.sh openvpn.sh shadowsocks.sh ssl.sh squid.sh anti-ddos.sh un-ddos.sh dados.sh fai2ban.sh paysnd.sh ultrahost gestor.sh USUARIO-DEMO v2ray.sh ssrrmu.sh toolmaster.py optimizar.sh"
IVAR="/etc/http-instas"
BARRA="${fg_blue}----------------------------------------------------${reset}"

echo -e "$BARRA"

echo -e "${fg_yellow}\t\t$txt1${reset}"          
echo -e "\e[1;${fg_red}\t\t $txt2 ${fg_blue}$txt2_1${reset}"         
echo -e "\e[3;${fg_cyan}\t\t$txt3: $(cat $IVAR)${reset}"        

SCPT_DIR="/etc/SCRIPT"
[[ ! -e ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
INSTA_ARQUIVOS="ADMVPS.zip"
DIR="/etc/http-shell"
LIST="lista-arq"
meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}
fun_list () {
rm ${SCPT_DIR}/*.x.c &> /dev/null
unset KEY
KEY="$1"
#CRIA DIR
[[ ! -e ${DIR} ]] && mkdir ${DIR}
#ENVIA ARQS
i=0
VALUE+="gerar.sh instgerador.sh http-server.py $BASICINST"
for arqx in `ls ${SCPT_DIR}`; do
[[ $(echo $VALUE|grep -w "${arqx}") ]] && continue 
echo -e "[$i] -> ${arqx}"
arq_list[$i]="${arqx}"
let i++
done
echo -e "[x] -> GENERADOR DE KEY"
echo -e "[b] -> SCRIPT GOLDEN ADM"

read -p "Seleccione su instalacion: " readvalue
#CRIA KEY
[[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
#PASSA ARQS
[[ -z $readvalue ]] && readvalue="b"
read -p "NOMBRE DE USUARIO ( QUIEN USARA LA KEY ): " nombrevalue
[[ -z $nombrevalue ]] && nombrevalue="unnamed"
read -p "Key Fija? [S/N]: " -e -i n fixakey
[[ $fixakey = @(s|S|y|Y) ]] && read -p "IP-Fija[IP para randomizar]: " IPFIX && nombrevalue+=[FIXA]
if [[ $readvalue = @(b|B) ]]; then
#ADM BASIC
 arqslist="$BASICINST"
 for arqx in `echo "${arqslist}"`; do
 [[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
[[ ${arqx#*.} != "py" ]] && [[ ${arqx#*.} != "txt" ]] && shc -r -f ${SCPT_DIR}/$arqx -o ${DIR}/${KEY}/$arqx || cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/ &> /dev/null
 echo "$arqx" >> ${DIR}/${KEY}/${LIST}
 done
elif [[ $readvalue = @(x|X) ]]; then
#FULL ARQS
[[ $(echo $nombrevalue|grep -w "FIXA") ]] && nombrevalue+=[GERADOR]
 for arqx in `ls $SCPT_DIR`; do
  [[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
[[ ${arqx#*.} != "py" ]] && [[ ${arqx#*.} != "txt" ]] && shc -r -f ${SCPT_DIR}/$arqx -o ${DIR}/${KEY}/$arqx || cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/ &> /dev/null
 echo "$arqx" >> ${DIR}/${KEY}/${LIST}
 done
else
 for arqx in `echo "${readvalue}"`; do
 #UNE ARQ
 [[ -e ${DIR}/${KEY}/${arq_list[$arqx]} ]] && continue #ANULA ARQUIVO CASO EXISTA
 rm ${SCPT_DIR}/*.x.c &> /dev/null
[[ ${arqx#*.} != "py" ]] && [[ ${arqx#*.} != "txt" ]] && shc -r -f ${SCPT_DIR}/$arqx -o ${DIR}/${KEY}/$arqx || cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/ &> /dev/null
 echo "$arqx" >> ${DIR}/${KEY}/${LIST}
 done
echo "TRUE" >> ${DIR}/${KEY}/HERRAMIENTA
fi
rm ${SCPT_DIR}/*.x.c &> /dev/null
echo "$nombrevalue" > ${DIR}/${KEY}.name
[[ ! -z $IPFIX ]] && echo "$IPFIX" > ${DIR}/${KEY}/keyfixa
echo -e "$BARRA"
echo -e "Key Activa, esperando a ser Instalada!"
echo -e "$BARRA"
}
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
goldentext () {
#!/bin/bash
ijo='\e[33m'
checkdepeden(){
	cekdep=$(dpkg -l | grep -o 'curl\|grep' | uniq)
	if [[ ! $cekdep =~ "curl" ]]
	then
		sudo apt install curl -y 2>/dev/null
		#for termux
		apt install curl -y 2>/dev/null
		elif [[ ! $cekdep =~ "grep" ]]
			then
				sudo apt install grep -y 2>/dev/null
				#termux
				apt install grep -y 2>/dev/null
	fi
}
checkdepeden
#intro
printf "${ijo} ██████╗  ██████╗ ██╗     ██████╗ ███████╗███╗   ██╗
██╔════╝ ██╔═══██╗██║     ██╔══██╗██╔════╝████╗  ██║
██║  ███╗██║   ██║██║     ██║  ██║█████╗  ██╔██╗ ██║
██║   ██║██║   ██║██║     ██║  ██║██╔══╝  ██║╚██╗██║
╚██████╔╝╚██████╔╝███████╗██████╔╝███████╗██║ ╚████║
 ╚═════╝  ╚═════╝ ╚══════╝╚═════╝ ╚══════╝╚═╝  ╚═══╝
"|lolcat
}
gerar_key () {
valuekey="$(date | md5sum | head -c10)"
valuekey+="$(echo $(($RANDOM*10))|head -c 5)"
fun_list "$valuekey"
keyfinal=$(ofus "$IP:8888/$valuekey/$LIST")
echo -e "KEY: $keyfinal\nGenerada!"
echo -e "$BARRA"
read -p "Enter to Finalizar"
}
att_gen_key () {
i=0
rm ${SCPT_DIR}/*.x.c &> /dev/null
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
echo "[$i] Retornar"
keys="$keys retorno"
let i++
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
arqsx=$(ofus "$IP:8888/$arqs/$LIST")
if [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then
echo -e "\033[1;31m[$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;32m ($(cat ${DIR}/${arqs}/keyfixa))\033[0m"
keys="$keys $arqs"
let i++
fi
done
keys=($keys)
echo -e "$BARRA"
while [[ -z ${keys[$value]} || -z $value ]]; do
read -p "Escoja cual actualizar[t=todos]: " -e -i 0 value
done
[[ $value = 0 ]] && return
if [[ $value = @(t|T) ]]; then
i=0
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
KEYDIR="$DIR/$arqs"
rm $KEYDIR/*.x.c &> /dev/null
 if [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then #Keyen Atualiza
 rm ${KEYDIR}/${LIST}
   for arqx in `ls $SCPT_DIR`; do
    [[ ${arqx#*.} != "py" ]] && [[ ${arqx#*.} != "txt" ]] && rm ${KEYDIR}/$arqx && shc -r -f ${SCPT_DIR}/$arqx -o ${KEYDIR}/$arqx || cp ${SCPT_DIR}/$arqx ${KEYDIR}/$arqx &> /dev/null
    echo "${arqx}" >> ${KEYDIR}/${LIST}
    rm ${SCPT_DIR}/*.x.c &> /dev/null
    rm $KEYDIR/*.x.c &> /dev/null
   done
 arqsx=$(ofus "$IP:8888/$arqs/$LIST")
 echo -e "\033[1;33m[KEY]: $arqsx \033[1;32m(ACTUALIZADA!)\033[0m"
 fi
let i++
done
rm ${SCPT_DIR}/*.x.c &> /dev/null
echo -e "$BARRA"
echo -ne "\033[0m" && read -p "Enter"
return 0
fi
KEYDIR="$DIR/${keys[$value]}"
[[ -d "$KEYDIR" ]] && {
rm $KEYDIR/*.x.c &> /dev/null
rm ${KEYDIR}/${LIST}
  for arqx in `ls $SCPT_DIR`; do
  [[ ${arqx#*.} != "py" ]] && [[ ${arqx#*.} != "txt" ]] && rm ${KEYDIR}/$arqx && shc -r -f ${SCPT_DIR}/$arqx -o ${KEYDIR}/$arqx || cp ${SCPT_DIR}/$arqx ${KEYDIR}/$arqx &> /dev/null
  echo "${arqx}" >> ${KEYDIR}/${LIST}
  rm ${SCPT_DIR}/*.x.c &> /dev/null
  rm $KEYDIR/*.x.c &> /dev/null
  done
 arqsx=$(ofus "$IP:8888/${keys[$value]}/$LIST")
 echo -e "\033[1;33m[KEY]: $arqsx \033[1;32m(ACTUALIZADA!)\033[0m"
 read -p "Enter"
 rm ${SCPT_DIR}/*.x.c &> /dev/null
 }
}
remover_key () {
i=0
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
echo "[$i] Retornar"
keys="$keys retorno"
let i++
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
arqsx=$(ofus "$IP:8888/$arqs/$LIST")
if [[ $(cat ${DIR}/${arqs}.name|grep -v GERADOR|grep FIXA) ]]; then
echo -e "\033[1;33m[$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;32m ($(cat ${DIR}/${arqs}/keyfixa))\033[0m"
elif [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then
echo -e "\033[1;31m[$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;32m ($(cat ${DIR}/${arqs}/keyfixa))\033[0m"
else
echo -e "[$i] $arqsx ($(cat ${DIR}/${arqs}.name))"
fi
keys="$keys $arqs"
let i++
done
keys=($keys)
echo -e "$BARRA"
while [[ -z ${keys[$value]} || -z $value ]]; do
read -p "Escoja Cual Remover: " -e -i 0 value
done
[[ -d "$DIR/${keys[$value]}" ]] && rm -rf $DIR/${keys[$value]}* || return
}
atualizar_keyfixa () {
i=0
rm ${SCPT_DIR}/*.x.c &> /dev/null
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
 if [[ $(cat ${DIR}/${arqs}.name|grep -v GERADOR|grep FIXA) ]]; then #Keyfixa Atualiza
   for arqx in `echo "${BASICINST}"`; do
    cp ${SCPT_DIR}/$arqx ${DIR}/${arqs}/$arqx &> /dev/null
    rm ${SCPT_DIR}/*.x.c &> /dev/null
    rm $KEYDIR/*.x.c &> /dev/null
   done
 arqsx=$(ofus "$IP:8888/$arqs/$LIST")
 echo -e "\033[1;33m[KEY]: $arqsx \033[1;32m(ATUALIZADA!)\033[0m"
 fi
let i++
done
rm ${SCPT_DIR}/*.x.c &> /dev/null
echo -e "$BARRA"
echo -ne "\033[0m" && read -p "Enter"
}
start_gen () {
PIDGEN=$(ps x|grep -v grep|grep "http-server.sh")
if [[ ! $PIDGEN ]]; then
screen -dmS generador /bin/http-server.sh -start
else
killall http-server.sh
fi
}
message_gen () {
read -p "NEW MESSAGE: " MSGNEW
echo "$MSGNEW" > ${SCPT_DIR}/message.txt
echo -e "$BARRA"
}
update_master () {
printf "\n\t\t$red ACTUALIZADOR MASTER\n\n$srt"
fun_bar '$(rm /etc/SCRIPT/*)'
fun_bar 'apt install update -y'
fun_bar 'apt install upgrade -y'
fun_bar '$(wget https://www.dropbox.com/s/9dz82l0lotrfvcv/master.sh)> /dev/null 2>&1'
fun_bar '$(chmod 755 master.sh > /dev/null 2>&1)'
fun_bar '$(./master.sh > /dev/null 2>&1)'
printf "\n\n\t$red ACTUALIZACION EXITOSA$rst"
}

rmv_iplib () {
echo -e "SERVIDORES DE KEY ACTIVOS!"
rm /var/www/html/newlib && touch /var/www/html/newlib
rm ${SCPT_DIR}/*.x.c &> /dev/null
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
if [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then
var=$(cat ${DIR}/${arqs}.name)
ip=$(cat ${DIR}/${arqs}/keyfixa)
echo -ne "\033[1;31m[USUARIO]:(\033[1;32m${var%%[*}\033[1;31m) \033[1;33m[GERADOR]:\033[1;32m ($ip)\033[0m"
echo "$ip" >> /var/www/html/newlib && echo -e " \033[1;36m[ACTUALIZADO]"
fi
done

echo -e "$BARRA"
read -p "Enter"
}
meu_ip
unset PID_GEN
PID_GEN=$(ps x|grep -v grep|grep "http-server.sh")
[[ ! $PID_GEN ]] && PID_GEN="\033[1;31moff" || PID_GEN="\033[1;32monline"
echo -e "$BARRA"
echo -e "\033[1;31m           La distinción entre el pasado
       presente y futuro es sólo una ilusión
            obstinadamente persistente \033[0m"
echo -e "$BARRA"
echo -e "[1] = GENERAR 1 KEY ALEATORIA"
echo -e "[2] = APAGAR/BORRAR KEYS"
echo -e "[3] = START/STOP KEYGEN $PID_GEN\033[0m"
echo -e "[4] = VER REGISTRO"
echo -e "[5] = CAMBIAR MENSAJE"
echo -e "[6] = ACTUALIZAR KEYS FIJA"
echo -e "[7] = ACTUALIZAR KEYS GENERADOR"
echo -e "[8] = ACTUALIZAR IPS GENERADOR"
echo -e "[9] = ACTUALIZAR GENERADOR"
echo -e "[0] = SALIR"
echo -e "$BARRA"
while [[ ${varread} != @([0-9]) ]]; do
read -p "Opcao: " varread
done
echo -e "$BARRA"
if [[ ${varread} = 1 ]]; then
gerar_key
elif [[ ${varread} = 2 ]]; then
remover_key
elif [[ ${varread} = 3 ]]; then
start_gen
read -p "Enter"
elif [[ ${varread} = 4 ]]; then
echo -ne "\033[1;36m"
cat /etc/gerar-sh-log
echo -ne "\033[0m" && read -p "Enter"
elif [[ ${varread} = 5 ]]; then
message_gen
elif [[ ${varread} = 6 ]]; then
atualizar_keyfixa
elif [[ ${varread} = 7 ]]; then
att_gen_key
elif [[ ${varread} = 8 ]]; then
rmv_iplib
elif [[ ${varread} = 9 ]]; then
update_master
elif [[ ${varread} = 0 ]]; then
exit 0
fi
/usr/bin/master.sh
