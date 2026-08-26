# Audit modul Sinaesta

**Tanggal audit:** 26 Agustus 2026  
**Cakupan:** source frontend React/Vite, REST API PHP, skema/seed MySQL, dokumentasi, konfigurasi build/deploy.  
**Metode:** inspeksi statis terhadap route, aliran data, otorisasi, integritas transaksi, dan pemetaan implementasi terhadap PRD; build produksi dan lint PHP. Audit ini bukan pengganti integration test dengan MySQL, DAST, accessibility audit, atau penetration test.

## Ringkasan eksekutif

Repository saat ini adalah **MVP parsial Sinaesta Med**, bukan implementasi PRD 2.0 secara penuh. Landing page, autentikasi dasar, katalog spesialisasi/topik, latihan sederhana, hasil, dashboard agregat, unggah pembayaran, dan statistik admin dasar sudah memiliki implementasi. TPA, SIMAK, LPDP, blueprint/version snapshot, planner, daily practice nyata, bookmark, riwayat, statistik detail, profil, reset password, dan workflow admin/editor belum end-to-end.

Status rilis yang disarankan: **belum layak production**. Tidak ada automated test, migrasi database masih berupa satu berkas schema yang mencampur `CREATE TABLE` dan `ALTER TABLE`, konfigurasi deployment backend belum tersedia, serta beberapa kontrol keamanan dan integritas commerce masih belum lengkap.

Perbaikan langsung dalam audit ini:

1. Pembuatan kuis kini memvalidasi ID dan menolak pool kosong, sehingga tidak membuat attempt kosong yang kemudian merusak UI.
2. Route answer/submit/result kini dibatasi ke HTTP method yang didokumentasikan.
3. Perhitungan hasil kini membedakan jawaban salah dengan soal yang tidak dijawab.

## Definisi prioritas

| Level | Arti | Target |
|---|---|---|
| P0 | Risiko keamanan/data loss, alur utama mustahil dipakai, atau hasil inti salah | Blokir rilis; perbaiki segera |
| P1 | Requirement Must atau alur bisnis utama tidak lengkap | Sebelum beta publik |
| P2 | Ketahanan, maintainability, observability, aksesibilitas | Sebelum general availability |
| P3 | Optimasi pengalaman dan operasional | Setelah alur inti stabil |
| Polish | Konsistensi visual/copy/performa minor | Iterasi berkelanjutan |

## Temuan P0 — release blockers

### P0-01 — Belum ada test harness dan database integration test

Tidak terdapat script `test`, unit test PHP, component test, maupun end-to-end test. Build dan lint hanya membuktikan source dapat dikompilasi, bukan bahwa schema dapat diimpor atau endpoint bekerja bersama MySQL. Alur register → login → membuat kuis → menjawab → submit → hasil dan payment approval wajib memiliki integration test, termasuk IDOR dan CSRF negatif.

**Dampak:** regresi auth, scoring, transaksi pembayaran, dan isolasi data pengguna tidak terdeteksi.  
**Selesai bila:** CI membuat database bersih, mengimpor schema/seed, menjalankan API test positif/negatif, frontend tests, dan build.

### P0-02 — Artefak unggahan berada di bawah document root backend

`uploads/payment-proofs` berada di bawah direktori yang juga dijadikan document root pada instruksi development. `.htaccess` hanya efektif pada Apache yang mengizinkan override; PHP built-in server, Nginx, atau konfigurasi Vercel tidak otomatis mematuhinya. Nama acak membantu tetapi bukan kontrol akses.

**Dampak:** bukti transfer yang mengandung PII berpotensi diakses langsung bila URL diketahui/bocor.  
**Perbaikan:** simpan di luar web root atau private object storage; unduh hanya melalui endpoint admin berotorisasi; tambahkan malware scanning, retention, penghapusan, audit download, dan uji bahwa direct URL selalu 404/403.

### P0-03 — Commerce mempercayai nominal dan metadata dari browser

Endpoint payment masih menerima `amount`, nama pengirim, bank, dan tanggal langsung dari request tanpa mengikatnya ke package/price efektif di server. Approval hanya mengubah `users.access_status`, belum menciptakan entitlement idempoten yang berversi sebagaimana PRD.

**Dampak:** nominal dapat dimanipulasi; approval ulang/race dan perubahan paket sulit direkonstruksi; satu status global tidak dapat mewakili akses beberapa produk.  
**Perbaikan:** client mengirim `package_id`; server mengambil harga aktif, membuat payment number/idempotency key, lalu approval mengunci payment dan membuat entitlement dalam transaksi yang sama.

### P0-04 — Belum ada immutable snapshot attempt

Attempt hanya mereferensikan question/options kanonik. Isi soal, pembahasan, jawaban benar, bobot, urutan pilihan, dan versi aturan tidak disalin saat attempt dibuat. Perubahan bank soal dapat mengubah makna hasil historis.

**Dampak:** audit hasil tidak dapat dipercaya dan melanggar BR-04/BR-05.  
**Perbaikan:** simpan blueprint/version serta snapshot presentation dan scoring per attempt; hasil membaca snapshot, bukan record terbaru.

