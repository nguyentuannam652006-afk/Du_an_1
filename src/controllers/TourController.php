<?php

class TourController
{
    private $tourModel;

    public function __construct()
    {
        $this->tourModel = new Tour();
    }

    // Danh sách tất cả các tour
    public function index()
    {
        // Yêu cầu đã đăng nhập
        if (!isLoggedIn()) {
            header('Location: ' . BASE_URL . 'welcome');
            exit;
        }

        $tours = $this->tourModel->all();

        view('admin/tours/index', [
            'title' => 'Danh sách Tour - Website Quản Lý Tour',
            'tours' => $tours,
        ]);
    }

    // Trang tạo tour mới
    public function create()
    {
        // Yêu cầu đã đăng nhập và là admin
        if (!isLoggedIn()) {
            header('Location: ' . BASE_URL . 'welcome');
            exit;
        }

        $currentUser = getCurrentUser();
        if (!$currentUser->isAdmin()) {
            http_response_code(403);
            view('not_found', [
                'title' => 'Truy cập bị từ chối',
            ]);
            exit;
        }

        view('admin/tours/create', [
            'title' => 'Tạo Tour Mới - Website Quản Lý Tour',
        ]);
    }

    // Lưu tour mới
    public function store()
    {
        // Yêu cầu đã đăng nhập và là admin
        if (!isLoggedIn()) {
            header('Location: ' . BASE_URL . 'welcome');
            exit;
        }

        $currentUser = getCurrentUser();
        if (!$currentUser->isAdmin()) {
            http_response_code(403);
            exit;
        }

        // Validate dữ liệu
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            header('Location: ' . BASE_URL . 'tour/create');
            exit;
        }

        $data = [
            'name' => $_POST['name'] ?? '',
            'description' => $_POST['description'] ?? '',
            'price' => $_POST['price'] ?? 0,
            'location' => $_POST['location'] ?? '',
            'status' => $_POST['status'] ?? 1,
        ];

        if (!$data['name'] || !$data['description'] || !$data['price'] || !$data['location']) {
            $_SESSION['error'] = 'Vui lòng điền đầy đủ thông tin';
            header('Location: ' . BASE_URL . 'tour/create');
            exit;
        }

        $data['price'] = (float)$data['price'];
        $data['status'] = (int)$data['status'];

        if ($this->tourModel->create($data)) {
            $_SESSION['success'] = 'Tạo tour thành công';
            header('Location: ' . BASE_URL . 'tour/index');
        } else {
            $_SESSION['error'] = 'Tạo tour thất bại';
            header('Location: ' . BASE_URL . 'tour/create');
        }
        exit;
    }

    // Trang chỉnh sửa tour
    public function edit()
    {
        // Yêu cầu đã đăng nhập và là admin
        if (!isLoggedIn()) {
            header('Location: ' . BASE_URL . 'welcome');
            exit;
        }

        $currentUser = getCurrentUser();
        if (!$currentUser->isAdmin()) {
            http_response_code(403);
            view('not_found', [
                'title' => 'Truy cập bị từ chối',
            ]);
            exit;
        }

        $id = $_GET['id'] ?? null;
        if (!$id) {
            header('Location: ' . BASE_URL . 'tour/index');
            exit;
        }

        $tour = $this->tourModel->find($id);
        if (!$tour) {
            http_response_code(404);
            view('not_found', [
                'title' => 'Không tìm thấy tour',
            ]);
            exit;
        }

        view('admin/tours/edit', [
            'title' => 'Chỉnh sửa Tour - Website Quản Lý Tour',
            'tour' => $tour,
        ]);
    }

    // Cập nhật tour
    public function update()
    {
        // Yêu cầu đã đăng nhập và là admin
        if (!isLoggedIn()) {
            header('Location: ' . BASE_URL . 'welcome');
            exit;
        }

        $currentUser = getCurrentUser();
        if (!$currentUser->isAdmin()) {
            http_response_code(403);
            exit;
        }

        // Validate dữ liệu
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            header('Location: ' . BASE_URL . 'tour/index');
            exit;
        }

        $id = $_POST['id'] ?? null;
        if (!$id) {
            $_SESSION['error'] = 'ID tour không hợp lệ';
            header('Location: ' . BASE_URL . 'tour/index');
            exit;
        }

        $data = [
            'name' => $_POST['name'] ?? '',
            'description' => $_POST['description'] ?? '',
            'price' => $_POST['price'] ?? 0,
            'location' => $_POST['location'] ?? '',
            'status' => $_POST['status'] ?? 1,
        ];

        if (!$data['name'] || !$data['description'] || !$data['price'] || !$data['location']) {
            $_SESSION['error'] = 'Vui lòng điền đầy đủ thông tin';
            header('Location: ' . BASE_URL . 'tour/edit?id=' . $id);
            exit;
        }

        $data['price'] = (float)$data['price'];
        $data['status'] = (int)$data['status'];

        if ($this->tourModel->update($id, $data)) {
            $_SESSION['success'] = 'Cập nhật tour thành công';
            header('Location: ' . BASE_URL . 'tour/index');
        } else {
            $_SESSION['error'] = 'Cập nhật tour thất bại';
            header('Location: ' . BASE_URL . 'tour/edit?id=' . $id);
        }
        exit;
    }

    // Xóa tour
    public function delete()
    {
        // Yêu cầu đã đăng nhập và là admin
        if (!isLoggedIn()) {
            header('Location: ' . BASE_URL . 'welcome');
            exit;
        }

        $currentUser = getCurrentUser();
        if (!$currentUser->isAdmin()) {
            http_response_code(403);
            exit;
        }

        $id = $_GET['id'] ?? null;
        if (!$id) {
            $_SESSION['error'] = 'ID tour không hợp lệ';
            header('Location: ' . BASE_URL . 'tour/index');
            exit;
        }

        if ($this->tourModel->delete($id)) {
            $_SESSION['success'] = 'Xóa tour thành công';
        } else {
            $_SESSION['error'] = 'Xóa tour thất bại';
        }

        header('Location: ' . BASE_URL . 'tour/index');
        exit;
    }
}
