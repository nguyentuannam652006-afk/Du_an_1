# 🔴 LỖI ĐĂNG NHẬP - HƯỚNG DẪN KHẮC PHỤC NHANH

## ⚠️ Vấn Đề

Không thể đăng nhập được vào hệ thống.

---

## ✅ GIẢI PHÁP TỪNG BƯỚC

### **Bước 1: Kiểm Tra MySQL Chạy Không**

1. **Mở Laragon**
2. **Kiểm tra MySQL ON** (phải có icon xanh)
3. Nếu OFF → Nhấp để bật ON

---

### **Bước 2: Reset Database Hoàn Toàn**

#### **Cách 1: Dùng File database_simple.sql (NHANH NHẤT)**

1. **Mở phpMyAdmin:**
   ```
   http://localhost/phpmyadmin
   ```

2. **Tạo database mới nếu chưa có:**
   ```sql
   CREATE DATABASE IF NOT EXISTS website_ql_tour;
   ```

3. **Import file database_simple.sql:**
   - Tab "Import"
   - Chọn file: `database_simple.sql`
   - Nhấp "Go"

4. **Hoàn tất!**

#### **Cách 2: Chạy SQL Command Trực Tiếp**

**Mở phpMyAdmin → SQL Tab → Copy-Paste:**

```sql
DROP DATABASE IF EXISTS website_ql_tour;
CREATE DATABASE website_ql_tour;
USE website_ql_tour;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'huong_dan_vien') DEFAULT 'huong_dan_vien',
    status TINYINT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE tours (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description LONGTEXT NOT NULL,
    price DECIMAL(10, 0) NOT NULL,
    location VARCHAR(255) NOT NULL,
    status TINYINT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO users (name, email, password, role, status) VALUES
('Admin', 'admin@example.com', 'admin123', 'admin', 1),
('Hướng dẫn viên', 'guide@example.com', 'guide123', 'huong_dan_vien', 1);

INSERT INTO tours (name, description, price, location, status) VALUES
('Tour Hà Nội - Hạ Long', 'Khám phá vẻ đẹp của thủ đô Hà Nội và vịnh Hạ Long nổi tiếng thế giới.', 3500000, 'Hà Nội - Quảng Ninh', 1),
('Tour Huế - Đà Nẵng', 'Chiêm ngưỡng cố đô Huế với Hoàng Thành Huế và bãi biển đẹp tại Đà Nẵng.', 2800000, 'Thừa Thiên Huế - Đà Nẵng', 1),
('Tour TP.HCM - Cần Thơ', 'Ghé thăm thành phố Hồ Chí Minh và chợ nổi Cần Thơ.', 2500000, 'TP. Hồ Chí Minh - Cần Thơ', 1),
('Tour Đà Lạt', 'Thưởng thức không khí mùa thu tuyệt vời tại thành phố ngàn hoa.', 1500000, 'Lâm Đồng', 1),
('Tour Thái Lan', 'Khám phá vẻ đẹp Bangkok, Pattaya với các điểm du lịch nổi tiếng.', 8000000, 'Bangkok - Pattaya, Thái Lan', 1);
```

5. **Nhấp "Go"**

---

### **Bước 3: Xóa Cache & Cookies Browser**

1. **Nhấp F12** (mở Developer Tools)
2. **Chọn Tab "Application"**
3. **Storage → Cookies → localhost**
4. **Xóa hết cookies**
5. **Hoặc:** Ctrl+Shift+Delete → Xóa hết

---

### **Bước 4: Truy Cập & Đăng Nhập**

1. **Truy cập:**
   ```
   http://localhost/website_quan_ly_tour/
   ```

2. **Nhấp "Đăng Nhập"**

3. **Nhập thông tin:**
   - **Email:** `admin@example.com`
   - **Mật khẩu:** `admin123`

4. **Nhấp "Đăng Nhập"**

5. ✅ **Kết quả: Vào được trang home**

---

## 🔍 KIỂM TRA DỮ LIỆU

