-- =====================================================================================
-- TEAM INSTRUCTIONS: 
-- Write your INSERT INTO `users` sql queries below this line.
-- Do NOT write any CREATE TABLE commands here.
-- =====================================================================================

-- 01_users_seed.sql
-- DO NOT change olms.sql, only run this seed file

INSERT INTO users (username, email, password, role) 
VALUES 
('Admin User', 'admin@olms.com', '$2y$10$wH8QxYyQJx8l7GzK6q5zKe6z0w8Qwz3v9l8Jp7kGqZ6m9YFQZr1Hy', 'admin'),
('Test Student', 'student@olms.com', '$2y$10$wH8QxYyQJx8l7GzK6q5zKe6z0w8Qwz3v9l8Jp7kGqZ6m9YFQZr1Hy', 'student');