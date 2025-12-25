<?php
    header("Access-Control-Allow-Origin: *"); // allows any website to access API
    header("Access-Control-Allow-Headers: Content-Type"); // tells the browser that the request can include the Content-Type header
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE"); // specifies which HTTP methods are allowed

    $host = "localhost";
    $user = "root";
    $pass = "";
    $dbname = "realEstateDB";

    $conn = new mysqli($host, $user, $pass, $dbname);

    if ($conn->connect_error) {
        die(json_encode(["error" => "Database connection failed"]));
    }
?>
