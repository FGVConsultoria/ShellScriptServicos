#! /bin/sh

##################################
# Diretorios
##################################
V_Dir="./WanGuard"

##################################
# Se diretorio não existir cria
##################################
[ ! -d "${V_Dir}" ] && mkdir "${V_Dir}"

##################################
# Variavies do script
##################################
V_txt4="${V_Dir}/opennicV4.txt"
V_msn="${V_Data} - FEODOTRACKER"
V_mailto="to@mail.net"
V_Data=`date "+%Y%m%d"`
V_DT=`date "+%Y"`

##################################
# Funções
##################################
F_grep_ipv4(){
	grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | sort -h | uniq
}

F_Links(){
	links -ssl.certificates 0 -dump "https://feodotracker.abuse.ch/downloads/ipblocklist.txt"
}

##################################
# Executa rotinas
##################################

F_Links | F_grep_ipv4 | awk '(NR == 1) {printf "dst ip "$1} ; (NR > 1) {printf " or dst ip "$1}' > "${V_txt4}"

echo "Dados IPV4 para inclusão nos filtros do Feodotracker ..." | mutt -a "${V_txt4}" -s "${V_msn}" -- "${V_mailto}"
