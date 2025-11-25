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

DROP DATABASE IF EXISTS `website_ql_tour`;
CREATE DATABASE IF NOT EXISTS `website_ql_tour`;
USE `website_ql_tour`;

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
