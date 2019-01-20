<?php

$req = array('POST' => $_POST, 'GET' => $_GET, 'HEADERS' => getallheaders());

echo json_encode($req);

?>