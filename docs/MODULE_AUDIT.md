# Audit teknis dan fungsional modul Sinaesta

**Tanggal verifikasi:** 3 September 2026
**Baseline:** branch `work`, commit `34fbd27`
**Cakupan:** SPA React/Vite, REST API PHP, schema dan seed MySQL, konfigurasi deploy, serta kesesuaian terhadap PRD 2.0.
**Metode:** inspeksi route dan aliran data, threat/integrity review, traceability terhadap requirement, `php -l`, dan production build Vite. Database integration, browser E2E, DAST, serta accessibility audit belum dapat diklaim karena harness-nya tidak tersedia.

## 1. Kesimpulan eksekutif

Sinaesta saat ini adalah **MVP Med parsial**, bukan platform empat produk yang didefinisikan PRD. Landing page dan jalur dasar register/login → pilih spesialisasi → kerjakan kuis → lihat hasil dapat dikompilasi. Riwayat, statistik per topik, edit nama profil, upload pembayaran, dan review pembayaran admin sudah memiliki endpoint dan UI minimal. TPA, SIMAK, LPDP, planner, daily practice, bookmark mutation, reset password, dan workflow editorial belum end-to-end.

**Keputusan rilis: NO-GO untuk production.** Ada lima blocker P0:

1. Tidak ada automated test atau bukti bahwa schema dan endpoint bekerja pada MySQL nyata.
2. Bukti pembayaran berisi PII disimpan di bawah document root dan proteksinya bergantung pada Apache `.htaccess`.
3. Akses berbayar bukan entitlement per produk dan tidak benar-benar menjadi gate; pengguna gratis dapat membuat kuis lima soal berulang tanpa kuota.
4. Attempt tidak menyimpan snapshot soal/opsi/aturan, sehingga hasil historis dapat berubah makna setelah konten diedit.

Build frontend **lulus**, tetapi menghasilkan warning chunk utama 681,59 kB. Dua berkas PHP juga **lulus syntax check**. Itu hanya memverifikasi parse/compile, bukan correctness runtime.

## 2. Skala prioritas

| Level | Definisi | Exit criteria |
|---|---|---|
| **P0** | Kebocoran data, integritas hasil/commerce, bypass akses, atau ketidakpastian runtime alur inti | Wajib selesai sebelum production |
| **P1** | Alur utama atau requirement `Must` tidak ada/rusak | Wajib selesai sebelum public beta |
| **P2** | Reliability, security hardening, maintainability, accessibility | Wajib selesai sebelum GA |
| **P3** | Efisiensi operasional dan UX lanjutan | Selesaikan setelah alur inti stabil |
| **Polish** | Konsistensi, microcopy, visual, dan optimasi minor | Iteratif |

## 3. Inventaris implementasi aktual

| Area | Backend | Frontend | Status nyata |
|---|---|---|---|
| Landing/marketing | Tidak diperlukan | Landing, demo lokal, portfolio, FAQ, harga | **Parsial-kuat**; sejumlah klaim/tautan belum ditopang fitur |
| Auth | Register, login, logout, `me` | Register/login/guard | **Parsial**; forgot-password salah sambung, verify/reset tidak ada |
| Katalog Med | List spesialisasi dan detail/topik | List dan detail | **Berfungsi dasar**; tanpa search/filter/pagination API |
| Quiz Med | Create, resume data, save answer, submit, result | Practice flow | **Berfungsi dasar**; tanpa timer enforcement, mode, snapshot, atau gate kuota |
| Dashboard | Agregat attempt dan trend | Cards/chart | **Parsial**; daily quiz hard-coded |
| History | GET maksimal 100 | List + link hasil | **Minimal**; tanpa pagination/filter |
| Statistics | Agregat per label topik/spesialisasi | List | **Minimal**; bukan analytics PRD |
| Bookmark | GET | List | **Tidak operasional**; tidak ada create/delete dari UI maupun API |
| Profile | PUT nama | Form nama | **Minimal**; tidak ada password, timezone, export/delete |
| Payment | GET/POST upload | Form + history | **Parsial-berisiko**; harga hard-coded dan model akses global |
| Admin | Counter, list/review/download bukti | Counter + payment review | **Minimal**; editorial/user/package belum ada |
| TPA/SIMAK/LPDP | Tidak ada | Marketing “dalam pengembangan” | **Belum ada** |
| Planner/daily/mastery | Tabel schema saja | Daily card hard-coded | **Belum berfungsi** |
| Legal/privacy | Tidak ada | Footer/checkbox tanpa dokumen | **Belum ada** |

