<?php

// Controller xử lý các chức năng liên quan đến xác thực (đăng nhập, đăng xuất)
class AuthController
{
    
    // Hiển thị form đăng nhập
    public function login()
    {
        // Nếu đã đăng nhập rồi thì chuyển về trang home
        if (isLoggedIn()) {
            header('Location: ' . BASE_URL . 'home');
            exit;   
        }

        // Lấy URL redirect nếu có (để quay lại trang đang xem sau khi đăng nhập)
        // Mặc định redirect về trang home
        $redirect = $_GET['redirect'] ?? BASE_URL . 'home';

        // Hiển thị view login
        view('auth.login', [
            'title' => 'Đăng nhập',
            'redirect' => $redirect,
        ]);
    }

    // Xử lý đăng nhập (nhận dữ liệu từ form POST)
    public function checkLogin()
    {
        // Chỉ xử lý khi là POST request
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            header('Location: ' . BASE_URL . 'login');
            exit;
        }

        // Lấy dữ liệu từ form
        $email = $_POST['email'] ?? '';
        $password = $_POST['password'] ?? '';
        // Mặc định redirect về trang home sau khi đăng nhập
        $redirect = $_POST['redirect'] ?? BASE_URL . 'home';

        // Validate dữ liệu đầu vào
        $errors = [];

        if (empty($email)) {
            $errors[] = 'Vui lòng nhập email';
        }

        if (empty($password)) {
            $errors[] = 'Vui lòng nhập mật khẩu';
        }

        // Nếu có lỗi validation thì quay lại form login
        if (!empty($errors)) {
            view('auth.login', [
                'title' => 'Đăng nhập',
                'errors' => $errors,
                'email' => $email,
                'redirect' => $redirect,
            ]);
            return;
        }

        // Kết nối database và kiểm tra thông tin đăng nhập
        $db = getDB();
        if ($db === null) {
            $errors[] = 'Lỗi kết nối cơ sở dữ liệu';
            view('auth.login', [
                'title' => 'Đăng nhập',
                'errors' => $errors,
                'email' => $email,
                'redirect' => $redirect,
            ]);
            return;
        }

        try {
            // Tìm user theo email
            $stmt = $db->prepare('SELECT * FROM users WHERE email = ? AND status = 1');
            $stmt->execute([$email]);
            $userData = $stmt->fetch(PDO::FETCH_ASSOC);

            // Kiểm tra user có tồn tại không
            if (!$userData) {
                $errors[] = 'Email hoặc mật khẩu không chính xác';
            } else {
                // Kiểm tra mật khẩu
                $validPassword = false;
                
                // Cách 1: Dùng password_verify nếu hash hợp lệ
                if (password_verify($password, $userData['password'])) {
                    $validPassword = true;
                }
                // Cách 2: Demo - kiểm tra mật khẩu cứng để test
                elseif ($userData['role'] === 'admin' && $password === 'admin123') {
                    $validPassword = true;
                }
                elseif ($userData['role'] === 'huong_dan_vien' && $password === 'guide123') {
                    $validPassword = true;
                }

                if (!$validPassword) {
                    $errors[] = 'Email hoặc mật khẩu không chính xác';
                }
            }

            // Nếu có lỗi thì hiển thị form login lại
            if (!empty($errors)) {
                view('auth.login', [
                    'title' => 'Đăng nhập',
                    'errors' => $errors,
                    'email' => $email,
                    'redirect' => $redirect,
                ]);
                return;
            }

            // Đăng nhập thành công: tạo user object và lưu vào session
            $user = new User($userData);
            loginUser($user);

            // Chuyển hướng về trang được yêu cầu hoặc trang chủ
            header('Location: ' . $redirect);
            exit;
        } catch (PDOException $e) {
            $errors[] = 'Lỗi cơ sở dữ liệu: ' . $e->getMessage();
            view('auth.login', [
                'title' => 'Đăng nhập',
                'errors' => $errors,
                'email' => $email,
                'redirect' => $redirect,
            ]);
            return;
        }
    }

    // Xử lý đăng xuất
    public function logout()
    {
        // Xóa session và đăng xuất
        logoutUser();

        // Chuyển hướng về trang welcome
        header('Location: ' . BASE_URL . 'welcome');
        exit;
    }
}