<?php
/**
 * mailer.php - sends email through Brevo's HTTPS API (port 443).
 * Railway Free/Hobby blocks SMTP ports (25/465/587), so PHPMailer/Gmail
 * cannot work there. This keeps the same function names, so login.php,
 * forgot-password.php and api.php do not need changes.
 *
 * Railway Variables needed:
 *   BREVO_API_KEY   (Brevo -> SMTP & API -> API Keys -> Generate)
 *   MAIL_FROM       (a sender you verified in Brevo -> Senders)
 *   MAIL_FROM_NAME  (optional, default "Camp Mayagay")
 */

declare(strict_types=1);

function mayagaySendMail(string $toEmail, string $subject, string $html, string $text, ?string &$errorOut = null): bool
{
    $apiKey   = getenv('BREVO_API_KEY') ?: '';
    $from     = getenv('MAIL_FROM') ?: '';
    $fromName = getenv('MAIL_FROM_NAME') ?: 'Camp Mayagay';

    if ($apiKey === '' || $from === '') {
        $errorOut = 'BREVO_API_KEY or MAIL_FROM is not set.';
        return false;
    }

    $payload = json_encode([
        'sender'      => ['name' => $fromName, 'email' => $from],
        'to'          => [['email' => $toEmail]],
        'subject'     => $subject,
        'htmlContent' => $html,
        'textContent' => $text,
    ]);

    $ch = curl_init('https://api.brevo.com/v3/smtp/email');
    curl_setopt_array($ch, [
        CURLOPT_POST           => true,
        CURLOPT_POSTFIELDS     => $payload,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_CONNECTTIMEOUT => 5,
        CURLOPT_TIMEOUT        => 10,
        CURLOPT_HTTPHEADER     => [
            'accept: application/json',
            'content-type: application/json',
            'api-key: ' . $apiKey,
        ],
    ]);
    $response = curl_exec($ch);
    $status   = (int)curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlErr  = curl_error($ch);
    curl_close($ch);

    if ($response === false) {
        $errorOut = 'cURL error: ' . $curlErr;
        return false;
    }
    if ($status < 200 || $status >= 300) {
        $errorOut = 'Brevo HTTP ' . $status . ': ' . $response;
        return false;
    }
    return true;
}

function sendVerificationEmail(string $toEmail, string $code, ?string &$errorOut = null): bool
{
    $html =
        '<p>Your Camp Mayagay verification code is:</p>' .
        '<h2 style="letter-spacing:6px;">' . htmlspecialchars($code) . '</h2>' .
        '<p>This code expires in 10 minutes. If you did not request this, you can safely ignore this email.</p>';
    $text = "Your Camp Mayagay verification code is: {$code}\nThis code expires in 10 minutes.";
    return mayagaySendMail($toEmail, 'Camp Mayagay - Verification Code', $html, $text, $errorOut);
}

function sendNotificationEmail(string $toEmail, string $subject, string $message, ?string &$errorOut = null): bool
{
    $html =
        '<p>' . nl2br(htmlspecialchars($message)) . '</p>' .
        '<p style="color:#888; font-size:12px; margin-top:24px;">This message was sent by Camp Mayagay.</p>';
    return mayagaySendMail($toEmail, $subject, $html, $message, $errorOut);
}
