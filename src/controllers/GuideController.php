<?php

class GuideController
{
    /**
     * Hiển thị danh sách hướng dẫn viên
     */
    public function index()
    {
        requireLogin();
        
        $db = getDB();
        $stmt = $db->prepare('SELECT * FROM users WHERE role = ? ORDER BY created_at DESC');
        $stmt->execute(['huong_dan_vien']);
        $guides = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        include BASE_PATH . '/views/admin/guides/index.php';
    }

    /**
     * Hiển thị form tạo hướng dẫn viên
     */
    public function create()
    {
        requireLogin();
        isAdmin();
        
        include BASE_PATH . '/views/admin/guides/create.php';
    }

    /**
     * Lưu hướng dẫn viên mới
     */
    public function store()
    {
        requireLogin();
        isAdmin();
        
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('guide/index');
        }

        $errors = [];
        $name = trim($_POST['name'] ?? '');
        $email = trim($_POST['email'] ?? '');
        $password = $_POST['password'] ?? '';
        $phone = trim($_POST['phone'] ?? '');
        $experience = trim($_POST['experience'] ?? '');

        // Validate
        if (empty($name)) {
            $errors[] = 'Tên hướng dẫn viên không được để trống';
        }
        if (empty($email)) {
            $errors[] = 'Email không được để trống';
        }
        if (empty($password)) {
            $errors[] = 'Mật khẩu không được để trống';
        }

        if (!empty($errors)) {
            $_SESSION['errors'] = $errors;
            redirect('guide/create');
        }

        $db = getDB();
        
        try {
            $stmt = $db->prepare('INSERT INTO users (name, email, password, role, status) VALUES (?, ?, ?, ?, 1)');
            $stmt->execute([$name, $email, $password, 'huong_dan_vien']);
            
            $_SESSION['success'] = 'Tạo hướng dẫn viên thành công!';
            redirect('guide/index');
        } catch (PDOException $e) {
            if (strpos($e->getMessage(), 'Duplicate entry') !== false) {
                $_SESSION['error'] = 'Email này đã tồn tại!';
            } else {
                $_SESSION['error'] = 'Lỗi: ' . $e->getMessage();
            }
            redirect('guide/create');
        }
    }

    /**
     * Hiển thị form chỉnh sửa hướng dẫn viên
     */
    public function edit()
    {
        requireLogin();
        isAdmin();
        
        $id = $_GET['id'] ?? null;
        if (!$id) {
            redirect('guide/index');
        }

        $db = getDB();
        $stmt = $db->prepare('SELECT * FROM users WHERE id = ? AND role = ?');
        $stmt->execute([$id, 'huong_dan_vien']);
        $guide = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$guide) {
            $_SESSION['error'] = 'Hướng dẫn viên không tồn tại';
            redirect('guide/index');
        }

        include BASE_PATH . '/views/admin/guides/edit.php';
    }

    /**
     * Cập nhật hướng dẫn viên
     */
    public function update()
    {
        requireLogin();
        isAdmin();
        
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('guide/index');
        }

        $id = $_POST['id'] ?? null;
        $name = trim($_POST['name'] ?? '');
        $email = trim($_POST['email'] ?? '');
        $phone = trim($_POST['phone'] ?? '');
        $experience = trim($_POST['experience'] ?? '');

        if (!$id || empty($name) || empty($email)) {
            $_SESSION['error'] = 'Thông tin không hợp lệ';
            redirect('guide/index');
        }

        $db = getDB();
        
        try {
            $stmt = $db->prepare('UPDATE users SET name = ?, email = ?, status = 1 WHERE id = ? AND role = ?');
            $stmt->execute([$name, $email, $id, 'huong_dan_vien']);
            
            $_SESSION['success'] = 'Cập nhật hướng dẫn viên thành công!';
            redirect('guide/index');
        } catch (PDOException $e) {
            $_SESSION['error'] = 'Lỗi: ' . $e->getMessage();
            redirect('guide/edit?id=' . $id);
        }
    }

    /**
     * Xóa hướng dẫn viên
     */
    public function delete()
    {
        requireLogin();
        isAdmin();
        
        $id = $_GET['id'] ?? null;
        if (!$id) {
            redirect('guide/index');
        }

        $db = getDB();
        
        try {
            $stmt = $db->prepare('DELETE FROM users WHERE id = ? AND role = ?');
            $stmt->execute([$id, 'huong_dan_vien']);
            
            $_SESSION['success'] = 'Xóa hướng dẫn viên thành công!';
        } catch (PDOException $e) {
            $_SESSION['error'] = 'Lỗi: ' . $e->getMessage();
        }
        
        redirect('guide/index');
    }
}
