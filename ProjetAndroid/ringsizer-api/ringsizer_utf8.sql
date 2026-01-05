-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: ringsizer
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cart_items_user_id_product_id_unique` (`user_id`,`product_id`),
  KEY `cart_items_user_id_index` (`user_id`),
  KEY `cart_items_product_id_index` (`product_id`),
  CONSTRAINT `cart_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorites` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `favorites_user_id_product_id_unique` (`user_id`,`product_id`),
  KEY `favorites_user_id_index` (`user_id`),
  KEY `favorites_product_id_index` (`product_id`),
  CONSTRAINT `favorites_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `favorites_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gold_prices`
--

DROP TABLE IF EXISTS `gold_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gold_prices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `source` varchar(255) NOT NULL DEFAULT 'goldapi',
  `base_currency` varchar(255) NOT NULL DEFAULT 'USD',
  `price_per_ounce` decimal(12,4) NOT NULL,
  `price_per_gram` decimal(12,4) NOT NULL,
  `price_per_gram_mad` decimal(12,4) DEFAULT NULL,
  `karat` tinyint(3) unsigned NOT NULL DEFAULT 24,
  `collected_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gold_prices_karat_collected_at_index` (`karat`,`collected_at`),
  KEY `gold_prices_collected_at_index` (`collected_at`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gold_prices`
--