Catatan penting: keberadaan tabel bukan bukti sebuah modul berfungsi. `daily_quizzes`, `user_mastery`, `review_schedules`, `question_versions`, `content_reviews`, dan `question_reports` belum memiliki service/endpoint/UI yang menghidupkan workflow tersebut.

## 4. Temuan P0 — release blockers

### P0-01 — Tidak ada test harness atau verifikasi database runtime

`package.json` hanya memiliki `dev`, `build`, dan `preview`; tidak ada `test`, lint, typecheck, atau CI. Backend tidak memiliki PHPUnit/API test. Karena MySQL server/client juga tidak disediakan sebagai bagian dev/CI, schema 36 baris yang padat dan seed belum terbukti dapat diimpor ulang dari database bersih.

**Risiko:** auth, CSRF, transaksi, foreign key, scoring, dan IDOR dapat regresi tanpa sinyal. Syntax/build yang lulus tidak mengeksekusi satu query pun.

**Perbaikan wajib:**

- Tambahkan migration runner bernomor dan container MySQL untuk test.
- Integration test alur register → login → create → answer → submit → result.
- Negative test untuk CSRF, IDOR antar-user, role admin, opsi dari soal lain, double submit, dan file upload.
- Test transaksi/race approval payment serta schema+seed smoke test di CI.

### P0-02 — Storage bukti pembayaran tidak privat secara portabel

File disimpan ke `backend/uploads/payment-proofs`, tepat di bawah document root yang direkomendasikan untuk PHP built-in server. Larangan akses hanya terdapat pada rewrite Apache. PHP built-in server, Nginx, CDN, atau konfigurasi yang salah tidak otomatis menerapkan `.htaccess`. Endpoint admin yang terotorisasi sudah tersedia, tetapi direct-file exposure tetap mungkin.

**Risiko:** bukti transfer yang mengandung nama, rekening, nominal, atau metadata pribadi dapat diakses bila URL acak bocor.

**Perbaikan wajib:** pindahkan ke direktori di luar web root/private object storage; simpan object key, enkripsi at-rest, scan malware, tetapkan retention/delete job, log setiap download, dan tambahkan test bahwa direct URL selalu 403/404 pada topology production.

### P0-03 — Entitlement/gating dapat dilewati dan commerce tidak dapat diaudit per produk

Server memakai satu enum `users.access_status`. Status itu hanya menentukan ukuran kuis (20 untuk `full`, 5 selainnya); tidak ada kuota harian/total sehingga akun gratis dapat membuat kuis lima soal tanpa batas. Tidak ada `product_id`, package, periode, entitlement, idempotency key, voucher, revoke history, atau effective pricing. Approval mengubah status global, sedangkan reject pembayaran mana pun mengubah user kembali menjadi `free`, termasuk bila pengguna pernah memiliki pembayaran approved lain.

Harga Rp50.000 sudah dipindahkan menjadi konstanta server pada INSERT, sehingga browser tidak lagi mengontrol nominal; namun UI dan server tetap hard-coded dan tidak terikat package/price version. Pembuatan payment dan perubahan status user juga bukan satu explicit transaction.

**Risiko:** kebocoran fitur premium, akses lintas-produk, downgrade keliru, audit/refund mustahil direkonstruksi, dan state parsial saat query kedua gagal.

**Perbaikan wajib:** buat `products`, `packages`, `prices`, `orders/payments`, dan `entitlements`; gate setiap capability di server; enforce kuota gratis atomik; gunakan payment number/idempotency key serta unique constraint; approval membuat entitlement tepat sekali dalam transaksi; reject tidak boleh mencabut entitlement lain.

### P0-04 — Attempt dan scoring tidak immutable

`quiz_attempt_questions` hanya menyimpan `question_id` dan posisi. Saat kuis dibuka/hasil dihitung, API membaca question dan option kanonik terkini. Tidak ada snapshot vignette, stem, opsi/urutan, jawaban benar, pembahasan, bobot, blueprint version, maupun scoring rule. Tabel `question_versions` tidak ditautkan ke attempt dan tidak digunakan endpoint.

**Risiko:** editor yang memperbaiki jawaban benar atau teks setelah attempt dimulai dapat mengubah skor dan arti histori; hasil tidak memenuhi BR-04/BR-05.

**Perbaikan wajib:** saat create, simpan satu version ID dan immutable presentation/scoring snapshot per item; score hanya dari snapshot; hasil historis membaca snapshot; publikasikan konten baru sebagai version baru, bukan overwrite.

