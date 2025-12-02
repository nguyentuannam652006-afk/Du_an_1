<?php
startSession();
$pageTitle = 'Danh sách Hướng dẫn viên';
$breadcrumb = [
    ['label' => 'Quản lý Hướng dẫn viên', 'url' => BASE_URL . 'guide/index', 'active' => true],
];

ob_start();
?>
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Danh sách Hướng dẫn viên</h3>
                <div class="card-tools">
                    <a href="<?= BASE_URL ?>guide/create" class="btn btn-primary btn-sm">
                        <i class="bi bi-plus"></i> Thêm Hướng dẫn viên Mới
                    </a>
                </div>
            </div>
            <div class="card-body">
                <?php if (isset($_SESSION['success'])): ?>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle"></i> <?= $_SESSION['success'] ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <?php unset($_SESSION['success']); ?>
                <?php endif; ?>

                <?php if (isset($_SESSION['error'])): ?>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-circle"></i> <?= $_SESSION['error'] ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <?php unset($_SESSION['error']); ?>
                <?php endif; ?>

                <?php if (empty($guides)): ?>
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle"></i> Chưa có hướng dẫn viên nào. <a href="<?= BASE_URL ?>guide/create">Thêm hướng dẫn viên mới</a>
                    </div>
                <?php else: ?>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover table-bordered">
                            <thead class="table-dark">
                                <tr>
                                    <th style="width: 50px">ID</th>
                                    <th>Tên</th>
                                    <th>Email</th>
                                    <th style="width: 100px">Trạng thái</th>
                                    <th style="width: 150px">Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($guides as $guide): ?>
                                    <tr>
                                        <td><strong>#<?= htmlspecialchars($guide['id'] ?? '') ?></strong></td>
                                        <td><?= htmlspecialchars($guide['name'] ?? 'N/A') ?></td>
                                        <td><?= htmlspecialchars($guide['email'] ?? 'N/A') ?></td>
                                        <td>
                                            <?php if (($guide['status'] ?? 0) == 1): ?>
                                                <span class="badge bg-success"><i class="bi bi-check-circle"></i> Hoạt động</span>
                                            <?php else: ?>
                                                <span class="badge bg-danger"><i class="bi bi-x-circle"></i> Không hoạt động</span>
                                            <?php endif; ?>
                                        </td>
                                        <td>
                                            <a href="<?= BASE_URL ?>guide/edit?id=<?= htmlspecialchars($guide['id'] ?? '') ?>" class="btn btn-warning btn-sm" title="Sửa">
                                                <i class="bi bi-pencil"></i> Sửa
                                            </a>
                                            <a href="<?= BASE_URL ?>guide/delete?id=<?= htmlspecialchars($guide['id'] ?? '') ?>" class="btn btn-danger btn-sm" onclick="return confirm('Bạn chắc chắn muốn xóa hướng dẫn viên này?')" title="Xóa">
                                                <i class="bi bi-trash"></i> Xóa
                                            </a>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                <?php endif; ?>
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
