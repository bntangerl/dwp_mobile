<?php
include 'koneksi.php'; // Menghubungkan ke file koneksi.php

// Ambil data dari POST request
$nik = $_POST['nik'];
$nama = $_POST['nama'];
$email = $_POST['email'];
$no_telpon = $_POST['no_telpon'];
$jurusan_id = $_POST['jurusan_id'];
$jabatan_id = $_POST['jabatan_id'];

// Query untuk menambah data penerima
$query = $pdo->prepare("
    INSERT INTO penerima (nik, nama, email, no_telpon, jurusan_id, jabatan_id)
    VALUES (?, ?, ?, ?, ?, ?)
");

$query->execute([$nik, $nama, $email, $no_telpon, $jurusan_id, $jabatan_id]);

// Mengirim respon dalam format JSON
echo json_encode(["status" => "success", "message" => "Data penerima berhasil ditambahkan"]);
?>