### P0-05 — Topology backend production belum dapat direproduksi

Vercel config hanya membangun dan me-rewrite SPA ke `index.html`. API memerlukan PHP, MySQL, sticky/session storage, dan private persistent file storage, tetapi repository tidak menyediakan container/web-server config, migration job, health/readiness endpoint, secret validation, backup/restore runbook, atau smoke test deployment.

**Risiko:** frontend production dapat sehat sementara seluruh login/API gagal, session hilang, atau upload tidak persisten.

**Perbaikan wajib:** tetapkan platform backend, routing `/api`, TLS/cookie domain, shared session strategy, private storage, deploy migrations, health/readiness, backup/restore, rollback, dan post-deploy smoke test.

## 5. Temuan P1 — fungsi rusak atau belum lengkap

| ID | Modul | Temuan terverifikasi | Dampak |
|---|---|---|---|
| P1-01 | Forgot password | Route `/forgot-password` me-render komponen login biasa dan mengirim POST `/auth/login`. Tabel token ada tetapi request/reset endpoint tidak ada. | Fitur yang ditawarkan pasti tidak melakukan reset password. |
| P1-02 | Email verification | Token schema ada, tetapi register langsung membuat akun `active`; tidak ada send/verify/resend flow. | Kepemilikan email tidak pernah dibuktikan. |
| P1-03 | Quiz timer | UI menampilkan “N menit” statis, bukan countdown; API menerima answer/submit tanpa mengecek deadline. | Tryout/durasi tidak dapat dipercaya. |
| P1-04 | Quiz mode | Client mengirim `mode`, tetapi create selalu menyimpan `practice`; query `incorrect`, `bookmark`, daily, demo, dan tryout tidak diterapkan. | CTA “soal salah/topik terlemah” tidak mengubah pool. |
| P1-05 | Option order | Options selalu `ORDER BY label`; tidak ada shuffle/snapshot order per attempt. | Randomisasi presentasi dan konsistensi versi tidak tersedia. |
| P1-06 | Result detail | Result hanya memberi jawaban benar dan explanation; tidak memberi pilihan user/status tiap item, alasan opsi salah, referensi, objective, atau version. | Pengguna tidak dapat mereview kesalahan secara utuh. |
| P1-07 | Bookmark | Hanya endpoint GET. Tidak ada tombol add/remove saat quiz/result. | Halaman bookmark akan tetap kosong melalui penggunaan normal. |
| P1-08 | Daily practice | Dashboard selalu menampilkan `0 / 5`, streak `0`, progress 0%; tombol hanya menuju katalog. | Modul terlihat aktif tetapi seluruh metrik fiktif/hard-coded. |
| P1-09 | Error handling | Dashboard, katalog, detail, result, dan sejumlah mutation tidak menangani reject secara konsisten. Beberapa kegagalan menjadi loading tanpa akhir atau unhandled rejection. | Pengguna tidak tahu apakah perlu retry/login ulang. |
| P1-10 | Answer autosave | UI mengubah state sebelum POST sukses dan tidak rollback/menampilkan error; klik cepat tidak dikunci. | Jawaban terlihat tersimpan padahal request mungkin gagal atau balapan. |
| P1-11 | Payment consistency | Pemeriksaan “satu pending” hanya `COUNT` lalu INSERT tanpa unique constraint/transaction; request paralel dapat lolos. | Duplicate pending payment dan status ambigu. |
| P1-12 | Payment lifecycle | File tidak dihapus saat reject atau lewat retention; tidak ada replace/cancel/refund; admin note tidak diisi UI. | PII disimpan tanpa batas dan operasi commerce tidak lengkap. |
| P1-13 | Admin/editorial | Hanya payment review/counter. Tidak ada CRUD question, version, review segregation, publish, report, takedown, user, package, atau entitlement UI/API. | Konten tidak bisa dikelola dengan governance PRD. |
| P1-14 | Auth hardening | Rate limit hanya IP/login, tabel tidak dibersihkan otomatis, sukses tetap dicatat, dan tidak ada per-account limit, register/upload limit, idle/absolute expiry, atau periodic session rotation. | DoS NAT, table growth, credential stuffing, dan sesi panjang. |
| P1-15 | API method contract | Beberapa route seperti `/auth/me`, katalog, dan admin dashboard tidak membatasi method secara eksplisit. Method salah bisa mengembalikan sukses alih-alih 405. | Contract membingungkan dan mutation middleware sulit diaudit. |
| P1-16 | Produk PRD | TPA, SIMAK, LPDP, product switcher, diagnostic, planner, checklist, essay, interview, verified sources, dan contextual disclaimer belum ada. | Mayoritas requirement `Must` PRD belum diimplementasikan. |
| P1-17 | Legal/data rights | Tidak ada privacy, terms, consent record, report/takedown UI, export, delete/anonymize, retention policy, atau legal hold. Checkbox registrasi tidak menyimpan versi consent. | Risiko privacy/compliance dan consent tidak dapat dibuktikan. |

