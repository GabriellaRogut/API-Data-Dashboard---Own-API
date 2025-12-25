<?php
    require "database.php";

    // Get request method (GET, POST, PUT, DELETE)
    $method = $_SERVER['REQUEST_METHOD'];

    // Read JSON input for POST and PUT requests ("get data from a json body")
    $input = json_decode(file_get_contents("php://input"), true);

    switch ($method) {
        // --------------------------
        // GET
        // --------------------------
        case "GET":
            $sql = "SELECT products.*, categories.name AS category 
                    FROM products
                    JOIN categories ON products.categoryId = categories.id";

            // In case of an ID
            if (isset($_GET["id"])) {
                $id = (int)$_GET["id"];
                $sql .= " WHERE products.id = $id";
            }

            // In case of a LIMIT
            elseif (isset($_GET["limit"])) {
                $limit = (int)$_GET["limit"];
                $sql .= " LIMIT $limit";
            }

            $result = $conn->query($sql);

            // ERROR 404 if nothing with such ID found
            if (isset($_GET["id"]) && $result->num_rows === 0) {
                http_response_code(404);
                echo json_encode(["error" => "Product not found"]);
                exit;
            }

            $products = [];
            while ($row = $result->fetch_assoc()) {
                $products[] = [
                    "id" => $row["id"],
                    "title" => $row["title"],
                    "price" => (float)$row["price"],
                    "description" => $row["description"],
                    "category" => [
                        "id" => $row["categoryId"],
                        "name" => $row["category"]
                    ],
                    "images" => [$row["image"]]
                ];
            }

            echo json_encode($products);
            break;


        // --------------------------
        // CREATE PRODUCT (POST)
        // --------------------------
        case "POST":
            $required = ["title", "price", "description", "categoryId", "images"];

            // If not all required fields are given - ERROR
            foreach ($required as $field) {
                if (!isset($input[$field])) {
                    http_response_code(404);
                    echo json_encode(["error" => "Missing field: $field"]);
                    exit;
                }
            }

            $title = $input["title"];
            $price = $input["price"];
            $description = $input["description"];
            $categoryId = $input["categoryId"];
            $image = $input["images"][0];


            $stmt = $conn->prepare("
                INSERT INTO products (title, price, description, categoryId, image)
                VALUES (?, ?, ?, ?, ?)
            ");
            $stmt->bind_param("sdsss", $title, $price, $description, $categoryId, $image);

            // Check for DB error
            if (!$stmt->execute()) {
                http_response_code(500);
                echo json_encode(["error" => "DB error"]);
                exit;
            }
            http_response_code(201); // Created successfully

            echo json_encode([
                "id" => $stmt->insert_id,
                "title" => $title,
                "price" => $price,
                "description" => $description,
                "categoryId" => $categoryId,
                "images" => [$image]
            ]);
            break;


        // --------------------------
        // UPDATE PRODUCT (PUT)
        // --------------------------
        case "PUT":
            // Check if ID is provided
            if (!isset($_GET["id"])) {
                http_response_code(404);
                echo json_encode(["error" => "Product ID missing"]);
                exit;
            }

            $id = (int)$_GET["id"];

            $res = $conn->query("
                SELECT * 
                FROM products 
                WHERE id = $id
            ");

            // Check if product exists
            if ($res->num_rows === 0) {
                http_response_code(404);
                echo json_encode(["error" => "Product not found"]);
                exit;
            }

            $product = $res->fetch_assoc();

            // Get input data from JSON
            $title = $input["title"] ?? $product["title"];
            $price = $input["price"] ?? $product["price"];
            $description = $input["description"] ?? $product["description"];
            $categoryId = $input["category"]["id"] ?? $input["categoryId"] ?? $product["categoryId"];
            $image = $input["images"][0] ?? $product["image"];

            // Validation
            if (empty($title) || empty($description) || empty($image) || $price <= 0) {
                http_response_code(400);
                echo json_encode(["error" => "Invalid or missing fields"]);
                exit;
            }


            $stmt = $conn->prepare("
                UPDATE products
                SET title = ?, price = ?, description = ?, categoryId = ?, image = ?
                WHERE id = ?
            ");
            $stmt->bind_param("sdsssi", $title, $price, $description, $categoryId, $image, $id);

            // Check for DB error
            if (!$stmt->execute()) {
                http_response_code(500);
                echo json_encode(["error" => "DB error"]);
                exit;
            }

            // Return updated product
            http_response_code(200);
            echo json_encode([
                "id" => $id,
                "title" => $title,
                "price" => $price,
                "description" => $description,
                "category" => ["id" => $categoryId],
                "images" => [$image]
            ]);
            break;



        // --------------------------
        // DELETE PRODUCT
        // --------------------------
        case "DELETE":
            // Check if ID is provided
            if (!isset($_GET["id"])) {
                http_response_code(404);
                echo json_encode(["error" => "Product ID missing"]);
                exit;
            }

            $id = (int)$_GET["id"];

            // Check if product exists
            $res = $conn->query("SELECT * FROM products WHERE id = $id");
            if ($res->num_rows === 0) {
                http_response_code(404);
                echo json_encode(["error" => "Product not found"]);
                exit;
            }


            $stmt = $conn->prepare("DELETE FROM products WHERE id = ?");
            $stmt->bind_param("i", $id);

            // Check for DB error
            if (!$stmt->execute()) {
                http_response_code(500);
                echo json_encode(["error" => "DB error"]);
                exit;
            }

            http_response_code(200);
            echo json_encode(["success" => true]);
            break;


        // --------------------------
        // INVALID METHOD
        // --------------------------
        default:
            echo json_encode(["error" => "Invalid request method"]);
    }
?>
