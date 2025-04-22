<?php
include 'koneksi.php'; // Menghubungkan ke file koneksi.php

// Ambil data dari POST request
$id = $_POST['id'];
$nik = $_POST['nik'];
$nama = $_POST['nama'];
$email = $_POST['email'];
$no_telpon = $_POST['no_telpon'];
$jurusan_id = $_POST['jurusan_id'];
$jabatan_id = $_POST['jabatan_id'];

// Query untuk update data penerima
$query = $pdo->prepare("
    UPDATE penerima
    SET nik = ?, nama = ?, email = ?, no_telpon = ?, jurusan_id = ?, jabatan_id = ?
    WHERE id = ?
");

$query->execute([$nik, $nama, $email, $no_telpon, $jurusan_id, $jabatan_id, $id]);

// Mengirim respon dalam format JSON
echo json_encode(["status" => "success", "message" => "Data penerima berhasil diupdate"]);
?>