### P0-05 — Deployment backend production belum terdefinisi

Konfigurasi Vercel membangun SPA, sedangkan API mengasumsikan PHP, MySQL, session cookie, dan filesystem writable/persisten. Tidak ada container/web-server config, health check, migration runner, secret manifest, backup/restore procedure, atau deployment topology backend.

**Dampak:** frontend production dapat hidup sementara login/API gagal total; filesystem serverless tidak cocok untuk bukti pembayaran.  
**Perbaikan:** tetapkan host PHP/MySQL dan private storage, routing `/api`, TLS/cookie domain, migration job, health/readiness endpoint, backup restore drill, dan smoke test pascadeploy.

## Temuan P1 — fungsi utama belum berfungsi/lengkap

| ID | Modul | Temuan dan kekurangan |
|---|---|---|
| P1-01 | Auth | `/forgot-password` memakai form login dan POST ke `/auth/login`; tabel token ada tetapi endpoint request/reset tidak ada. Verifikasi email juga hanya ada di schema. |
| P1-02 | Auth/security | Rate limit login hanya berdasarkan IP, tersimpan tanpa cleanup, tidak ada rate limit register/reset/upload, dan belum ada session idle/absolute timeout atau rotasi berkala. |
| P1-03 | Quiz resume | API tidak mengembalikan jawaban tersimpan; reload membuat pilihan tampak kosong walaupun jawaban sudah ada di database. |
| P1-04 | Quiz timer | UI hanya menampilkan durasi statis, bukan countdown; server tidak menegakkan expiry/duration. |
| P1-05 | Quiz options | `ORDER BY RAND()` dijalankan setiap GET, sehingga urutan pilihan berubah saat reload. Urutan tidak disnapshot. |
| P1-06 | Quiz modes | Parameter `mode` dari client diabaikan dan selalu disimpan `practice`; tryout, incorrect, bookmark, demo, review mark, dan daily quiz belum berjalan. |
| P1-07 | Results | Hasil belum menunjukkan jawaban pengguna, status benar/salah per soal, referensi, alasan opsi salah, atau snapshot versi. |
| P1-08 | Empty/error UX | Hampir semua `useEffect` hanya menangani sukses; kegagalan API menghasilkan loading tanpa akhir. Tombol start/payment juga belum konsisten mencegah double-submit. |
| P1-09 | User modules | History, statistics, bookmarks, dan profile adalah placeholder tanpa API/data nyata. Query string “soal salah/topik terlemah” tidak diproses. |
| P1-10 | Daily practice | Kartu dashboard berisi angka hard-coded `0 / 5` dan streak `0`; tabel `daily_quizzes` tidak dipakai endpoint. |
| P1-11 | Admin | UI hanya dashboard counter. Daftar/review pembayaran yang ada di API tidak punya UI; pengelolaan soal, reviewer, publish, report, user, price, dan audit belum ada. |
| P1-12 | Payment | Validasi server untuk field teks/tanggal/amount kurang; return value `move_uploaded_file` tidak diperiksa; file tidak dihapus saat transaksi DB gagal/reject/retention. |
| P1-13 | Entitlement | Model masih `users.access_status` global. Empat produk, masa aktif, revoke, source, package, voucher, dan histori entitlement belum dimodelkan. |
| P1-14 | Produk PRD 2.0 | TPA, SIMAK, LPDP, product switcher/dashboard, diagnostic, checklist, essay, interview, planner, sumber terverifikasi, dan disclaimer kontekstual belum diimplementasikan; landing menandainya masih dikembangkan. |
| P1-15 | Content model | Shared question bank many-to-many, fingerprint/similarity, blueprint version, exam hierarchy, approval segregation, expiry, source verification, copyright, dan change history belum memenuhi PRD. |
| P1-16 | Legal/privacy | Halaman privacy, terms, disclaimer, takedown, report question, trademark, academic integrity, export/delete user belum tersedia; link footer mayoritas `#`. |

## Temuan P2 — reliability dan maintainability

1. **Front controller monolitik:** seluruh backend berada dalam baris-baris sangat panjang di satu file. Pisahkan router, controller, service, repository, validator, middleware, dan error types agar bisa diuji.
2. **Frontend monolitik:** router dan hampir seluruh aplikasi akun berada di `main.jsx`; lazy-load baru digunakan pada visual landing. Pisahkan per route dan gunakan route-level code splitting.
3. **Bundle besar:** build menghasilkan bundle utama sekitar 667 kB minified. Recharts dan landing/account app sebaiknya menjadi chunk terpisah.
4. **Tidak ada state error/empty/retry standar:** buat request state component, error boundary aplikasi, cancellation pada unmount, dan notifikasi terakses screen reader.
5. **Schema bukan migration chain:** `ALTER TABLE` setelah definisi awal menyulitkan rerun/versioning dan rollback. Gunakan migration bernomor dan migration status table.
6. **Query scalability:** `ORDER BY RAND()` tidak scalable untuk bank soal besar; pilih kandidat dari indexed pool lalu sampling deterministik di application/SQL strategy.
7. **Observability:** belum ada request/correlation ID, structured log, latency/error metrics, audit login/logout, alert, atau error monitoring frontend.
8. **API contract:** tidak ada OpenAPI schema, pagination contract, enum/error catalog, atau versioning; endpoint catalog mengembalikan seluruh data.
9. **Database constraints:** belum ada constraint memastikan tepat satu opsi benar, topic milik specialty yang sama, dan selected option milik question pada constraint database.
10. **Security headers:** CSP, Permissions-Policy, HSTS pada edge, cache policy respons privat, dan upload response headers belum ditentukan.
11. **Secrets/config:** contoh `.env` yang dirujuk README tidak tampak dalam repository; startup tidak memvalidasi env wajib dan gagal dengan pesan generik saat DSN kosong.
12. **Accessibility:** perlu audit keyboard/focus menu/dropdown, dialog konfirmasi native, chart fallback tekstual, status async, contrast, dan target sentuh.

