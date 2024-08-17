DROP DATABASE IF EXISTS asm1;
CREATE DATABASE asm1;
USE asm1;

CREATE TABLE `role` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(255)
);

CREATE TABLE `user` (
    id INT PRIMARY KEY  AUTO_INCREMENT,
    address VARCHAR(255),
    email VARCHAR(255),
    full_name VARCHAR(255),
    note VARCHAR(255),
    `password` VARCHAR(128),
    phone_number VARCHAR(255),
    `status` INT,
    user_name VARCHAR(255),
    created VARCHAR(255),
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES `role`(id)
);
CREATE TABLE donation (
    id INT PRIMARY KEY AUTO_INCREMENT,
    `code` VARCHAR(255),
    created VARCHAR(255),
    `description` VARCHAR(255),
    end_date VARCHAR(255),
    money INT,
    `name` VARCHAR(255),
    organization_name VARCHAR(255),
    phone_number VARCHAR(255),
    start_date VARCHAR(255),
    `status` INT	
);
CREATE TABLE user_donation (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    created VARCHAR(255),
    money INT,
    `name` VARCHAR(255),
    `status` INT,
    `text` VARCHAR(255),
    donation_id INT,
    user_id INT,
    FOREIGN KEY (donation_id) REFERENCES donation(id),
    FOREIGN KEY (user_id) REFERENCES `user`(id)
);
INSERT INTO `role` (role_name) VALUES ('admin');
INSERT INTO `role` (role_name) VALUES ('user');
INSERT INTO `user` (address, email, full_name, note, `password`, phone_number, `status`, user_name, created, role_id)
VALUES ('123 Main Stre	et', 'admin@example.com', 'Phạm Thành Đạt', 'Admin account', '123456', '123456789', 1, 'admin', NOW(), 1);
INSERT INTO `user` (address, email, full_name, note, `password`, phone_number, `status`, user_name, created, role_id)
VALUES ('123 Main Stre	et', 'vanlien@example.com', ' Nguyễn Văn Liên', 'Tài khoản', '123456', '123456789', 1, 'user', NOW(), 2);
INSERT INTO `user` (address, email, full_name, note, `password`, phone_number, `status`, user_name, created, role_id)
VALUES 
('456 Elm Street', 'thanhcong@example.com', 'Nguyễn Thành Công', 'User account', '123456', '987654321', 1, 'user2', NOW(), 2),
('789 Oak Street', 'nguyenlinh@example.com', 'Nguyễn Thị Linh', 'User account', '123456', '555555555', 0, 'user3', NOW(), 2),
('321 Pine Street', 'nguyenvan@example.com', 'Nguyễn Văn Vân', 'User account', '123456', '444444444', 1, 'user4', NOW(), 2),
('654 Maple Street', 'chithanh@example.com', 'Nguyễn Chí Thanh', 'User account', '123456', '333333333', 1, 'user5', NOW(), 2);


INSERT INTO donation (`code`, created, `description`, end_date, money, `name`, organization_name, phone_number, start_date, `status`)
VALUES ('VN2024001', '2024-07-03 14:00:00', 'Ủng hộ Việt Nam phòng chống dịch COVID-19', '2024-08-01', 10000000, 'Ủng hộ COVID-19', 'Tổ chức XYZ', '0987654321', '2024-07-01', 1);

INSERT INTO donation (`code`, created, `description`, end_date, money, `name`, organization_name, phone_number, start_date, `status`)
VALUES ('VN2024002', '2024-07-03 14:15:00', 'Quyên góp hỗ trợ nhân dân miền Trung lũ lụt 2024', '2024-08-10', 5000000, 'Hỗ trợ miền Trung lũ lụt', 'Tổ chức ABC', '0976543210', '2024-07-03', 0);

INSERT INTO donation (`code`, created, `description`, end_date, money, `name`, organization_name, phone_number, start_date, `status`)
VALUES ('VN2024003', '2024-07-03 14:30:00', 'Ủng hộ nông dân Việt Nam phát triển nông nghiệp bền vững', '2024-09-01', 8000000, 'Nông nghiệp bền vững', 'Tập đoàn XYZ', '0965432109', '2024-07-02', 1);

INSERT INTO donation (`code`, created, `description`, end_date, money, `name`, organization_name, phone_number, start_date, `status`)
VALUES ('VN2024004', '2024-07-03 14:45:00', 'Quyên góp hỗ trợ giáo dục cho trẻ em nghèo Việt Nam', '2024-09-15', 3000000, 'Hỗ trợ giáo dục trẻ em', 'Hiệp hội ABC', '0954321098', '2024-07-03', 1);

INSERT INTO donation (`code`, created, `description`, end_date, money, `name`, organization_name, phone_number, start_date, `status`)
VALUES ('VN2024005', '2024-07-03 15:00:00', 'Ủng hộ phòng chống biến đổi khí hậu tại Việt Nam', '2024-10-01', 12000000, 'Phòng chống biến đổi khí hậu', 'Tổ chức XYZ', '0943210987', '2024-07-01', 2);

INSERT INTO donation (`code`, created, `description`, end_date, money, `name`, organization_name, phone_number, start_date, `status`)
VALUES ('VN2024006', '2024-07-03 15:15:00', 'Quyên góp hỗ trợ phát triển cộng đồng dân cư vùng sâu vùng xa Việt Nam', '2024-11-01', 6000000, 'Hỗ trợ cộng đồng dân cư', 'Công ty ABC', '0932109876', '2024-07-02', 3);


INSERT INTO user_donation (created, money, `name`, `status`, `text`, donation_id, user_id)
VALUES ('2024-07-03 14:30:00', 500000, 'Nguyễn Văn A', 1, 'Đã quyên góp 500,000 VND cho chiến dịch ủng hộ COVID-19', 1, 1);

INSERT INTO user_donation (created, money, `name`, `status`, `text`, donation_id, user_id)
VALUES ('2024-07-03 14:35:00', 300000, 'Trần Thị B', 1, 'Đã quyên góp 300,000 VND cho chiến dịch hỗ trợ miền Trung lũ lụt', 1, 2);

INSERT INTO user_donation (created, money, `name`, `status`, `text`, donation_id, user_id)
VALUES ('2024-07-03 14:40:00', 700000, 'Phạm Văn C', 1, 'Đã quyên góp 700,000 VND cho chiến dịch nông nghiệp bền vững', 2, 2);

INSERT INTO user_donation (created, money, `name`, `status`, `text`, donation_id, user_id)
VALUES ('2024-07-03 14:45:00', 200000, 'Lê Thị D', 1, 'Đã quyên góp 200,000 VND cho chiến dịch giáo dục trẻ em', 3, 3);

INSERT INTO user_donation (created, money, `name`, `status`, `text`, donation_id, user_id)
VALUES ('2024-07-03 14:50:00', 1000000, 'Hoàng Văn E', 1, 'Đã quyên góp 1,000,000 VND cho chiến dịch phòng chống biến đổi khí hậu',4, 4);

INSERT INTO user_donation (created, money, `name`, `status`, `text`, donation_id, user_id)
VALUES ('2024-07-03 15:00:00', 1500000, 'Nguyễn Thị F', 1, 'Đã quyên góp 1,500,000 VND cho chiến dịch tái định cư người dân vùng lũ', 5, 5);

