SET NAMES utf8mb4;
INSERT INTO users(name,email,password_hash,role,status,access_status,email_verified_at) VALUES
('Admin Lokal','admin@sinaesta.test','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.','admin','active','full',NOW()),
('Dokter Demo','user@sinaesta.test','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.','user','active','free',NOW()),
('Dokter Penuh','full@sinaesta.test','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.','user','active','full',NOW());
INSERT INTO specialties(id,name,slug,description,icon,color,is_active,display_order) VALUES
(1,'Anestesiologi','anestesiologi','pembiusan dan manajemen nyeri','stethoscope','#0284c7',1,1),
(2,'Bedah Plastik','bedah-plastik','rekonstruksi dan estetika','stethoscope','#0284c7',1,2),
(3,'Bedah Saraf','bedah-saraf','pembedahan sistem saraf','stethoscope','#0284c7',1,3),
(4,'Bedah Umum','bedah-umum','operasi berbagai organ','stethoscope','#0284c7',1,4),
(5,'Dermatologi dan Venereologi','dermatologi-dan-venereologi','kulit, rambut, kuku, dan penyakit kelamin','stethoscope','#0284c7',1,5),
(6,'Farmakologi Klinik','farmakologi-klinik','terapi farmakologis','stethoscope','#0284c7',1,6),
(7,'Kedokteran Forensik dan Medikolegal','kedokteran-forensik-dan-medikolegal','kedokteran forensik dan aspek medikolegal','stethoscope','#0284c7',1,7),
(8,'Gizi Klinik','gizi-klinik','nutrisi klinis','stethoscope','#0284c7',1,8),
(9,'Ilmu Kedokteran Masyarakat','ilmu-kedokteran-masyarakat','kesehatan populasi dan pencegahan','stethoscope','#0284c7',1,9),
(10,'Ilmu Kesehatan Anak','ilmu-kesehatan-anak','kesehatan bayi, anak, dan remaja','stethoscope','#0284c7',1,10),
(11,'Ilmu Penyakit Dalam','ilmu-penyakit-dalam','penyakit organ dalam dewasa','stethoscope','#0284c7',1,11),
(12,'Jantung dan Pembuluh Darah','jantung-dan-pembuluh-darah','kardiovaskular','stethoscope','#0284c7',1,12),
(13,'Kedokteran Fisik dan Rehabilitasi','kedokteran-fisik-dan-rehabilitasi','pemulihan fungsi pasien','stethoscope','#0284c7',1,13),
(14,'Kedokteran Keluarga','kedokteran-keluarga','pelayanan kesehatan komprehensif','stethoscope','#0284c7',1,14),
(15,'Kedokteran Okupasi','kedokteran-okupasi','kesehatan kerja','stethoscope','#0284c7',1,15),
(16,'Kedokteran Penerbangan','kedokteran-penerbangan','kesehatan penerbangan','stethoscope','#0284c7',1,16),
(17,'Mata','mata','kesehatan mata dan penglihatan','stethoscope','#0284c7',1,17),
(18,'Mikrobiologi Klinik','mikrobiologi-klinik','diagnosis mikroorganisme','stethoscope','#0284c7',1,18),
(19,'Neurologi','neurologi','sistem saraf','stethoscope','#0284c7',1,19),
(20,'Obstetri dan Ginekologi','obstetri-dan-ginekologi','kehamilan dan kesehatan reproduksi','stethoscope','#0284c7',1,20),
(21,'Onkologi Radiasi','onkologi-radiasi','terapi radiasi kanker','stethoscope','#0284c7',1,21),
(22,'Orthopaedi dan Traumatologi','orthopaedi-dan-traumatologi','sistem muskuloskeletal dan trauma','stethoscope','#0284c7',1,22),
(23,'Patologi Anatomi','patologi-anatomi','diagnosis jaringan','stethoscope','#0284c7',1,23),
(24,'Patologi Klinik','patologi-klinik','diagnostik laboratorium','stethoscope','#0284c7',1,24),
(25,'Psikiatri','psikiatri','kesehatan jiwa','stethoscope','#0284c7',1,25),
(26,'Pulmonologi dan Kedokteran Respirasi','pulmonologi-dan-kedokteran-respirasi','paru dan pernapasan','stethoscope','#0284c7',1,26),
(27,'Radiologi','radiologi','pencitraan medis','stethoscope','#0284c7',1,27),
(28,'THT-KL','tht-kl','telinga, hidung, tenggorok, kepala dan leher','stethoscope','#0284c7',1,28),
(29,'Urologi','urologi','saluran kemih dan reproduksi pria','stethoscope','#0284c7',1,29);
INSERT INTO topics(specialty_id,name,slug,difficulty,is_active,display_order) VALUES
(1,'Dasar Klinis','dasar-klinis','mixed',1,1),
(1,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(2,'Dasar Klinis','dasar-klinis','mixed',1,1),
(2,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(3,'Dasar Klinis','dasar-klinis','mixed',1,1),
(3,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(4,'Dasar Klinis','dasar-klinis','mixed',1,1),
(4,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(5,'Dasar Klinis','dasar-klinis','mixed',1,1),
(5,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(6,'Dasar Klinis','dasar-klinis','mixed',1,1),
(6,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(7,'Dasar Klinis','dasar-klinis','mixed',1,1),
(7,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(8,'Dasar Klinis','dasar-klinis','mixed',1,1),
(8,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(9,'Dasar Klinis','dasar-klinis','mixed',1,1),
(9,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(10,'Dasar Klinis','dasar-klinis','mixed',1,1),
(10,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(11,'Dasar Klinis','dasar-klinis','mixed',1,1),
(11,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(12,'Dasar Klinis','dasar-klinis','mixed',1,1),
(12,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(13,'Dasar Klinis','dasar-klinis','mixed',1,1),
(13,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(14,'Dasar Klinis','dasar-klinis','mixed',1,1),
(14,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(15,'Dasar Klinis','dasar-klinis','mixed',1,1),
(15,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(16,'Dasar Klinis','dasar-klinis','mixed',1,1),
(16,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(17,'Dasar Klinis','dasar-klinis','mixed',1,1),
(17,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(18,'Dasar Klinis','dasar-klinis','mixed',1,1),
(18,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(19,'Dasar Klinis','dasar-klinis','mixed',1,1),
(19,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(20,'Dasar Klinis','dasar-klinis','mixed',1,1),
(20,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(21,'Dasar Klinis','dasar-klinis','mixed',1,1),
(21,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(22,'Dasar Klinis','dasar-klinis','mixed',1,1),
(22,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(23,'Dasar Klinis','dasar-klinis','mixed',1,1),
(23,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(24,'Dasar Klinis','dasar-klinis','mixed',1,1),
(24,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(25,'Dasar Klinis','dasar-klinis','mixed',1,1),
(25,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(26,'Dasar Klinis','dasar-klinis','mixed',1,1),
(26,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(27,'Dasar Klinis','dasar-klinis','mixed',1,1),
(27,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(28,'Dasar Klinis','dasar-klinis','mixed',1,1),
(28,'Kegawatdaruratan','kegawatdaruratan','hard',1,2),
(29,'Dasar Klinis','dasar-klinis','mixed',1,1),
(29,'Kegawatdaruratan','kegawatdaruratan','hard',1,2);
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(1,1,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 1 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(2,3,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 2 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(3,5,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 3 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(4,7,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 4 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(5,9,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 5 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(6,11,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 6 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(7,13,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 7 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(8,15,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 8 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(9,17,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 9 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(10,19,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 10 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(1,1,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 11 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(2,3,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 12 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(3,5,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 13 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(4,7,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 14 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(5,9,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 15 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(6,11,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 16 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(7,13,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 17 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(8,15,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 18 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(9,17,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 19 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO questions(specialty_id,topic_id,vignette,stem,explanation,learning_objective,pearl,difficulty,status,creator_id,reviewer_id) VALUES(10,19,'Pasien dewasa datang ke layanan kesehatan dengan keluhan utama yang berkembang progresif dan memerlukan penilaian klinis sistematis. Tanda vital stabil dan pemeriksaan awal telah dilakukan.','Langkah penatalaksanaan berbasis bukti yang paling tepat pada kasus 20 adalah?','Pilihan B merupakan langkah paling tepat berdasarkan urutan asesmen, stabilisasi, dan konfirmasi diagnosis. Selalu sesuaikan keputusan dengan kondisi individual pasien dan pedoman terbaru.','Menentukan prioritas asesmen dan tata laksana klinis.','Utamakan keselamatan pasien dan pendekatan terstruktur.','medium','published',1,1);
SET @qid=LAST_INSERT_ID();
INSERT INTO question_options(question_id,label,option_text,is_correct) VALUES(@qid,'A','Observasi tanpa evaluasi lanjutan',0),(@qid,'B','Lakukan asesmen terarah dan pemeriksaan penunjang sesuai indikasi',1),(@qid,'C','Berikan terapi definitif tanpa konfirmasi',0),(@qid,'D','Tunda seluruh penanganan',0),(@qid,'E','Pulang tanpa edukasi',0);
INSERT INTO question_references(question_id,title,authors,publication_year,url) VALUES(@qid,'Pedoman Praktik Klinis Indonesia','Kementerian Kesehatan RI',2024,'https://www.kemkes.go.id/');
INSERT INTO settings(setting_key,setting_value,is_public)VALUES('price','50000',1),('demo_question_limit','5',1),('tryout_question_count','20',1),('bank_account','BCA 1234567890 a.n. Sinaesta',1);
INSERT INTO quiz_attempts(user_id,specialty_id,topic_id,mode,status,total_questions,duration_minutes,correct_count,incorrect_count,score,duration_seconds,started_at,submitted_at)VALUES(3,1,1,'practice','submitted',5,10,4,1,80,480,DATE_SUB(NOW(),INTERVAL 2 DAY),DATE_SUB(NOW(),INTERVAL 2 DAY));
INSERT INTO payments(user_id,sender_name,bank,transfer_date,amount,proof_path,status)VALUES(2,'Dokter Demo','BCA',CURDATE(),50000,'example-local-only.jpg','rejected'),(3,'Dokter Penuh','Mandiri',CURDATE(),50000,'example-approved-local.jpg','approved');