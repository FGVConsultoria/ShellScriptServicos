#! /bin/sh

##################################
# Diretorios
##################################
V_Dir="./Feodotracker"

##################################
# Se diretorio não existir cria
##################################
[ ! -d "${V_Dir}" ] && mkdir "${V_Dir}"

##################################
# Variavies do script
##################################
V_txt4="${V_Dir}/FeodotrackerV4.txt"
V_msn="${V_Data} - Feodotracker"
V_mailto="to@mail.net"
V_Data=`date "+%Y%m%d"`
V_DT=`date "+%Y"`

##################################
# Funções
##################################
F_grep_ipv4(){
	grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | sort -h | uniq
}

F_Feodotracker(){
	links -ssl.certificates 0 -dump "https://feodotracker.abuse.ch/downloads/ipblocklist.txt"
}

##################################
# Executa rotinas
##################################

F_Feodotracker | tr " " "\n" | F_grep_ipv4 | awk '{print "ip.src == "$1"\n|| ip.dst == "$1"\n||"}' | sed '$d' | tr "\n" " " > "${V_txt4}"

echo "Dados IPV4 para inclusão nos filtros do hunting de malware ..." | mutt -a "${V_txt4}" -s "${V_msn}" -- "${V_mailto}"

