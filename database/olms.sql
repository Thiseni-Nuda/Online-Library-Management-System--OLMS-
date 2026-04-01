-- =====================================================================================
--  OLMS MASTER DATABASE SCHEMA CHEAT SHEET
-- Use this as a reference for your PHP INSERT, UPDATE, and SELECT queries!
-- =====================================================================================
-- 
-- TABLE: users
-- id             INT             Primary Key, Auto Increment
-- username       VARCHAR(50)     The user's display name
-- email          VARCHAR(100)    Used for login and profile display
-- password       VARCHAR(255)    Hashed password (never plain text)
-- role           ENUM            'admin' or 'member' (Defaults to 'member')
-- created_at     DATETIME        Defaults to CURRENT_TIMESTAMP
-- 
-- TABLE: books
-- id             INT             Primary Key, Auto Increment
-- title          VARCHAR(255)    Book title
-- author         VARCHAR(255)    Book author
-- category       VARCHAR(100)    Genre (e.g., Fiction, Science)
-- cover_image    VARCHAR(255)    Filename (Defaults to 'default-cover.jpg')
-- total_qty      INT             Absolute total copies the library owns
-- available_qty  INT             Copies currently sitting on the shelf
--
-- TABLE: transactions
-- id             INT             Primary Key, Auto Increment
-- user_id        INT             Foreign Key: ID of the borrowing user
-- book_id        INT             Foreign Key: ID of the borrowed book
-- borrow_date    DATETIME        Defaults to CURRENT_TIMESTAMP
-- due_date       DATETIME        Calculated by PHP (e.g., borrow_date + 14 days)
-- returned_date  DATETIME        Null until the return is processed
-- status         ENUM            'active' or 'returned' (Defaults to 'active')
-- 
-- TABLE: reviews
-- id             INT             Primary Key, Auto Increment
-- book_id        INT             Foreign Key: ID of the book being reviewed
-- user_id        INT             Foreign Key: ID of the user leaving the review
-- rating         INT             Number between 1 and 5
-- comment        TEXT            The written review content
-- created_at     DATETIME        Defaults to CURRENT_TIMESTAMP
-- =====================================================================================

--------------------------------------------------------
-- OLMS Master Database Structure
-- Import this file into phpMyAdmin to set up your local database.
-- This is the first version code for testing. Will update the proper code later
-- --------------------------------------------------------
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;

-- 1. Create the `users` table
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','member') DEFAULT 'member',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Inject a default Admin user so the team can log in!
-- Note: The password hash below is for the word: password123
INSERT INTO `users` (`username`, `email`, `password`, `role`) VALUES
('admin', 'admin@library.com', '$2y$10$x.0rVwP9B2U.Yt8A/.Qo.O1p/w9V1s3jHj8L3xG2m9a0U/V7n/1mO', 'admin');

-- 2. Create the `books` table
CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `cover_image` varchar(255) DEFAULT 'default-cover.jpg',
  `total_qty` int(11) NOT NULL DEFAULT 0,
  `available_qty` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Create the `transactions` table (For borrows and returns)
CREATE TABLE `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `borrow_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `due_date` datetime DEFAULT NULL,
  `returned_date` datetime DEFAULT NULL,
  `status` enum('active','returned') DEFAULT 'active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Create the `reviews` table
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) DEFAULT 5,
  `comment` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

COMMIT;
