<?php
    // Include db connection
    require "database.php";

    // get all categories
    $sql = "
        SELECT id, name 
        FROM 
        categories
    ";
    $result = $conn->query($sql);


    $categories = [];

    // Loop through each row in the result
    while ($row = $result->fetch_assoc()) {
        // Add id and name of cat to the array
        $categories[] = [
            "id" => $row["id"],
            "name" => $row["name"]
        ];
    }

    // Convert the array to JSON and send it to the browser
    echo json_encode($categories);
?>
