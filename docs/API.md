# REST API

Semua respons berbentuk `{success,message,data,errors}`. Endpoint terlindungi memakai cookie session dan mutasi memakai `X-CSRF-Token`. Client harus mengirim credentials.

## Endpoint

- Auth: `POST /api/auth/register`, `POST /api/auth/login`, `POST /api/auth/logout`, `GET /api/auth/me`.
- Katalog: `GET /api/specialties`, `GET /api/specialties/{slug}`.
- Belajar: `POST /api/quizzes`, `GET /api/quizzes/{id}`, `POST /api/quizzes/{id}/answers`, `POST /api/quizzes/{id}/submit`, `GET /api/quizzes/{id}/result`, `GET /api/dashboard`.
- Pembayaran: `GET|POST /api/payments` (POST multipart dengan `sender_name`, `bank`, `transfer_date`, `amount`, `proof`).
- Admin: `GET /api/admin/dashboard`, `GET /api/admin/payments`, `POST /api/admin/payments/{id}/approve`, `POST /api/admin/payments/{id}/reject` (`reason` wajib saat menolak).

IDOR dicegah dengan memadankan `user_id` pada resource kuis/pembayaran; admin endpoint memerlukan role admin. Submit dan review pembayaran menggunakan transaksi serta row lock.
