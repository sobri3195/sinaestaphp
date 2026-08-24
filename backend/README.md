# Backend Sinaesta

## Instalasi cPanel/VPS

Gunakan PHP 8.2+, ekstensi PDO MySQL, fileinfo, dan MySQL 8/MariaDB modern. Arahkan document root subdomain API ke folder `backend`, salin `.env.example` ke `.env`, isi rahasia hanya pada server, lalu impor `database/schema.sql` dan `database/seed.sql`. Pastikan `uploads/payment-proofs` writable oleh PHP dan tidak public; `.htaccess` menolak akses langsung.

Untuk production set `APP_ENV=production`, `APP_URL`, `FRONTEND_URL=https://sinaesta.id`, cookie domain, dan HTTPS. CORS menerima daftar origin dari `FRONTEND_URL`, bukan wildcard. Setelah deploy, hapus akun/data demo, ganti informasi rekening, buat admin dengan hash hasil `php -r "echo password_hash('kata-sandi-kuat', PASSWORD_DEFAULT);"`, serta backup database harian.

## Checklist production

- HTTPS dan Secure/HttpOnly/SameSite=None aktif; document root dan rewrite benar.
- `.env`, upload, backup, dan log tidak dapat diakses web.
- Kredensial DB least-privilege; akun demo dihapus; display errors mati.
- Uji CORS, CSRF, rate limit, upload MIME/ukuran, restore backup, dan approval pembayaran.
- Jadwalkan cron harian untuk menghapus token kedaluwarsa serta login attempts lama bila volume meningkat.
