#! /bin/sh

##################################
# Diretorios
##################################
V_Dir="/opt/WanGuard"

##################################
# Se diretorio não existir cria
##################################
[ ! -d "${V_Dir}" ] && mkdir "${V_Dir}"

cd "${V_Dir}"

##################################
# Variavies do script
##################################
V_txt="${V_Dir}/opennic.txt"
V_msn="${V_Data} - OPENNIC"
V_mailto="to@email.com"
V_Data=`date "+%Y%m%d"`
V_DT=`date "+%Y"`

##################################
# Funções
##################################
F_grep_ipv4(){
	grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | sort -h | uniq
}

F_grep_ipv6(){
	grep -oE '(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))' | sort -h | uniq
}

F_Opennic(){
	links -ssl.certificates 0 -dump "https://servers.opennic.org/?tier=1"
	links -ssl.certificates 0 -dump "https://servers.opennic.org/?tier=2"
}

##################################
# Executa rotinas
##################################

F_Opennic | F_grep_ipv4 | awk '(NR == 1) {printf "dst ip "$1} ; (NR > 1) {printf " or dst ip "$1}' > "${V_txt}"

echo "Dados IPV4 para inclusão nos filtros do WanGuard ..." | mutt -a "${V_txt}" -s "${V_msn}" -- "${V_mailto}"

rm -f "${V_txt}"

F_Opennic | F_grep_ipv6 | uniq | awk '(NR == 1) {printf "dst ip "$1} ; (NR > 1) {printf " or dst ip "$1}' > "${V_txt}"

echo "Dados IPV6 para inclusão nos filtros do WanGuard ..." | mutt -a "${V_txt}" -s "${V_msn}" -- "${V_mailto}"

rm -f "${V_txt}"

cd -
