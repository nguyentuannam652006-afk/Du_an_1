<?php
startSession();
$pageTitle = 'Chỉnh sửa Hướng dẫn viên';
$breadcrumb = [
    ['label' => 'Quản lý Hướng dẫn viên', 'url' => BASE_URL . 'guide/index', 'active' => false],
    ['label' => $pageTitle, 'url' => '#', 'active' => true],
];

ob_start();
?>
<div class="row">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header bg-warning">
                <h3 class="card-title">Chỉnh sửa Hướng dẫn viên</h3>
            </div>
            <form action="<?= BASE_URL ?>guide/update" method="POST">
                <div class="card-body">
                    <input type="hidden" name="id" value="<?= htmlspecialchars($guide['id'] ?? '') ?>">

                    <div class="mb-3">
                        <label for="name" class="form-label">Tên Hướng dẫn viên <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="name" name="name" value="<?= htmlspecialchars($guide['name'] ?? '') ?>" required>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                        <input type="email" class="form-control" id="email" name="email" value="<?= htmlspecialchars($guide['email'] ?? '') ?>" required>
                    </div>

                    <div class="mb-3">
                        <label for="phone" class="form-label">Số điện thoại</label>
                        <input type="tel" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại">
                    </div>

                    <div class="mb-3">
                        <label for="experience" class="form-label">Kinh nghiệm</label>
                        <textarea class="form-control" id="experience" name="experience" rows="3" placeholder="Nhập kinh nghiệm hướng dẫn"></textarea>
                    </div>

                    <div class="alert alert-info">
                        <i class="bi bi-info-circle"></i> Để đổi mật khẩu, liên hệ quản trị viên
                    </div>
                </div>
                <div class="card-footer">
                    <button type="submit" class="btn btn-warning">
                        <i class="bi bi-pencil"></i> Cập nhật
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
