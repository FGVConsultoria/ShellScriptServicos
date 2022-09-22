#!/bin/sh

echo -n "Qual a rede : " ; read V_Rede
if [ ! "${V_Rede}" ]
then
	echo "Informar a rede !"
	exit
fi

V_sub=`echo "${V_Rede}" | cut -f2 -d"/"`
if [ ! "${V_sub}" ]
then
        echo "Informar a subrede !"
        exit
fi

V_sub=`echo "${V_sub} + 1" | bc | sed 's/\ //g'`

echo -n "Descricao : " ; read V_desc
if [ ! "${V_desc}" ]
then
        echo "Informar a descricao !"
        exit
fi

echo -n "AS da range de IPs : AS" ; read V_as
if [ ! "${V_as}" ]
then
        echo "Informar o AS !"
        exit
fi

echo "${V_Rede}" | grep ":" 1>/dev/null 2>/dev/null
if [ "${?}" -eq "0" ]
then
	V_ipv46="6"
	V_subf="48"
else
	V_ipv46="4"
	V_subf="24"
fi

while [ "${V_sub}" -le "${V_subf}" ]
do
	V_dest=`echo "${V_desc} ${V_Rede} ${V_sub}" | sed 's/\./_/g;s/\//_/g;s/\ /_/g'`
	sipcalc -S -"${V_ipv46}" "${V_Rede}" --v${V_ipv46}split="${V_sub}" | awk -v V_sub="${V_sub}" -v V_desc="${V_desc}" -v V_as="${V_as}" '$1 ~ /Network/ {print " route:",$3"/"V_sub"\n","descr:",V_desc"\n","origin:","AS"V_as"\n"}' > "${V_dest}.txt"
	V_sub=`echo "${V_sub} + 1" | bc | sed 's/\ //g'`
done