## 6. Temuan P2 — reliability, security, dan maintainability

1. **Front controller monolitik.** Seluruh API berada dalam satu file dengan route, SQL, validation, domain logic, dan response bercampur. Pisahkan middleware/router/controller/service/repository agar unit test mungkin dilakukan.
2. **Frontend monolitik dan source terkompres satu baris.** Hampir semua authenticated pages berada di `main.jsx`. Ini memperburuk review, blame, lint output, dan route-level code splitting.
3. **Bundle melewati budget.** Build menghasilkan JS utama 681,59 kB minified (201,56 kB gzip) dan warning Vite. Lazy-load halaman akun serta pisahkan Recharts/vendor.
4. **Tidak ada error boundary/request state standard.** Buat komponen loading/error/empty/retry konsisten, abort request saat unmount, dan tangani 401 global.
5. **Schema bukan migration chain.** Base table lalu `ALTER TABLE` dalam satu file tidak versioned, tidak idempotent, dan tidak punya rollback/status migration.
6. **`ORDER BY RAND()` tidak scalable.** Untuk pool besar, pilih kandidat terindeks lalu sampling deterministik/seeded agar bisa direkonstruksi.
7. **Constraint domain kurang.** Database tidak menjamin tepat satu correct option, topic berada pada specialty question yang sama, atau option jawaban cocok dengan question pada composite FK.
8. **Soft-delete tidak konsisten.** Detail specialty/topic count tidak selalu memfilter `deleted_at`; query bookmark memakai inner join topic sehingga data historis dapat hilang saat taxonomy berubah.
9. **Observability tidak ada.** Belum ada request ID, structured/redacted logs, error/latency metrics, auth audit lengkap, trace, alert, atau frontend monitoring.
10. **API contract belum formal.** Tidak ada OpenAPI, pagination envelope/cursor, 405 handling, enum/error catalog, versioning, atau documented proof-download route.
11. **Security headers belum lengkap.** Tambahkan CSP, Permissions-Policy, HSTS di edge, explicit no-store untuk respons user/admin, MIME download hardening, dan upload scanning.
12. **Input/data normalization belum seragam.** Nama/email memakai `strlen` byte-oriented, email tidak di-trim sebelum lower-case, dan exception register apa pun dilabeli “email sudah digunakan”.
13. **Accessibility belum diverifikasi.** Native `confirm/prompt`, focus after navigation/error, drawer focus trap, chart text alternative, tab keyboard behavior, contrast, dan target size perlu diuji WCAG 2.2 AA.
14. **Dependency/release hygiene.** Tidak ada committed root lockfile yang terlihat, Renovate/Dependabot, SCA, secret scan, SAST, SBOM, atau reproducible CI install.

## 7. P3 dan polish

- Tambahkan breadcrumbs, contextual page title, not-found page, dan jangan redirect diam-diam semua URL tidak dikenal ke landing.
- Gunakan formatter tanggal/uang/skor/timezone terpusat; translation map semua enum admin/user.
- Tampilkan countdown server-synchronized, autosave indicator, navigator soal, unanswered warning, dan status submit yang idempoten.
- Perbaiki chart empty-state dan sediakan tabel/summary tekstual untuk screen reader.
- Ambil rekening, nominal, package, SLA verifikasi, serta instruksi transfer dari settings/version server—bukan copy hard-coded.
- Ganti dialog browser dengan accessible modal yang mengunci double action dan mengembalikan fokus.
- Tambahkan meta title/description/canonical per route, manifest hanya bila strategi PWA disetujui.
- Tetapkan performance budget CI, prefetch seperlunya, lazy-load route, dan hapus dependency/import tak terpakai.
- Format source dengan ESLint/Prettier/PHP-CS-Fixer versi terkunci agar review dan coverage lebih bermakna.
- Ubah link legal/footer menjadi route nyata atau sembunyikan sampai kontennya tersedia.

## 8. Traceability PRD tingkat produk

