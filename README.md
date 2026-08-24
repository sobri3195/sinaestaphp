# Sinaesta

Platform latihan soal dokter spesialis dengan React/Vite dan REST API PHP native/MySQL. Arsitektur memisahkan SPA (`frontend`) dari API session-cookie (`backend`). Data soal, nilai, akses, pembayaran, dan metrik tersimpan di database; jawaban benar baru dikirim endpoint hasil setelah attempt disubmit.

## Struktur

- `frontend/src`: router, halaman, komponen UI, auth context, Axios ber-credentials.
- `backend/index.php`: front controller REST; bootstrap, CORS, session, CSRF, validasi dan PDO berada di modul konfigurasi.
- `backend/database`: skema relasional dan seed 29 spesialisasi, 58 topik, 20 soal.
- `backend/uploads/payment-proofs`: penyimpanan privat bukti pembayaran.

## Development lokal

1. Buat database: `mysql -u root -p -e 'CREATE DATABASE sinaesta CHARACTER SET utf8mb4'`.
2. Impor: `mysql -u root -p sinaesta < backend/database/schema.sql` lalu `mysql -u root -p sinaesta < backend/database/seed.sql`.
3. Salin `backend/.env.example` menjadi `backend/.env`, isi kredensial lokal.
4. Jalankan `php -S localhost:8000 -t backend`.
5. Salin `frontend/.env.example` menjadi `frontend/.env`; jalankan `cd frontend && npm install && npm run dev`.

Seed lokal menggunakan password `password` untuk `admin@sinaesta.test`, `user@sinaesta.test`, dan `full@sinaesta.test`. Hapus akun seed dan buat kredensial unik sebelum production.

Lihat [PRD terpadu Sinaesta](docs/PRD.md), [panduan backend](backend/README.md),
[frontend](frontend/README.md), dan [endpoint API](docs/API.md).

## Deploy frontend ke Vercel

Import repository dari root proyek. Konfigurasi root `vercel.json` akan memasang workspace npm, menjalankan build Vite di `frontend`, memublikasikan `frontend/dist`, dan mengarahkan route SPA ke `index.html`. Jangan mengganti Build Command menjadi `vite build`; gunakan konfigurasi repository (`npm run build`) agar dependency lokal Vite terpasang sebelum build.
