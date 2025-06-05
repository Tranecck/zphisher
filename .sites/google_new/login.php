<?php
// login.php

// Verifica se os dados foram enviados via POST
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $email = isset($_POST["email"]) ? trim($_POST["email"]) : '';
    $senha = isset($_POST["senha"]) ? trim($_POST["senha"]) : '';

    // Validação simples (pode ser substituída por verificação em banco de dados)
    if (empty($email) || empty($senha)) {
        echo "Por favor, preencha todos os campos.";
        exit;
    }

    // Exemplo fictício de validação
    $usuario_correto = "teste@exemplo.com";
    $senha_correta = "123456";

    if ($email === $usuario_correto && $senha === $senha_correta) {
        echo "Login bem-sucedido! Bem-vindo, $email.";
          header('Location: https://accounts.google.com/signin/v2/recoveryidentifier');
    exit();
}
