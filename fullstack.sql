-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 23, 2021 at 02:45 PM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fullstack`
--

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE `blogs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `post` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `jsonData` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_excerpt` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `featuredImage` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metaDescription` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `views` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blogs`
--

INSERT INTO `blogs` (`id`, `title`, `post`, `jsonData`, `post_excerpt`, `slug`, `user_id`, `featuredImage`, `metaDescription`, `views`, `created_at`, `updated_at`) VALUES
(44, 'title', 'undefined<p class=\"blog_post_text\">\n                        asssassaLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum    \n                    </p><p class=\"blog_post_text\">\n                        asssassaLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum    \n                    </p>', '{\"time\":1620660745978,\"blocks\":[{\"id\":\"RnQRiweGMM\",\"type\":\"paragraph\",\"data\":{\"text\":\"asssassaLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum\"}}],\"version\":\"2.21.0\"}', 't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The poi', 'title-1', 2, NULL, 't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The poi', 0, '2021-05-08 13:24:05', '2021-05-10 10:02:26'),
(49, 'title 2', 'dacadc', '{\"time\":1620660745978,\"blocks\":[{\"id\":\"RnQRiweGMM\",\"type\":\"paragraph\",\"data\":{\"text\":\"asssassaLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum\"}}],\"version\":\"2.21.0\"}', 't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The poi', 'title-2', 2, NULL, 'dsfsdf', 0, '2021-05-11 18:30:00', '2021-05-18 18:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `blog_categories`
--

CREATE TABLE `blog_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` int(11) NOT NULL,
  `blog_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blog_categories`
--

INSERT INTO `blog_categories` (`id`, `category_id`, `blog_id`, `created_at`, `updated_at`) VALUES
(64, 19, 44, NULL, NULL),
(65, 20, 44, NULL, NULL),
(66, 21, 44, NULL, NULL),
(67, 20, 49, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `blog_tags`
--

CREATE TABLE `blog_tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tag_id` int(11) NOT NULL,
  `blog_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blog_tags`
--

INSERT INTO `blog_tags` (`id`, `tag_id`, `blog_id`, `created_at`, `updated_at`) VALUES
(38, 68, 44, NULL, NULL),
(39, 70, 44, NULL, NULL),
(40, 71, 44, NULL, NULL),
(41, 71, 49, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `categoryName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `iconImage` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `categoryName`, `iconImage`, `created_at`, `updated_at`) VALUES
(19, 'Economy', '/uploads/1620496278.jpg', '2021-05-08 12:21:22', '2021-05-08 12:21:22'),
(20, 'Social', '/uploads/1620496312.png', '2021-05-08 12:21:55', '2021-05-08 12:21:55'),
(21, 'Devotional', '/uploads/1620496357.png', '2021-05-08 12:22:38', '2021-05-08 12:22:38'),
(22, 'Politics', '/uploads/1620496374.png', '2021-05-08 12:22:58', '2021-05-08 12:22:58');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2021_04_13_180818_create_categories_table', 1),
(5, '2021_04_13_180908_create_tags_table', 1),
(6, '2021_04_13_180927_create_blogs_table', 1),
(7, '2021_04_13_181000_create_blog_tags_table', 1),
(8, '2021_04_13_181029_create_blog_categories_table', 1),
(9, '2021_04_20_183045_create_roles_table', 2),
(10, '2021_05_01_164122_add_role_id_to_users_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `roleName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permission` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `isAdmin` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `roleName`, `permission`, `created_at`, `updated_at`, `isAdmin`) VALUES
(2, 'Admin', '[{\"resourceName\":\"Home\",\"read\":true,\"write\":true,\"update\":true,\"deletePermission\":true,\"name\":\"/\"},{\"resourceName\":\"Tags\",\"read\":true,\"write\":true,\"update\":true,\"deletePermission\":true,\"name\":\"tags\"},{\"resourceName\":\"Category\",\"read\":true,\"write\":true,\"update\":true,\"deletePermission\":true,\"name\":\"category\"},{\"resourceName\":\"Role\",\"read\":true,\"write\":true,\"update\":true,\"deletePermission\":false,\"name\":\"role\"},{\"resourceName\":\"Assign Role\",\"read\":true,\"write\":true,\"update\":true,\"deletePermission\":false,\"name\":\"assignRole\"},{\"resourceName\":\"Create Blog\",\"read\":true,\"write\":true,\"update\":true,\"deletePermission\":false,\"name\":\"createBlog\"},{\"resourceName\":\"Blogs\",\"read\":true,\"write\":true,\"update\":true,\"deletePermission\":true,\"name\":\"blogs\"},{\"resourceName\":\"Admin users\",\"read\":true,\"write\":true,\"update\":true,\"deletePermission\":false,\"name\":\"adminusers\"}]', '2021-05-01 18:30:00', '2021-05-09 06:49:46', 1),
(4, 'Editor', '[{\"resourceName\":\"Home\",\"read\":true,\"write\":true,\"update\":true,\"deletePermission\":false,\"name\":\"/\"},{\"resourceName\":\"Tags\",\"read\":true,\"write\":true,\"update\":false,\"deletePermission\":false,\"name\":\"tags\"},{\"resourceName\":\"Category\",\"read\":true,\"write\":true,\"update\":true,\"deletePermission\":false,\"name\":\"category\"},{\"resourceName\":\"Role\",\"read\":true,\"write\":true,\"update\":true,\"deletePermission\":false,\"name\":\"role\"},{\"resourceName\":\"Assign Role\",\"read\":true,\"write\":true,\"update\":true,\"deletePermission\":false,\"name\":\"assignRole\"},{\"resourceName\":\"Create Blog\",\"read\":true,\"write\":true,\"update\":true,\"deletePermission\":false,\"name\":\"createBlog\"},{\"resourceName\":\"Blogs\",\"read\":true,\"write\":true,\"update\":false,\"deletePermission\":false,\"name\":\"blogs\"},{\"resourceName\":\"Admin users\",\"read\":true,\"write\":true,\"update\":false,\"deletePermission\":false,\"name\":\"adminusers\"}]', '2021-05-02 10:34:43', '2021-05-08 13:42:11', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tagName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `tagName`, `created_at`, `updated_at`) VALUES
(68, 'Glamour', '2021-05-08 12:23:21', '2021-05-08 12:23:21'),
(69, 'corona', '2021-05-08 12:23:35', '2021-05-08 12:23:35'),
(70, 'General knowledge', '2021-05-08 12:23:51', '2021-05-08 12:23:51'),
(71, 'Pandemic', '2021-05-08 12:24:04', '2021-05-08 12:24:04');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fullName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profileImage` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userType` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `isActivated` tinyint(1) NOT NULL DEFAULT 0,
  `passwordResetCode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activationCode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `socialType` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullName`, `email`, `profileImage`, `role_id`, `password`, `userType`, `isActivated`, `passwordResetCode`, `activationCode`, `socialType`, `created_at`, `updated_at`) VALUES
(2, 'Chandana', 'kschandan62@gmail.com', NULL, 2, '$2y$10$ai/iS9524zD4SAbFrkWBF.NlBvTy8Mk.7tUvQ/roSRLsXgph7RLOy', 'Admin', 0, NULL, NULL, NULL, '2021-04-19 13:13:06', '2021-05-01 14:16:57'),
(11, 'ajay', 'ajay@gmail.com', NULL, 2, '$2y$10$aa6li07uPX6Ak6xl/39sie8eqhbzbpBrSqwkWhKqlKAxpRDoHKJgS', 'user', 0, NULL, NULL, NULL, '2021-05-01 14:17:16', '2021-05-01 14:17:16');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_category_id` (`blog_id`);

--
-- Indexes for table `blog_tags`
--
ALTER TABLE `blog_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_id` (`blog_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `blog_categories`
--
ALTER TABLE `blog_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `blog_tags`
--
ALTER TABLE `blog_tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD CONSTRAINT `blog_category_id` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `blog_tags`
--
ALTER TABLE `blog_tags`
  ADD CONSTRAINT `blog_id` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
