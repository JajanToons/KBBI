CREATE DATABASE waterfist_db;

USE waterfist_db;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role ENUM('pemadam', 'trainer', 'admin') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE schedules (
    id INT PRIMARY KEY AUTO_INCREMENT,
    date DATE NOT NULL,
    time TIME NOT NULL,
    duration INT NOT NULL,
    description TEXT NOT NULL,
    status ENUM('Sudah', 'Belum') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    judul VARCHAR(255) NOT NULL,
    deskripsi TEXT NOT NULL,
    tanggal DATE NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE aktif_akun (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    role VARCHAR(20) NOT NULL,
    session_id VARCHAR(255) NOT NULL,
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_pemadam (role)  -- Membatasi hanya satu akun 'pemadam' bisa login
);

ALTER TABLE aktif_akun ADD COLUMN last_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;


CREATE TABLE device_status (
    id INT PRIMARY KEY,
    status VARCHAR(10),
    direction VARCHAR(10),
    speed INT
);
ALTER TABLE device_status 
ADD COLUMN battery_level INT DEFAULT 0,
ADD COLUMN water_level INT DEFAULT 0;

INSERT INTO device_status (id, status, direction, speed) VALUES (1, 'off', 'center', 50);

CREATE TABLE trainer_access (
    id INT PRIMARY KEY AUTO_INCREMENT,
    trainer_id INT NOT NULL,
    approved_by_pemadam TINYINT(1) DEFAULT 0,
    FOREIGN KEY (trainer_id) REFERENCES users(id) ON DELETE CASCADE
);
ALTER TABLE trainer_access ADD COLUMN last_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP;