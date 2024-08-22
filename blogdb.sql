-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 22, 2024 at 08:48 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blogdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `Posts`
--

CREATE TABLE `Posts` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Posts`
--

INSERT INTO `Posts` (`id`, `title`, `content`, `createdAt`, `updatedAt`, `thumbnail`) VALUES
(43, 'Belajar Bahasa Pemrograman C++', '<p>C++ adalah bahasa yang bisa digunakan untuk membuat berbagai aplikasi. Misalnya, aplikasi pengolah gambar, software gadget, game, hingga sistem operasi baru.</p>\r\n<p>&nbsp;</p>\r\n<p>berikut contoh sintaks C++</p>\r\n<pre class=\"language-cpp\"><code>#include &lt;iostream&gt;\r\nusing namespace std;\r\n\r\nint main() {\r\n  cout &lt;&lt; \"Hello World!\";\r\n  return 0;\r\n}</code></pre>\r\n<p>pada kode diatas terlihat cara menampilkan <span style=\"background-color: rgb(22, 145, 121);\">\"hello world\"</span> di console</p>\r\n<ol>\r\n<li>ini hanya contoh ok</li>\r\n<li>ini juga hanya contoh ok</li>\r\n</ol>', '2024-08-22 05:52:49', '2024-08-22 05:58:40', 'https://code.visualstudio.com/assets/docs/languages/cpp/msg-intellisense.png'),
(45, 'OH', '<pre class=\"language-cpp\"><code>#include &lt;iostream&gt;\r\n\r\nint main() {\r\n  std::cout &lt;&lt; \"Hello World!\";\r\n  return 0;\r\n}</code></pre>\r\n<p>&nbsp;</p>\r\n<p><img src=\"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvYlRhZ9q1WopmD3kxjy_-jq9k5rLP0Q_-WA&amp;s\" alt=\"\" width=\"212\" height=\"238\"></p>', '2024-08-22 06:31:18', '2024-08-22 06:31:18', '');

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`id`, `username`, `password`, `createdAt`, `updatedAt`) VALUES
(1, 'admin', '$2b$10$.80XOyDbGmhqP3dkGCDUL.jYRU46uwNSvLB0sgYszGTtgR0qNaLl.', '2024-08-21 07:23:59', '2024-08-21 07:23:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Posts`
--
ALTER TABLE `Posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Posts`
--
ALTER TABLE `Posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
