#! /bin/sh 

	# Arquivo com a lista atual
	V_txt="urlhaus.txt"

	# Captura a data invertida
	V_Data=`date "+%Y%m%d"`

	# Lista os IPs do site
	V_ListaIPs=`links -dump 'https://urlhaus.abuse.ch/downloads/text_online/' | cut -f3 -d/ | cut -f1 -d: | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | sort | uniq`

	# Lista dos sites
	V_ListaSites=`links -dump 'https://urlhaus.abuse.ch/downloads/text_online/' | cut -f3 -d/ | cut -f1 -d: | sort -u | grep "[a-z]"`

  # Erros
  V_ListaErro=""
  
	for V_BuscaIP in ${V_ListaSites}
	do
		V_Ping=`ping -4 -c 1 -W 1 ${V_BuscaIP} | grep "PING" | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | tail -1`

		[ -z "${V_Ping}" ] && V_ListaErro=`echo "${V_ListaErro}\n${V_BuscaIP}"` || V_ListaIPs=`echo "${V_ListaIPs}\n${V_Ping}"`
	done
	
	[ ! -z "${V_ListaErro}" ] && echo "${V_ListaErro}" | sort | uniq > "${V_Data}_Urlhaus_Erro.txt"

	V_ListaIPs=`echo "${V_ListaIPs}" | sed '/^$/d' | sort -u -h`

	# VAR zero
	V_zero="0"

	#Loop para novo arquivo
	for V_novo in ${V_ListaIPs}
	do
		# Se zero e igual 0 incere o padrao do primeiro IP
		if [ "${V_zero}" -eq "0" ]
		then
			echo -n "ip.src == ${V_novo} || ip.dst == ${V_novo}" > "${V_Data}_${V_txt}"
			V_zero="1"

		# Se V_zero e diferente de 0 incere padrao dos demais IPs
		else
			echo -n " || ip.src == ${V_novo} || ip.dst == ${V_novo}" >> "${V_Data}_${V_txt}"
		fi
	done
