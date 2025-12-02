<?php
startSession();
$pageTitle = 'Thêm Hướng dẫn viên Mới';
$breadcrumb = [
    ['label' => 'Quản lý Hướng dẫn viên', 'url' => BASE_URL . 'guide/index', 'active' => false],
    ['label' => $pageTitle, 'url' => BASE_URL . 'guide/create', 'active' => true],
];

$errors = $_SESSION['errors'] ?? [];
unset($_SESSION['errors']);

ob_start();
?>
<div class="row">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header bg-primary">
                <h3 class="card-title">Thêm Hướng dẫn viên Mới</h3>
            </div>
            <form action="<?= BASE_URL ?>guide/store" method="POST">
                <div class="card-body">
                    <?php if (!empty($errors)): ?>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-circle"></i>
                            <ul class="mb-0">
                                <?php foreach ($errors as $error): ?>
                                    <li><?= htmlspecialchars($error) ?></li>
                                <?php endforeach; ?>
                            </ul>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    <?php endif; ?>

                    <div class="mb-3">
                        <label for="name" class="form-label">Tên Hướng dẫn viên <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="Nhập tên hướng dẫn viên" required>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email" required>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required>
                        <small class="text-muted">Mật khẩu tối thiểu 6 ký tự</small>
                    </div>

                    <div class="mb-3">
                        <label for="phone" class="form-label">Số điện thoại</label>
                        <input type="tel" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại">
                    </div>

                    <div class="mb-3">
                        <label for="experience" class="form-label">Kinh nghiệm</label>
                        <textarea class="form-control" id="experience" name="experience" rows="3" placeholder="Nhập kinh nghiệm hướng dẫn"></textarea>
                    </div>
                </div>
                <div class="card-footer">
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-check-circle"></i> Tạo Hướng dẫn viên
                    </button>
                    <a href="<?= BASE_URL ?>guide/index" class="btn btn-secondary">
                        <i class="bi bi-arrow-left"></i> Quay lại
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>
<?php
$content = ob_get_clean();
view('layouts/AdminLayout', [
    'title' => $pageTitle . ' - Website Quản Lý Tour',
    'pageTitle' => $pageTitle,
    'breadcrumb' => $breadcrumb,
    'content' => $content,
]);
?>
