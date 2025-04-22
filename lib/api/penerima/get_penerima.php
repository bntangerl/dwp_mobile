<?php
include 'koneksi.php'; // Menghubungkan ke file koneksi.php

// Query untuk mengambil semua data penerima beserta nama jurusan dan jabatan
$query = $pdo->prepare("
    SELECT p.id, p.nik, p.nama, p.email, p.no_telpon, j.nama_jurusan, jb.nama_jabatan
    FROM penerima p
    LEFT JOIN jurusan j ON p.jurusan_id = j.id
    LEFT JOIN jabatan jb ON p.jabatan_id = jb.id
");
$query->execute();

$penerima = $query->fetchAll(PDO::FETCH_ASSOC);

// Mengirim data dalam format JSON
echo json_encode($penerima);
?>
