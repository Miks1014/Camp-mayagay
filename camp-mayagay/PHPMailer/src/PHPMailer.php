<?php
// php/mailer.php
// SMTP credentials are read from Railway environment variables.
// Never write the Gmail password in this file.

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

// Adjust this path to where PHPMailer lives in your project.
// If you installed it with Composer, use the vendor autoload line.
require_once __DIR__ . '/../vendor/autoload.php';

function sendMail(string $toEmail, string $toName, string $subject, string $htmlBody): bool
{
    $smtpUser = getenv('SMTP_USER');
    $smtpPass = getenv('SMTP_PASSWORD');
    $smtpHost = getenv('SMTP_HOST') ?: 'smtp.gmail.com';
    $smtpPort = (int) (getenv('SMTP_PORT') ?: 587);
    $fromName = getenv('SMTP_FROM_NAME') ?: 'Camp Mayagay';

    if (!$smtpUser || !$smtpPass) {
        error_log('Mailer: SMTP_USER or SMTP_PASSWORD is not set.');
        return false;
    }

    $mail = new PHPMailer(true);

    try {
        $mail->isSMTP();
        $mail->Host       = $smtpHost;
        $mail->SMTPAuth   = true;
        $mail->Username   = $smtpUser;
        $mail->Password   = $smtpPass;
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port       = $smtpPort;

        $mail->setFrom($smtpUser, $fromName);
        $mail->addAddress($toEmail, $toName);

        $mail->isHTML(true);
        $mail->Subject = $subject;
        $mail->Body    = $htmlBody;
        $mail->AltBody = strip_tags($htmlBody);

        $mail->send();
        return true;
    } catch (Exception $e) {
        // Log the real reason to Railway Deploy Logs, never show it to the user.
        error_log('Mailer error: ' . $mail->ErrorInfo);
        return false;
    }
}
