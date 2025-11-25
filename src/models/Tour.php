<?php

class Tour
{
    private $conn;
    public $id;
    public $name;
    public $description;
    public $price;
    public $location;
    public $status;

    public function __construct($data = [])
    {
        $this->conn = getDB();
        if (is_array($data)) {
            $this->id = $data['id'] ?? null;
            $this->name = $data['name'] ?? '';
            $this->description = $data['description'] ?? '';
            $this->price = $data['price'] ?? 0;
            $this->location = $data['location'] ?? '';
            $this->status = $data['status'] ?? 1;
        }
    }

    public function all()
    {
        $stmt = $this->conn->prepare("SELECT * FROM tours ORDER BY id DESC");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function find($id)
    {
        $stmt = $this->conn->prepare("SELECT * FROM tours WHERE id = ?");
        $stmt->execute([$id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function create($data)
    {
        $stmt = $this->conn->prepare(
            "INSERT INTO tours (name, description, price, location, status)
            VALUES (?, ?, ?, ?, ?)"
        );
        return $stmt->execute([
            $data['name'] ?? '',
            $data['description'] ?? '',
            $data['price'] ?? 0,
            $data['location'] ?? '',
            $data['status'] ?? 1
        ]);
    }

    public function update($id, $data)
    {
        $stmt = $this->conn->prepare("UPDATE tours SET name=?, description=?, price=?, location=?, status=? WHERE id=?");
        return $stmt->execute([
            $data['name'] ?? '',
            $data['description'] ?? '',
            $data['price'] ?? 0,
            $data['location'] ?? '',
            $data['status'] ?? 1,
            $id
        ]);
    }

    public function delete($id)
    {
        $stmt = $this->conn->prepare("DELETE FROM tours WHERE id = ?");
        return $stmt->execute([$id]);
    }
}