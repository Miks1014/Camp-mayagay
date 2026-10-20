<?php
// router.php: used by PHP's built-in server on Railway.

$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$path = rawurldecode($path);

// Never serve these: database dumps, source folders, hidden files
if (preg_match('#^/(database|java|PHPMailer)(/|$)#i', $path)
    || preg_match('#/\.#', $path)
    || preg_match('#\.(sql|md|java|log|env|ini|bak)$#i', $path)
    || in_array($path, ['/Dockerfile', '/router.php'], true)) {
    http_response_code(404);
    echo 'Not found';
    return true;
}

// Home page = login
if ($path === '/' || $path === '/index.html' || $path === '/index.php') {
    readfile(__DIR__ . '/Login.html');
    return true;
}

// Let the server handle real files (html, css, js, images, php)
return false;
