<?php
$ipaddress = exec("ifconfig eth0 | awk '/inet addr/ {split ($2,A,\":\"); print A[2]}'");
header( 'Location: http://'.$ipaddress ) ;
?>