LOCK TABLES `gold_prices` WRITE;
/*!40000 ALTER TABLE `gold_prices` DISABLE KEYS */;
INSERT INTO `gold_prices` VALUES (1,'seed','USD',2300.0000,73.9467,739.4672,24,'2025-12-25 21:17:51','2025-12-25 21:17:51','2025-12-25 21:17:51'),(2,'goldapi','USD',4541.0500,145.9981,1459.9815,24,'2025-12-26 15:48:00','2025-12-26 15:48:00','2025-12-26 15:48:00'),(3,'goldapi','USD',4541.0500,145.9981,1459.9815,24,'2025-12-26 15:48:08','2025-12-26 15:48:08','2025-12-26 15:48:08'),(4,'goldapi','USD',4541.0500,145.9981,1459.9815,24,'2025-12-26 15:48:24','2025-12-26 15:48:24','2025-12-26 15:48:24'),(5,'goldapi','USD',4538.7200,145.9232,1459.2324,24,'2025-12-26 15:48:41','2025-12-26 15:48:41','2025-12-26 15:48:41');
/*!40000 ALTER TABLE `gold_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2025_12_25_220458_create_seller_profiles_table',2),(5,'2025_12_25_220502_create_products_table',2),(6,'2025_12_25_220504_create_product_images_table',2),(7,'2025_12_25_220506_create_gold_prices_table',2),(8,'2025_12_25_220507_create_saved_sizes_table',2),(9,'2025_12_25_220851_add_role_to_users_table',3),(10,'2025_12_25_230514_create_personal_access_tokens_table',4),(11,'2025_12_26_180100_create_favorites_table',5),(12,'2025_12_26_180101_create_cart_items_table',5),(13,'2025_12_26_190000_add_size_range_to_products_table',6);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',4,'auth_token','19aee5c1fc834a288be32aa35b9a38ef397710c9143a6f8d8c0d4044ca656d7e','[\"*\"]',NULL,NULL,'2025-12-26 12:20:16','2025-12-26 12:20:16'),(2,'App\\Models\\User',4,'auth_token','ff46d658ff385241a857f49d43550b25a879714ca09aae0c64f7b0aba28fb262','[\"*\"]','2025-12-26 15:07:02',NULL,'2025-12-26 12:35:09','2025-12-26 15:07:02'),(3,'App\\Models\\User',4,'auth_token','97a4715f1af4aa38097e7b4fa6955110416a2224b599f97a7efb2e7ce2a643db','[\"*\"]',NULL,NULL,'2025-12-26 15:20:55','2025-12-26 15:20:55'),(4,'App\\Models\\User',4,'auth_token','81f808d05c9de8f2be4477076d66d7442f7f940a856316b1ea035dacd565aa01','[\"*\"]','2025-12-26 15:35:04',NULL,'2025-12-26 15:34:05','2025-12-26 15:35:04'),(5,'App\\Models\\User',5,'auth_token','de3f9d09aad3687cef550ad322268730c36c8a6d130aa3fb1592f83bf60a9c00','[\"*\"]',NULL,NULL,'2025-12-26 15:58:38','2025-12-26 15:58:38'),(6,'App\\Models\\User',4,'auth_token','ab5e67fec1cd8a2163dc6d17130247748dc20e5b90dafd27cfac443cafc2e30c','[\"*\"]',NULL,NULL,'2025-12-26 15:59:20','2025-12-26 15:59:20'),(7,'App\\Models\\User',6,'auth_token','8fb2e9e3d9ac77529b48ff226deb2b18e65f85ab30587f619fabbfc114cd01c4','[\"*\"]',NULL,NULL,'2025-12-26 16:00:40','2025-12-26 16:00:40'),(8,'App\\Models\\User',5,'auth_token','5394543361ff907f678d8d2a0827986555f4eaa5d6cf5a73d361e18ce9f42d7d','[\"*\"]','2025-12-26 17:12:41',NULL,'2025-12-26 16:42:47','2025-12-26 17:12:41'),(9,'App\\Models\\User',4,'auth_token','3885e87bbb4a97950b650b93f7cf6edae6893580aaad95b29d6a6610cd70bb4a','[\"*\"]','2025-12-26 17:13:46',NULL,'2025-12-26 17:12:56','2025-12-26 17:13:46'),(10,'App\\Models\\User',5,'auth_token','622ff0bf214ac84d575469a55dc45bb0fc20c8423b56d2cdb3ac4ea0a43a629a','[\"*\"]','2025-12-26 17:15:18',NULL,'2025-12-26 17:14:25','2025-12-26 17:15:18'),(11,'App\\Models\\User',4,'auth_token','1fe2fd574b4f69df321f81498650fd98d2c7184cd4779be41cbc7833f069f23e','[\"*\"]','2025-12-26 17:15:40',NULL,'2025-12-26 17:15:39','2025-12-26 17:15:40'),(12,'App\\Models\\User',4,'auth_token','ce2067baeda2c02f5b4919f9cf87070dbca84b16b9997da1ab58babaf5ce7cad','[\"*\"]','2025-12-26 17:16:22',NULL,'2025-12-26 17:16:21','2025-12-26 17:16:22'),(13,'App\\Models\\User',5,'auth_token','29c6b0dc7407f8af898c91d6c6ff01df638060e2e319c9ec827ddf10128efd54','[\"*\"]','2025-12-26 17:25:25',NULL,'2025-12-26 17:16:51','2025-12-26 17:25:25'),(14,'App\\Models\\User',4,'auth_token','63b37ad8723be6693ba1a4faa2e2fb3bf647b976b30a2f04e8497f85fdef1be9','[\"*\"]','2025-12-26 17:26:05',NULL,'2025-12-26 17:25:49','2025-12-26 17:26:05'),(15,'App\\Models\\User',5,'auth_token','a0063bd832d26ff3635884e562c99ce69d22e11bf4e15518a411ee317f4a2aa9','[\"*\"]','2025-12-26 22:05:33',NULL,'2025-12-26 17:26:44','2025-12-26 22:05:33'),(16,'App\\Models\\User',5,'auth_token','d9cd34a79d8e04c3320d3f2308973b0fd033f943f94bb5d42b92a427394aa27d','[\"*\"]','2025-12-26 22:22:28',NULL,'2025-12-26 22:21:59','2025-12-26 22:22:28');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_images` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) unsigned NOT NULL,
  `path` varchar(255) NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_images_product_id_position_index` (`product_id`,`position`),
  CONSTRAINT `product_images_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` VALUES (2,6,'content://com.android.providers.downloads.documents/document/raw%3A%2Fstorage%2Femulated%2F0%2FDownload%2Fimages.jpg',0,'2025-12-26 13:24:03','2025-12-26 13:24:03'),(3,6,'content://com.android.providers.downloads.documents/document/msf%3A34',0,'2025-12-26 13:50:52','2025-12-26 13:50:52');
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seller_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `size_min_mm` decimal(6,2) DEFAULT NULL,
  `size_max_mm` decimal(6,2) DEFAULT NULL,
  `karat` tinyint(3) unsigned NOT NULL DEFAULT 24,
  `weight_g` decimal(8,2) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `stock` int(11) NOT NULL DEFAULT 0,
  `cover_image_path` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'draft',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_seller_id_status_index` (`seller_id`,`status`),
  CONSTRAINT `products_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,2,'Bague or 18k','Bague élégante en or 18 carats, 4g','ring',NULL,NULL,18,4.00,3200.00,5,NULL,'published','2025-12-25 21:17:51','2025-12-25 21:17:51'),(6,4,'test','desc','ring',NULL,NULL,19,10.00,5854.12,1,NULL,'published','2025-12-26 13:24:03','2025-12-26 13:50:52'),(7,4,'bracelet','bracelet','bracelet',NULL,NULL,18,20.00,11092.01,1,'storage/products/HVdBqRIa5EVjDELw5UzYfSE5I9HJhi7fVXCUjRFL.jpg','published','2025-12-26 14:01:32','2025-12-26 15:35:04'),(8,4,'bague','test','ring',15.00,20.00,18,20.00,21888.49,1,'storage/products/9HmPZukLIXYz4dEMzPRkBb1YU6ytx4lZDRfP4vhw.jpg','published','2025-12-26 17:13:46','2025-12-26 17:26:05');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved_sizes`
--

DROP TABLE IF EXISTS `saved_sizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saved_sizes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `type` enum('ring','bracelet') NOT NULL,
  `diameter_mm` decimal(6,2) DEFAULT NULL,
  `circumference_mm` decimal(6,2) DEFAULT NULL,
  `standard` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `saved_sizes_user_id_type_index` (`user_id`,`type`),
  CONSTRAINT `saved_sizes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved_sizes`
--

LOCK TABLES `saved_sizes` WRITE;
/*!40000 ALTER TABLE `saved_sizes` DISABLE KEYS */;
INSERT INTO `saved_sizes` VALUES (1,5,'ring',17.00,17.00,'MM','Ma bague','2025-12-26 17:12:25','2025-12-26 17:27:05'),(2,5,'bracelet',NULL,255.00,'MM','Mon bracelet','2025-12-26 17:17:12','2025-12-26 17:17:12');
/*!40000 ALTER TABLE `saved_sizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller_profiles`
--

DROP TABLE IF EXISTS `seller_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seller_profiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `shop_name` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `seller_profiles_user_id_foreign` (`user_id`),
  CONSTRAINT `seller_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller_profiles`
--

LOCK TABLES `seller_profiles` WRITE;
/*!40000 ALTER TABLE `seller_profiles` DISABLE KEYS */;
INSERT INTO `seller_profiles` VALUES (1,2,'Demo Gold Shop','+212600000000',NULL,'Casablanca','2025-12-25 21:17:51','2025-12-25 21:17:51'),(2,4,'ayman\'s shop',NULL,NULL,NULL,'2025-12-26 12:20:16','2025-12-26 12:20:16'),(3,6,'zahidStore','0606060606','jamaa el fna','Marrakech','2025-12-26 16:00:40','2025-12-26 16:00:40');
/*!40000 ALTER TABLE `seller_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('6IQMGU6IpDQ6WtdglnBGr8U0smwJBCfhkjbwPZ8h',NULL,'127.0.0.1','PostmanRuntime/7.51.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiT3dxV09nY0dxc1plNjdxSkx5UWUwcXJQeTJRTTI2eGZ5T29wQ0cxTCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1766702914),('d2BeEjOdVCcMq6YQjLnhSTS80beNyS3T2quCWpP2',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiajVIN1VZc3paQXNOcTVOMDVpdVlqTFF3Q2JqY1dFSUptclNrUU9BNCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1766703373),('t2chZHu5Y7BGLZQIVo58DfKCMaynpr4Xe2QSB9Jt',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT; Windows NT 10.0; fr-FR) WindowsPowerShell/5.1.19041.6456','YTozOntzOjY6Il90b2tlbiI7czo0MDoiTzFJcnF6YmFEdXRHajlOUUhla2FqRVFqU2xRSTc0WUJGNk5HQngzViI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1766703939);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'buyer',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','admin@example.com',NULL,'$2y$12$4Zv7p1w41HSkJAu.VR7JRu7EnC30BAKq6jskMiE5eSdzWUzczTgpO','admin',NULL,'2025-12-25 21:17:50','2025-12-25 21:17:50'),(2,'Seller Demo','seller@example.com',NULL,'$2y$12$UCmn5i2DfBvLkC2F9WqRXup/iZYOjoGWE2HOmmiVny4sUpF1AZBkG','seller',NULL,'2025-12-25 21:17:51','2025-12-25 21:17:51'),(3,'Ayman','ayman@example.com',NULL,'$2y$12$rxiKKmX3mruhb9qkhNtb7uJsfwAJVTbSq05YhUvRoKl2FvudP2odi','buyer',NULL,'2025-12-25 22:02:03','2025-12-25 22:02:03'),(4,'ayman','AymanVendeur@test.com',NULL,'$2y$12$LdMudrJOrwrrMi8KvPE4ReezjOpsBKBq/8aTrJnSf6GBJ.EmxrJiW','seller',NULL,'2025-12-26 12:20:16','2025-12-26 12:20:16'),(5,'ayman','aymanclient@test.com',NULL,'$2y$12$0cC7jFmmpyo4qxFKtEjwz.Hk8U33cC5I/JIT8jjB271cgkUi6e.eK','buyer',NULL,'2025-12-26 15:58:38','2025-12-26 15:58:38'),(6,'zahid','zahid@test.com',NULL,'$2y$12$pm9W5kAp2e9aCGJ4wlr0bOc9La.C6yy83NipejGbjpB6AQqeTEY46','seller',NULL,'2025-12-26 16:00:40','2025-12-26 16:00:40');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ringsizer'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-27  1:12:59