### **Kiểm Tra Users:**
```sql
SELECT * FROM website_ql_tour.users;
```

**Kết quả mong đợi:**
```
ID | Name | Email | Password | Role | Status
1  | Admin | admin@example.com | admin123 | admin | 1
2  | Hướng dẫn viên | guide@example.com | guide123 | huong_dan_vien | 1
```

### **Kiểm Tra Tours:**
```sql
SELECT * FROM website_ql_tour.tours;
```

**Kết quả mong đợi:**
```
5 tours với đầy đủ thông tin
```

---

## 🚀 TEST ĐĂNG NHẬP

### **Test 1: Đăng Nhập Admin**
```
Email: admin@example.com
Password: admin123
→ ✅ Vào được trang home
→ ✅ Hiển thị "Đăng nhập thành công!"
→ ✅ Vai trò: Admin
```

### **Test 2: Đăng Nhập Guide**
```
Email: guide@example.com
Password: guide123
→ ✅ Vào được trang home
→ ✅ Hiển thị "Đăng nhập thành công!"
→ ✅ Vai trò: Hướng dẫn viên
```

### **Test 3: Sai Mật Khẩu**
```
Email: admin@example.com
Password: wrongpassword
→ ✅ Thông báo lỗi
→ ✅ Quay lại form login
```

---

## 🛠️ KIỂM TRA CẤU HÌNH

### **File: config/config.php**
```php
<?php
if (!defined('BASE_PATH')) {
    define('BASE_PATH', dirname(__DIR__));
}
if (!defined('BASE_URL')) {
    define('BASE_URL', '/website_quan_ly_tour/');
}

return [
    'db' => [
        'host' => 'localhost',       // ✅
        'name' => 'website_ql_tour', // ✅
        'user' => 'root',            // ✅
        'pass' => '',                // ✅ (trống là đúng)
        'charset' => 'utf8mb4',      // ✅
    ],
];
```

**Nếu sai → Cập nhật cho đúng!**

---

## 🐛 NẾU VẪN LỖI

### **Lỗi 1: Trang Trắng (Blank Page)**
- 🔴 Kiểm tra: Có PHP error không?
- 🟢 Giải pháp:
  1. Mở file `index.php`
  2. Thêm ở đầu:
  ```php
  error_reporting(E_ALL);
  ini_set('display_errors', 1);
  ```
  3. Refresh trang
  4. Xem error message

### **Lỗi 2: "Database connection failed"**
- 🔴 Nguyên nhân: MySQL không chạy
- 🟢 Giải pháp:
  1. Mở Laragon
  2. Bật MySQL

### **Lỗi 3: Không tìm thấy bảng "users"**
- 🔴 Nguyên nhân: Database chưa tạo
- 🟢 Giải pháp: Import SQL file

### **Lỗi 4: Column not found**
- 🔴 Nguyên nhân: Schema sai
- 🟢 Giải pháp:
  ```sql
  DROP DATABASE website_ql_tour;
  -- Import lại SQL file mới
  ```

---

## 📋 CHECKLIST

- [ ] MySQL bật ON
- [ ] Database `website_ql_tour` tồn tại
- [ ] Bảng `users` có 2 users
- [ ] Bảng `tours` có 5 tours
- [ ] Config file đúng
- [ ] Xóa cache cookies
- [ ] Đăng nhập được admin
- [ ] Vào được danh sách tour

---

## ✨ TÓAN TẮT

1. **Reset Database:**
   - Import `database_simple.sql`

2. **Xóa Cache:**
   - Ctrl+Shift+Delete

3. **Đăng Nhập:**
   - admin@example.com / admin123

4. **Kiểm Tra:**
   - Vào được trang home

**Nếu theo đúng các bước này sẽ được 100%! 🎉**

---

## 📞 LIÊN HỆ HỖ TRỢ

Nếu vẫn có vấn đề:
1. Kiểm tra từng bước lại
2. Xem error message trong browser (F12)
3. Kiểm tra database trong phpMyAdmin
4. Nếu cần: Reset lại toàn bộ project
