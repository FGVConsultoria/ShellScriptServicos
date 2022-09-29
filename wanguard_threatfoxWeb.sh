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
V_txt4="${V_Dir}/threatfoxWeb4.txt"
V_msn="${V_Data} - THREATFOX"
V_mailto="to@mail.net"
V_Data=`date "+%Y%m%d"`
V_DT=`date "+%Y"`

##################################
# Funções
##################################
F_grep_ipv4(){
	grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | sort -h | uniq
}

F_ThreatfoxWeb(){
        links -ssl.certificates 0 -dump "https://threatfox.abuse.ch/browse/"
}

##################################
# Executa rotinas
##################################

F_ThreatfoxWeb | awk '($2 != "" ) {print $2}' | F_grep_ipv4 | awk '(NR == 1) {printf "dst ip "$1} ; (NR > 1) {printf " or dst ip "$1}' > "${V_txt4}_"


V_Dom=`F_ThreatfoxWeb | awk '($2 != "" ) {print $2}' | grep "http.://" | cut -f3 -d/ | grep -vE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | cut -f1 -d: | sort -h | uniq`

for V_BuscaIP in ${V_Dom}
do
       ping -c 1 -W 1 -4 ${V_BuscaIP} | grep "PING" | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | tail -1 >> "${V_txt4}_"
done

sort -h "${V_txt4}_" | sed '/^$/d' | sort -h | uniq | awk 'BEGIN { printf "dst ip "} {printf $1 " or ip "}' | sed 's/\ or\ ip\ $//' > "${V_txt4}"

rm -f "${V_txt4}_"

echo "Dados IPV4 para inclusão nos filtros do WanGuard ..." | mutt -a "${V_txt4}" -s "${V_msn}" -- "${V_mailto}"
