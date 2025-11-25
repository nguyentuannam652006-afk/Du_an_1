-- Database for Website Quản Lý Tour
-- Simplified schema for development
-- Created: 2025-11-25

-- Drop existing tables
DROP TABLE IF EXISTS tours;
DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'huong_dan_vien') DEFAULT 'huong_dan_vien',
    status TINYINT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tours table
CREATE TABLE tours (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description LONGTEXT NOT NULL,
    price DECIMAL(10, 0) NOT NULL,
    location VARCHAR(255) NOT NULL,
    status TINYINT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert test users
INSERT INTO users (name, email, password, role, status) VALUES
('Admin', 'admin@example.com', 'admin123', 'admin', 1),
('Hướng dẫn viên', 'guide@example.com', 'guide123', 'huong_dan_vien', 1);

-- Insert sample tours
INSERT INTO tours (name, description, price, location, status) VALUES
('Tour Hà Nội - Hạ Long', 'Khám phá vẻ đẹp của thủ đô Hà Nội và vịnh Hạ Long nổi tiếng thế giới. Tham quan các điểm du lịch nổi tiếng như Hoàn Kiếm, Mausoleum Hồ Chí Minh, và vịnh Hạ Long là một trong những kỳ quan thiên nhiên của thế giới.', 3500000, 'Hà Nội - Quảng Ninh', 1),
('Tour Huế - Đà Nẵng', 'Chiêm ngưỡng cố đô Huế với Hoàng Thành Huế và bãi biển đẹp tại Đà Nẵng. Tham quan Chùa Thiên Mụ, Lăng vua, Bà Nà Hills, và các bãi tắm nổi tiếng.', 2800000, 'Thừa Thiên Huế - Đà Nẵng', 1),
('Tour TP.HCM - Cần Thơ', 'Ghé thăm thành phố Hồ Chí Minh và chợ nổi Cần Thơ. Tham quan Dinh Độc lập, Bảo tàng Chiến tranh, chợ Bến Thành, và khám phá đồng bằng sông Cửu Long.', 2500000, 'TP. Hồ Chí Minh - Cần Thơ', 1),
('Tour Đà Lạt', 'Thưởng thức không khí mùa thu tuyệt vời tại thành phố ngàn hoa. Khám phá Thác Pongour, Hồ Tuyền Lâm, Làng cổ Kênh Ga, và cảnh sắc thiên nhiên đẹp lạ.', 1500000, 'Lâm Đồng', 1),
('Tour Thái Lan', 'Khám phá vẻ đẹp Bangkok, Pattaya với các điểm du lịch nổi tiếng như Đền Phật Jade, Pattaya Beach, Night Market, và mua sắm tại các trung tâm thương mại lớn.', 8000000, 'Bangkok - Pattaya, Thái Lan', 1);
