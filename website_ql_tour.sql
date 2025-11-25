-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 25, 2025
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
-- Database: `website_ql_tour`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL UNIQUE,
  `password` varchar(255) NOT NULL,
  `role` enum('admin', 'huong_dan_vien') DEFAULT 'huong_dan_vien',
  `status` tinyint(4) DEFAULT 1,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`name`, `email`, `password`, `role`, `status`) VALUES
('Admin', 'admin@example.com', 'admin123', 'admin', 1),
('Hướng dẫn viên', 'guide@example.com', 'guide123', 'huong_dan_vien', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tours`
--

CREATE TABLE IF NOT EXISTS `tours` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `price` decimal(10, 0) NOT NULL,
  `location` varchar(255) NOT NULL,
  `status` tinyint(4) DEFAULT 1,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tours`
--

INSERT INTO `tours` (`name`, `description`, `price`, `location`, `status`) VALUES
('Tour Hà Nội - Hạ Long', 'Khám phá vẻ đẹp của thủ đô Hà Nội và vịnh Hạ Long nổi tiếng thế giới. Tham quan các điểm du lịch nổi tiếng như Hoàn Kiếm, Mausoleum Hồ Chí Minh, và vịnh Hạ Long là một trong những kỳ quan thiên nhiên của thế giới.', 3500000, 'Hà Nội - Quảng Ninh', 1),
('Tour Huế - Đà Nẵng', 'Chiêm ngưỡng cố đô Huế với Hoàng Thành Huế và bãi biển đẹp tại Đà Nẵng. Tham quan Chùa Thiên Mụ, Lăng vua, Bà Nà Hills, và các bãi tắm nổi tiếng.', 2800000, 'Thừa Thiên Huế - Đà Nẵng', 1),
('Tour TP.HCM - Cần Thơ', 'Ghé thăm thành phố Hồ Chí Minh và chợ nổi Cần Thơ. Tham quan Dinh Độc lập, Bảo tàng Chiến tranh, chợ Bến Thành, và khám phá đồng bằng sông Cửu Long.', 2500000, 'TP. Hồ Chí Minh - Cần Thơ', 1),
('Tour Đà Lạt', 'Thưởng thức không khí mùa thu tuyệt vời tại thành phố ngàn hoa. Khám phá Thác Pongour, Hồ Tuyền Lâm, Làng cổ Kênh Ga, và cảnh sắc thiên nhiên đẹp lạ.', 1500000, 'Lâm Đồng', 1),
('Tour Thái Lan', 'Khám phá vẻ đẹp Bangkok, Pattaya với các điểm du lịch nổi tiếng như Đền Phật Jade, Pattaya Beach, Night Market, và mua sắm tại các trung tâm thương mại lớn.', 8000000, 'Bangkok - Pattaya, Thái Lan', 1);

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
  `id` bigint(20) NOT NULL,
  `tour_id` bigint(20) DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `assigned_guide_id` bigint(20) DEFAULT NULL,
  `status` bigint(20) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `schedule_detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`schedule_detail`)),
  `service_detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`service_detail`)),
  `diary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`diary`)),
  `lists_file` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`lists_file`)),
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
 ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `tour_id`, `created_by`, `assigned_guide_id`, `status`, `start_date`, `end_date`, `schedule_detail`, `service_detail`, `diary`, `lists_file`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 1, '2024-07-01', '2024-07-03', '{\"guide\":\"2\"}', '{\"bus\":\"Xe Hùng Mạnh\"}', '{\"entries\":[\"Ngày 1: OK\"]}', '{\"guest_list\":\"guest1.xlsx\"}', 'Booking đoàn A', '2025-11-21 10:34:56', '2025-11-21 10:34:56'),
(2, 2, 1, 2, 2, '2024-08-10', '2024-08-13', '{\"guide\":\"2\"}', '{\"bus\":\"Bus Express\"}', '{\"entries\":[\"Ngày 1: Checkin\"]}', '{\"guest_list\":\"guest2.xlsx\"}', 'Booking đoàn B', '2025-11-21 10:34:56', '2025-11-21 10:34:56');

-- --------------------------------------------------------

--
-- Table structure for table `booking_status_logs`
--

CREATE TABLE `booking_status_logs` (
  `id` bigint(20) NOT NULL,
  `booking_id` bigint(20) DEFAULT NULL,
  `old_status` bigint(20) DEFAULT NULL,
  `new_status` bigint(20) DEFAULT NULL,
  `changed_by` bigint(20) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking_status_logs`
--

INSERT INTO `booking_status_logs` (`id`, `booking_id`, `old_status`, `new_status`, `changed_by`, `note`, `changed_at`) VALUES
(1, 1, 1, 2, 1, 'Chuyển sang đã xác nhận', '2025-11-21 10:35:15'),
(2, 2, 1, 2, 2, 'HDV xác nhận tham gia', '2025-11-21 10:35:15');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Tour trong nước', 'Tour du lịch nội địa', 1, '2025-11-21 10:33:01', '2025-11-21 10:33:01'),
(2, 'Tour quốc tế', 'Tour du lịch quốc tế', 1, '2025-11-21 10:33:01', '2025-11-21 10:33:01');

-- --------------------------------------------------------

--
-- Table structure for table `guide_profiles`
--

CREATE TABLE `guide_profiles` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `certificate` text DEFAULT NULL,
  `languages` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`languages`)),
  `experience` text DEFAULT NULL,
  `history` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`history`)),
  `rating` decimal(3,2) DEFAULT NULL,
  `health_status` text DEFAULT NULL,
  `group_type` varchar(50) DEFAULT NULL,
  `speciality` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `guide_profiles`
