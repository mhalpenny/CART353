<?php
$post_data = $_POST['stringData'];
$myfile = fopen("poem.txt", "w") or die("Unable to open file!");
fwrite($myfile,$post_data);
fclose($myfile);
?>
