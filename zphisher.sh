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
##    de software. Os estado