## P3 dan polish

- Tandai nav aktif, tambahkan breadcrumbs, skeleton yang stabil, retry, empty-state beraksi, dan terjemahan label enum.
- Format tanggal, uang, skor, dan zona waktu melalui satu utility locale; jangan merangkai `Rp` dengan nilai decimal mentah.
- Sinkronkan state payment setelah submit dan tampilkan detail rekening dari settings server, bukan copy statis.
- Pertahankan scroll/focus setelah navigasi, fokuskan error form pertama, dan tampilkan strength/help password.
- Tambahkan meta title/description per route, canonical, OG dinamis, manifest/PWA bila memang dibutuhkan.
- Optimalkan aset/chunk, preconnect hanya untuk origin yang digunakan, dan tetapkan performance budget CI.
- Hilangkan import/icon yang tidak dipakai dan format source dengan ESLint/Prettier/PHP-CS-Fixer yang dikunci versinya.
- Ganti link footer `#` dengan route valid atau sembunyikan sampai halaman tersedia.
- Tambahkan not-found page yang informatif; wildcard saat ini diam-diam mengalihkan semua URL ke landing.

## Matriks kesiapan modul

| Modul | Status | Catatan |
|---|---|---|
| Landing/marketing | Parsial-kuat | Visual lengkap; sebagian demo nonfungsional dan link legal kosong |
| Auth/session/CSRF | Parsial | Register/login/logout/me ada; reset/verify/lifecycle belum ada |
| Katalog Med | Parsial | List/detail ada; filter/pagination/search belum ada |
| Quiz Med | Parsial | Practice dasar ada; timer, resume, mode lain, snapshot belum ada |
| Result/analytics | Parsial | Skor dasar ada; pembahasan/personal analytics belum lengkap |
| Payment | Parsial-berisiko | Upload/review API ada; private storage dan entitlement belum aman/lengkap |
| Admin/editorial | Minimal | Counter dan API review payment; UI/workflow editorial tidak ada |
| User history/stat/bookmark/profile | Belum | Placeholder atau schema-only |
| Daily quiz/mastery/review | Belum | Schema-only/hard-coded UI |
| TPA | Belum | Marketing/PRD saja |
| SIMAK | Belum | Marketing/PRD saja |
| LPDP | Belum | Marketing/PRD saja |
| Planner/notification | Belum | Notification hanya dibuat saat payment review; tidak ada UI |
| Legal/privacy/data rights | Belum | Requirement terdokumentasi, implementasi belum ada |
| CI/CD/observability | Belum | Build config frontend saja |

## Urutan remediation yang direkomendasikan

1. **Sprint P0 security/data:** private upload storage, server-owned pricing + entitlement, immutable attempt snapshot, backend deployment topology.
2. **Sprint test foundation:** migration runner, seeded test DB, API integration suite untuk auth/quiz/payment/IDOR/CSRF, frontend route tests, CI gates.
3. **Sprint Med completion:** reset password, robust request states, resume/timer, history/statistics/bookmark/profile/daily quiz, admin payments/editorial.
4. **Sprint governance:** content versioning, reviewer segregation, report/takedown, legal pages, data export/delete, retention/audit.
5. **Sprint platform expansion:** product/program/version hierarchy, entitlement per product, blueprint engine; baru kemudian TPA → SIMAK → LPDP sesuai dependency PRD.
6. **Hardening/polish:** load/security/accessibility testing, observability/SLO, performance budget, UX consistency, production runbooks.

## Quality gates sebelum production

- Semua P0 ditutup dan threat model/payment privacy review disetujui.
- Automated test mencakup happy path dan akses negatif; khusus IDOR/entitlement/mentor/private upload harus 100% lulus.
- Restore backup, rollback migration, upload retention/delete, dan payment idempotency diuji.
- Tidak ada placeholder pada route yang dipromosikan; fitur belum ada diberi status eksplisit dan tidak dapat dibeli.
- WCAG audit, browser/mobile matrix, load test, dependency scan, secret scan, SAST/DAST, dan penetration test selesai.
- Dashboard alert untuk 5xx, auth anomaly, payment failure, queue/reminder failure, storage, DB saturation, serta SLO tersedia.
