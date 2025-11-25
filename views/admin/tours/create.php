<?php
startSession();
$pageTitle = 'Tạo Tour Mới';
$breadcrumb = [
    ['label' => 'Quản lý Tour', 'url' => BASE_URL . 'tour/index'],
    ['label' => 'Tạo Tour Mới', 'url' => BASE_URL . 'tour/create', 'active' => true],
];

ob_start();
?>
<div class="row">
    <div class="col-md-8 offset-md-2">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Tạo Tour Mới</h3>
            </div>
            <div class="card-body">
                <?php if (isset($_SESSION['error'])): ?>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-circle"></i> <?= $_SESSION['error'] ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <?php unset($_SESSION['error']); ?>
                <?php endif; ?>

                <form method="POST" action="<?= BASE_URL ?>tour/store">
                    <div class="mb-3">
                        <label for="name" class="form-label">Tên Tour <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="Nhập tên tour" required>
                    </div>

                    <div class="mb-3">
                        <label for="location" class="form-label">Vị trí <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="location" name="location" placeholder="Ví dụ: Hà Nội - Hạ Long" required>
                    </div>

                    <div class="mb-3">
                        <label for="price" class="form-label">Giá (VND) <span class="text-danger">*</span></label>
                        <input type="number" class="form-control" id="price" name="price" step="1000" min="0" placeholder="Nhập giá tour" required>
                    </div>

                    <div class="mb-3">
                        <label for="description" class="form-label">Mô tả <span class="text-danger">*</span></label>
                        <textarea class="form-control" id="description" name="description" rows="5" placeholder="Nhập mô tả chi tiết về tour" required></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="status" class="form-label">Trạng thái</label>
                        <select class="form-select" id="status" name="status">
                            <option value="1" selected>Hoạt động</option>
                            <option value="0">Không hoạt động</option>
                        </select>
                    </div>

                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <a href="<?= BASE_URL ?>tour/index" class="btn btn-secondary"><i class="bi bi-x"></i> Hủy</a>
                        <button type="submit" class="btn btn-primary"><i class="bi bi-plus-circle"></i> Tạo Tour</button>
                    </div>
                </form>
            </div>
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
