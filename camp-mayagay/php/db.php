<?php
declare(strict_types=1);

// Connection settings are read from environment variables.
// DB_* names take precedence; Railway's MYSQL* variables are accepted as aliases.
$DB_HOST = getenv('DB_HOST') ?: getenv('MYSQLHOST');
$DB_PORT = getenv('DB_PORT') ?: (getenv('MYSQLPORT') ?: '3306');
$DB_NAME = getenv('DB_NAME') ?: getenv('MYSQLDATABASE');
$DB_USER = getenv('DB_USER') ?: getenv('MYSQLUSER');
$DB_PASS = getenv('DB_PASS');
if ($DB_PASS === false) {
    $DB_PASS = getenv('MYSQLPASSWORD');
}
$DB_CHARSET = 'utf8mb4';

if (!$DB_HOST || !$DB_NAME || !$DB_USER || $DB_PASS === false) {
    http_response_code(500);
    die(json_encode([
        'success' => false,
        'message' => 'Database is not configured.'
    ]));
}

$dsn = "mysql:host={$DB_HOST};port={$DB_PORT};dbname={$DB_NAME};charset={$DB_CHARSET}";

$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

try {
    $pdo = new PDO($dsn, $DB_USER, $DB_PASS, $options);
} catch (PDOException $e) {
    http_response_code(500);
    die(json_encode([
        'success' => false,
        'message' => 'Database connection failed.'
    ]));
}
