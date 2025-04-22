<?php
include 'koneksi.php'; // Menghubungkan ke file koneksi.php

// Ambil data ID dari POST request
$id = $_POST['id'];

// Query untuk menghapus data penerima
$query = $pdo->prepare("DELETE FROM penerima WHERE id = ?");
$query->execute([$id]);

// Mengirim respon dalam format JSON
echo json_encode(["status" => "success", "message" => "Data penerima berhasil dihapus"]);
?>
