Projeto voltado para arquivar os scripts desenvolvidos para serviços da rede.

1. Radb.sh - Milhares de organizações que operam redes de usar Mérito RADb para facilitar a operação da internet, incluindo provedores de serviços de internet, universidades, e empresas. O problema é a alimentação da base de dados, fiz este script para auxiliar o pessoal que vai inserir os dados na base.

2. wanguard_oppenic.sh - Cria o arquivo com os dados do site "https://servers.opennic.org" padronizado para os filtros do WanGuard, OpenNIC pode ser a solução para você, ao procurar uma aberta e democrática alternativa de raiz do DNS.

3. wanguard_threatfoxWeb.sh - Cria o arquivo com os dados do site "https://threatfox.abuse.ch" padronizado para os filtros do WanGuard, ThreatFox é uma plataforma livre de abuso.ch com o objetivo de compartilhar os indicadores de risco (IOCs) associados com malware com a comunidade de segurança da informação, AV fornecedores e ameaça de inteligência de fornecedores.

4. wanguard_feodotracker.sh - Cria o arquivo com os dados do site "https://feodotracker.abuse.ch" padronizado para os filtros do WanGuard, Feodo Tracker é um projecto de abuso.ch com o objetivo de compartilhar botnet C&C servidores associados com Dridex, Emotet (aka Heodo), TrickBot, QakBot (aka QuakBot / Qbot) e BazarLoader (aka BazarBackdoor). Ele oferece várias listas de bloqueio, ajudando os proprietários da rede para proteger seus usuários de Dridex e Emotet/Heodo.

5. wanguard_dshield.sh - Cria o arquivo com os dados do site "https://www.dshield.org" padronizado para os filtros do WanGuard, Dshield é uma lista de bloqueios recomendado, resume os top 20 origens de ataque a classe C (/24) e suas sub-redes nos últimos três dias.

6. wanguard_dan.sh - Cria o arquivo com os dados do site "https://www.dan.me.uk" padronizado para os filtros do WanGuard, DAN é uma lista completa tor node.

7. Feodotracker.sh - Cria o arquivo com os dados do site "https://feodotracker.abuse.ch/" Feodo Tracker é um projecto de abuso.ch com o objetivo de compartilhar botnet C&C servidores associados com Dridex, Emotet (aka Heodo), TrickBot, QakBot (aka QuakBot / Qbot) e BazarLoader (aka BazarBackdoor). Ele oferece várias listas de bloqueio, ajudando os proprietários da rede para proteger seus usuários de Dridex e Emotet/Heodo. 

8. urlhaus.sh - URLhaus (https://urlhaus.abuse.ch/) é um projeto do abuso.ch com o objetivo de compartilhar URLs maliciosos que estão sendo usados para a distribuição de malware. Desenvolvi o script para pegar a lista deste projeto e gerar um arquivo formatado para uso, os domínios que não forem identificados os IPs ele colocará no arquivo de erro que será gerado. O Arquivo com o formato das regras será salvo com o nome iniciado com a data : <YYYYMMDD>_urlhaus.txt e o arquivo com os domínios que não foram identificados os IPs no arquivo iniciado com a data : <YYYYMMDD>_Urlhaus_Erro.txt.