| Requirement group | Status | Bukti/gap utama |
|---|---|---|
| FR-001–005 platform, taxonomy, snapshot | **Merah** | Akun ada; product entitlement, hierarchy lintas produk, shared mapping, blueprint version/snapshot tidak ada |
| FR-006 Med | **Kuning** | Practice/history/basic stats ada; tryout, bookmark mutation, detailed review belum ada |
| FR-007 TPA | **Merah** | Tidak ada domain/API/UI |
| FR-008 SIMAK | **Merah** | Tidak ada domain/API/UI |
| FR-009–012 LPDP | **Merah** | Tidak ada checklist/SBS/essay/interview/privacy media |
| FR-013 planner/daily | **Merah** | Schema parsial dan UI hard-coded, tanpa workflow |
| FR-014 commerce | **Merah** | Payment manual ada; package/price/voucher/entitlement tidak ada |
| FR-015–016 governance | **Merah** | Beberapa tabel ada; source verification/editorial/report workflow tidak aktif |
| FR-017 data rights | **Merah** | Export/delete/anonymize belum ada |
| FR-018 AI assist | **Ditunda sesuai PRD** | Tidak boleh dikerjakan sebelum governance |

Estimasi readiness berbasis requirement `Must` bersifat **rendah**: hanya sebagian FR-006 yang dapat didemonstrasikan end-to-end. Jangan memakai banyaknya tabel atau kelengkapan landing sebagai persentase completion produk.

## 9. Urutan remediation yang disarankan

### Sprint 0 — hentikan risiko (P0)

1. Pindahkan private upload dan tutup direct access di topology nyata.
2. Implementasikan product/package/price/entitlement dan server-side capability gate.
3. Tambahkan immutable attempt snapshot dan scoring dari snapshot.
4. Sediakan MySQL test environment, migration runner, CI, dan integration suite.
5. Dokumentasikan serta otomatisasi backend deployment/health/backup/restore.

### Sprint 1 — selesaikan Med beta (P1)

1. Reset/verification auth, session lifecycle, dan rate limits.
2. Timer server-side, mode incorrect/bookmark, bookmark CRUD, detailed result, robust autosave.
3. Daily practice nyata, history pagination, mastery/statistics, profile/timezone.
4. Payment idempotency/lifecycle dan admin package/entitlement.
5. Error/empty/retry states dan 401 handling menyeluruh.

### Sprint 2 — governance dan operasi

1. Editorial/version/review/report/takedown workflow.
2. Privacy/terms/consent/data export/delete/retention.
3. OpenAPI, observability, security headers, scans, accessibility, load test.

### Sprint 3+ — ekspansi platform

Bangun hierarchy dan blueprint lintas produk lebih dahulu, lalu TPA → SIMAK → LPDP. Jangan menduplikasi bank soal; gunakan mapping eligibility dan snapshot berversi. Fitur AI tetap post-MVP sampai privacy, rubric, provenance, evaluation, dan human oversight disetujui.

## 10. Quality gate sebelum status production

- Seluruh P0 ditutup dengan test otomatis, bukan hanya review manual.
- Schema dapat dimigrate dari kosong dan dari versi sebelumnya; rollback/restore terbukti.
- Auth/quiz/payment/entitlement lulus happy path, CSRF, IDOR, role, race, replay, dan failure-injection test.
- Direct upload URL tidak dapat diakses; retention/delete dan audit download terbukti.
- Tidak ada route/promosi yang menyatakan fitur aktif jika hanya placeholder.
- WCAG 2.2 AA, mobile/browser matrix, performance budget, SCA/SAST/DAST/secret scan, dan penetration test selesai.
- Dashboard/alert mencakup 5xx, latency, auth anomaly, payment failure, DB/session/storage saturation, serta backup freshness.

## 11. Pemeriksaan yang dijalankan

| Perintah | Hasil |
|---|---|
| `php -l backend/config/bootstrap.php` | Lulus, tidak ada syntax error |
| `php -l backend/index.php` | Lulus, tidak ada syntax error |
| `npm run build` | Lulus; warning chunk utama >500 kB |
| Inspeksi route/schema/PRD dengan `rg`, `find`, `sed`, dan `nl` | Selesai |
| Import schema/seed ke MySQL | Belum dijalankan; binary/server MySQL tidak tersedia di environment audit |
| Browser E2E/API integration/a11y/DAST | Belum dijalankan; harness tidak ada di repository |

Audit ini sengaja membedakan **“source tersedia”**, **“compile/lint lulus”**, dan **“fitur terbukti bekerja end-to-end”**. Hanya kategori terakhir yang layak dipakai sebagai klaim kesiapan rilis.
