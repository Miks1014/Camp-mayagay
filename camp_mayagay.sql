-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 17, 2026 at 09:53 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `camp_mayagay`
--

-- --------------------------------------------------------

--
-- Table structure for table `accommodations`
--

CREATE TABLE `accommodations` (
  `accommodation_id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(50) NOT NULL,
  `accommodation_name` varchar(150) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `type` enum('room','cabin','nipa','tent area') NOT NULL DEFAULT 'cabin',
  `capacity` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` enum('available','unavailable') NOT NULL DEFAULT 'available',
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accommodations`
--

INSERT INTO `accommodations` (`accommodation_id`, `slug`, `accommodation_name`, `description`, `type`, `capacity`, `price`, `status`, `image`, `created_at`, `updated_at`) VALUES
(1, 'nipa1', 'Nipa Hut 1', 'Traditional nipa hut, good for 1-2 pax', 'nipa', '1-2 pax', 2000.00, 'available', 'assets/images/nipa-hut.png', '2026-10-17 19:42:07', '2026-10-17 19:42:07'),
(2, 'nipa2', 'Nipa Hut 2', 'Traditional nipa hut, good for 1-2 pax', 'nipa', '1-2 pax', 2000.00, 'available', 'assets/images/nipa-hut.png', '2026-10-17 19:42:07', '2026-10-17 19:42:07'),
(3, 'glass', 'Glass Door', 'Glass door cabin, good for 1-2 pax', 'cabin', '1-2 pax', 2500.00, 'available', 'assets/images/glass-door.png', '2026-10-17 19:42:07', '2026-10-17 19:42:07'),
(4, 'tent', 'Tent Area', 'Open tent area, good for 1-2 pax', 'tent area', '1-2 pax', 250.00, 'available', 'assets/images/tent-area.png', '2026-10-17 19:42:07', '2026-10-17 19:42:07'),
(5, 'big1', 'Big House 1', 'Big house, good for 1-2 pax per room', 'room', '1-2 pax per room', 2500.00, 'available', 'assets/images/big-house.png', '2026-10-17 19:42:07', '2026-10-17 19:42:07'),
(6, 'big2', 'Big House 2', 'Big house, good for 1-2 pax per room', 'room', '1-2 pax per room', 2500.00, 'available', 'assets/images/big-house.png', '2026-10-17 19:42:07', '2026-10-17 19:42:07');

-- --------------------------------------------------------

--
-- Table structure for table `accommodation_favorites`
--

CREATE TABLE `accommodation_favorites` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `accommodation_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feedback_concerns`
--

CREATE TABLE `feedback_concerns` (
  `feedback_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `accommodation_id` int(10) UNSIGNED DEFAULT NULL,
  `guest_name` varchar(150) NOT NULL,
  `subject` varchar(150) NOT NULL,
  `message` text NOT NULL,
  `category` enum('feedback','concern') NOT NULL DEFAULT 'feedback',
  `rating` tinyint(3) UNSIGNED DEFAULT NULL,
  `response` text DEFAULT NULL,
  `status` enum('open','closed') NOT NULL DEFAULT 'open',
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE `login_attempts` (
  `id` int(10) UNSIGNED NOT NULL,
  `identifier` varchar(150) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `success` tinyint(1) NOT NULL DEFAULT 0,
  `attempted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `login_attempts`
--

INSERT INTO `login_attempts` (`id`, `identifier`, `ip_address`, `success`, `attempted_at`) VALUES
(1, 'Sky', '::1', 0, '2026-10-17 19:42:13');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `audience` enum('guest','admin') NOT NULL DEFAULT 'guest',
  `title` varchar(150) NOT NULL,
  `message` varchar(255) NOT NULL,
  `notification_type` varchar(30) NOT NULL DEFAULT 'announcement',
  `reservation_id` int(10) UNSIGNED DEFAULT NULL,
  `recipient_email` varchar(150) DEFAULT NULL,
  `email_status` enum('sent','failed','not_applicable') NOT NULL DEFAULT 'not_applicable',
  `status` enum('unread','read') NOT NULL DEFAULT 'unread',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(10) UNSIGNED NOT NULL,
  `reservation_id` int(10) UNSIGNED NOT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `reference_number` varchar(100) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `payment_status` enum('unpaid','partial','paid','refunded') NOT NULL DEFAULT 'unpaid',
  `payment_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `report_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `report_type` varchar(50) NOT NULL,
  `generated_date` date NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `reservation_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `accommodation_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `guest_name` varchar(150) NOT NULL,
  `guest_email` varchar(150) DEFAULT NULL,
  `guest_phone` varchar(30) DEFAULT NULL,
  `check_in_date` datetime NOT NULL,
  `check_out_date` datetime NOT NULL,
  `number_of_guests` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `total_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `reservation_status` enum('pending','confirmed','declined','cancelled','completed') NOT NULL DEFAULT 'pending',
  `payment_status` enum('unpaid','partial','paid','refunded') NOT NULL DEFAULT 'unpaid',
  `payment_method` varchar(50) DEFAULT NULL,
  `cancel_requested` tinyint(1) NOT NULL DEFAULT 0,
  `cancel_reason` text DEFAULT NULL,
  `created_by` enum('guest','admin') NOT NULL DEFAULT 'guest',
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `module_key` varchar(50) NOT NULL,
  `role` enum('admin','staff','guest') NOT NULL,
  `allowed` tinyint(1) NOT NULL DEFAULT 1,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`permission_id`, `module_key`, `role`, `allowed`, `updated_at`) VALUES
(1, 'dashboard', 'admin', 1, '2026-10-17 19:42:06'),
(2, 'dashboard', 'staff', 1, '2026-10-17 19:42:06'),
(3, 'dashboard', 'guest', 0, '2026-10-17 19:42:06'),
(4, 'reservation', 'admin', 1, '2026-10-17 19:42:06'),
(5, 'reservation', 'staff', 1, '2026-10-17 19:42:06'),
(6, 'reservation', 'guest', 1, '2026-10-17 19:42:06'),
(7, 'accommodation', 'admin', 1, '2026-10-17 19:42:06'),
(8, 'accommodation', 'staff', 1, '2026-10-17 19:42:06'),
(9, 'accommodation', 'guest', 1, '2026-10-17 19:42:06'),
(10, 'guest_record', 'admin', 1, '2026-10-17 19:42:06'),
(11, 'guest_record', 'staff', 1, '2026-10-17 19:42:06'),
(12, 'guest_record', 'guest', 0, '2026-10-17 19:42:06'),
(13, 'notifications', 'admin', 1, '2026-10-17 19:42:06'),
(14, 'notifications', 'staff', 1, '2026-10-17 19:42:06'),
(15, 'notifications', 'guest', 1, '2026-10-17 19:42:06'),
(16, 'feedback', 'admin', 1, '2026-10-17 19:42:06'),
(17, 'feedback', 'staff', 1, '2026-10-17 19:42:06'),
(18, 'feedback', 'guest', 1, '2026-10-17 19:42:06'),
(19, 'reports', 'admin', 1, '2026-10-17 19:42:06'),
(20, 'reports', 'staff', 1, '2026-10-17 19:42:06'),
(21, 'reports', 'guest', 0, '2026-10-17 19:42:06'),
(22, 'user_account', 'admin', 1, '2026-10-17 19:42:06'),
(23, 'user_account', 'staff', 0, '2026-10-17 19:42:06'),
(24, 'user_account', 'guest', 0, '2026-10-17 19:42:06'),
(25, 'settings', 'admin', 1, '2026-10-17 19:42:06'),
(26, 'settings', 'staff', 0, '2026-10-17 19:42:06'),
(27, 'settings', 'guest', 0, '2026-10-17 19:42:06');

-- --------------------------------------------------------

--
-- Table structure for table `security_logs`
--

CREATE TABLE `security_logs` (
  `log_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `activity` varchar(100) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `device_info` varchar(150) DEFAULT NULL,
  `location` varchar(150) DEFAULT NULL,
  `location_lat` decimal(9,6) DEFAULT NULL,
  `location_lng` decimal(9,6) DEFAULT NULL,
  `login_time` datetime DEFAULT NULL,
  `logout_time` datetime DEFAULT NULL,
  `status` enum('success','failed') NOT NULL DEFAULT 'success',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `security_logs`
--

INSERT INTO `security_logs` (`log_id`, `user_id`, `activity`, `ip_address`, `device_info`, `location`, `location_lat`, `location_lng`, `login_time`, `logout_time`, `status`, `created_at`) VALUES
(1, NULL, 'login attempt', '::1', 'Windows/Edge', 'Quezon City, Metro Manila, Philippines', 14.720000, 121.110000, '2026-10-17 07:42:13', NULL, 'failed', '2026-10-17 19:42:13');

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `setting_key` varchar(60) NOT NULL,
  `setting_value` varchar(60) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES
('activity_logging_enabled', '1', '2026-10-17 19:42:06'),
('login_attempt_limit', '5', '2026-10-17 19:42:06'),
('password_policy_enabled', '1', '2026-10-17 19:42:06'),
('session_timeout_minutes', '30', '2026-10-17 19:42:06'),
('two_factor_enabled', '1', '2026-10-17 19:42:06');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(150) NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('guest','staff','admin') NOT NULL DEFAULT 'guest',
  `profile_image` varchar(255) DEFAULT NULL,
  `valid_id_image` varchar(255) DEFAULT NULL,
  `id_verification_status` enum('not_submitted','pending','verified','rejected') NOT NULL DEFAULT 'not_submitted',
  `status` enum('active','disabled') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `firstname`, `lastname`, `username`, `email`, `contact_number`, `address`, `password`, `role`, `profile_image`, `valid_id_image`, `id_verification_status`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Camp', 'Administrator', 'admin', 'admin@campmayagay.com', NULL, NULL, '$2y$10$Wp1v6z1s0m3B3fH0iM8u9OQwqzZ0kQeYb9r8n0eYy2xQmS7QwV1uK', 'admin', NULL, NULL, 'not_submitted', 'active', '2026-10-17 19:42:07', '2026-10-17 19:42:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accommodations`
--
ALTER TABLE `accommodations`
  ADD PRIMARY KEY (`accommodation_id`),
  ADD UNIQUE KEY `uq_accommodations_slug` (`slug`);

--
-- Indexes for table `accommodation_favorites`
--
ALTER TABLE `accommodation_favorites`
  ADD PRIMARY KEY (`user_id`,`accommodation_id`);

--
-- Indexes for table `feedback_concerns`
--
ALTER TABLE `feedback_concerns`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `accommodation_id` (`accommodation_id`);

--
-- Indexes for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `reservation_id` (`reservation_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `reservation_id` (`reservation_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`reservation_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `accommodation_id` (`accommodation_id`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`permission_id`),
  ADD UNIQUE KEY `uq_module_role` (`module_key`,`role`);

--
-- Indexes for table `security_logs`
--
ALTER TABLE `security_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`setting_key`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `uq_users_email` (`email`),
  ADD UNIQUE KEY `uq_users_username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accommodations`
--
ALTER TABLE `accommodations`
  MODIFY `accommodation_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `feedback_concerns`
--
ALTER TABLE `feedback_concerns`
  MODIFY `feedback_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `report_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `reservation_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `permission_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `security_logs`
--
ALTER TABLE `security_logs`
  MODIFY `log_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `feedback_concerns`
--
ALTER TABLE `feedback_concerns`
  ADD CONSTRAINT `feedback_concerns_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `feedback_concerns_ibfk_2` FOREIGN KEY (`accommodation_id`) REFERENCES `accommodations` (`accommodation_id`) ON DELETE SET NULL;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`reservation_id`) ON DELETE SET NULL;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`reservation_id`) ON DELETE CASCADE;

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`accommodation_id`) REFERENCES `accommodations` (`accommodation_id`);

--
-- Constraints for table `security_logs`
--
ALTER TABLE `security_logs`
  ADD CONSTRAINT `security_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