--

INSERT INTO `guide_profiles` (`id`, `user_id`, `birthdate`, `avatar`, `phone`, `certificate`, `languages`, `experience`, `history`, `rating`, `health_status`, `group_type`, `speciality`, `created_at`, `updated_at`) VALUES
(1, 2, '1990-01-01', 'guide1.jpg', '0912345678', '[\"HDV quốc tế\"]', '[\"Tiếng Anh\",\"Tiếng Việt\"]', '5 năm kinh nghiệm', '{\"tours\":[1]}', 4.80, 'Tốt', 'quốc tế', 'chuyên tuyến miền Bắc', '2025-11-21 10:35:29', '2025-11-21 10:35:29'),
(2, 1, '1985-02-02', 'guide2.jpg', '0987654321', '[\"HDV nội địa\"]', '[\"Tiếng Việt\"]', '10 năm kinh nghiệm', '{\"tours\":[2]}', 4.90, 'Khá', 'nội địa', 'chuyên khách đoàn', '2025-11-21 10:35:29', '2025-11-21 10:35:29');

-- --------------------------------------------------------

--
-- Table structure for table `tours`
--

CREATE TABLE `tours` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `schedule` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`schedule`)),
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`images`)),
  `prices` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`prices`)),
  `policies` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`policies`)),
  `suppliers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`suppliers`)),
  `price` decimal(15,2) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tours`
--

INSERT INTO `tours` (`id`, `name`, `description`, `category_id`, `schedule`, `images`, `prices`, `policies`, `suppliers`, `price`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Tour Hạ Long', 'Khám phá vịnh Hạ Long', 1, '{\"days\":[{\"date\":\"2024-07-01\",\"activities\":[\"Thăm vịnh Hạ Long\",\"Ăn trưa trên tàu\"]}]}', '[\"halong1.jpg\",\"halong2.jpg\"]', '{\"adult\":1500000,\"child\":800000}', '{\"booking\":\"Không hoàn tiền khi hủy trong vòng 48h\"}', '[\"Vinpearl Hotel\",\"Xe Hùng Mạnh\"]', 1500000.00, 1, '2025-11-21 10:33:16', '2025-11-21 10:33:16'),
(2, 'Tour Thái Lan', 'Du lịch Bangkok - Pattaya', 2, '{\"days\":[{\"date\":\"2024-08-10\",\"activities\":[\"Tham quan chùa vàng\",\"Ăn buffet\"]}]}', '[\"thailand1.jpg\",\"thailand2.jpg\"]', '{\"adult\":8000000,\"child\":6000000}', '{\"booking\":\"Hoàn 50% trước 7 ngày\"}', '[\"Bangkok Hotel\",\"Bus Express\"]', 8000000.00, 1, '2025-11-21 10:33:16', '2025-11-21 10:33:16');

-- --------------------------------------------------------

--
-- Table structure for table `tour_statuses`
--

CREATE TABLE `tour_statuses` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tour_statuses`
--

INSERT INTO `tour_statuses` (`id`, `name`, `description`) VALUES
(1, 'Chờ xác nhận', 'Chưa xác nhận bởi admin/khách'),
(2, 'Đã cọc', 'Khách đã đặt cọc giữ chỗ'),
(3, 'Hoàn tất', 'Tour đã kết thúc thành công'),
(4, 'Hủy', 'Tour đã bị hủy');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Admin Demo', 'admin@gmail.com', '$2b$12$aMCpMAh0qL6vmdAxJAUg6e7heTbbp9y.5nH6c0KxrN261NitXYEcu', 'admin', 1, '2025-11-21 10:32:39', '2025-11-22 09:21:16'),
(2, 'Guide Demo', 'guide@gmail.com', '$2b$12$cvD4Gm8Hk8aB2HE/JnzsjuEGlTH1DBV4z7/ZhyZEsjOvNV9oVgWsO', 'guide', 1, '2025-11-21 10:32:39', '2025-11-22 09:21:36');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tour_id` (`tour_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `assigned_guide_id` (`assigned_guide_id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `booking_status_logs`
--
ALTER TABLE `booking_status_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`),
  ADD KEY `old_status` (`old_status`),
  ADD KEY `new_status` (`new_status`),
  ADD KEY `changed_by` (`changed_by`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `guide_profiles`
--
ALTER TABLE `guide_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `tours`
--
ALTER TABLE `tours`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `tour_statuses`
--
ALTER TABLE `tour_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `booking_status_logs`
--
ALTER TABLE `booking_status_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `guide_profiles`
--
ALTER TABLE `guide_profiles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tours`
--
ALTER TABLE `tours`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tour_statuses`
--
ALTER TABLE `tour_statuses`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`assigned_guide_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `bookings_ibfk_4` FOREIGN KEY (`status`) REFERENCES `tour_statuses` (`id`);

--
-- Constraints for table `booking_status_logs`
--
ALTER TABLE `booking_status_logs`
  ADD CONSTRAINT `booking_status_logs_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`),
  ADD CONSTRAINT `booking_status_logs_ibfk_2` FOREIGN KEY (`old_status`) REFERENCES `tour_statuses` (`id`),
  ADD CONSTRAINT `booking_status_logs_ibfk_3` FOREIGN KEY (`new_status`) REFERENCES `tour_statuses` (`id`),
  ADD CONSTRAINT `booking_status_logs_ibfk_4` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `guide_profiles`
--
ALTER TABLE `guide_profiles`
  ADD CONSTRAINT `guide_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `tours`
--
ALTER TABLE `tours`
  ADD CONSTRAINT `tours_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
