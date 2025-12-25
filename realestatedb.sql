-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 25, 2025 at 08:33 PM
-- Server version: 8.0.41
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `realestatedb`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Apartment'),
(2, 'House'),
(3, 'Villa'),
(4, 'Townhouse'),
(5, 'Condo');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text NOT NULL,
  `categoryId` int NOT NULL,
  `image` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `price`, `description`, `categoryId`, `image`) VALUES
(54, 'Family Suburban House', 350000.90, 'Spacious 3‑bedroom house in a quiet suburban area, with a garden and garage.', 3, 'https://i.imgur.com/JZvzzEX.jpeg'),
(55, 'Beachside Luxury Villa', 1250000.00, '5‑bedroom villa with private pool and panoramic sea views, perfect for holidays or living.', 3, 'https://i.imgur.com/tgZTKsq.jpeg'),
(56, 'Cozy Townhouse, Quiet Neighborhood', 460000.00, '4‑bedroom townhouse in a peaceful residential neighborhood, ideal for families.', 4, 'https://i.imgur.com/w4C1mNm.png'),
(57, 'Modern Condo Near Metro', 330000.00, '1‑bedroom condo located minutes from metro and shopping center — great for singles or couples.', 5, 'https://i.imgur.com/NfciLhr.png'),
(58, 'Country‑side House with Backyard', 420000.00, '4‑bedroom country house with large backyard; peaceful location away from city noise.', 2, 'https://i.imgur.com/vdbmi0x.jpeg'),
(59, 'Urban Loft Apartment', 290000.00, 'Stylish open‑plan loft apartment with high ceilings and large windows — perfect for a contemporary lifestyle.', 1, 'https://i.imgur.com/6yCU1Si.jpeg'),
(60, 'Luxury Penthouse Suite', 890000.00, 'Spacious penthouse with 3 bedrooms, private terrace, and panoramic city skyline views.', 5, 'https://i.imgur.com/VXZfwKh.jpeg'),
(61, 'Seaside Cottage', 180000.00, 'Cute 2‑bedroom cottage steps from the beach; perfect for a weekend getaway.', 2, 'https://i.imgur.com/GHuwQQi.jpeg'),
(62, 'Modern Family Villa', 600000.00, '4‑bedroom villa with garden and pool, located in a secure residential community.', 3, 'https://i.imgur.com/s1bHRXi.jpeg'),
(63, 'Historic Townhouse', 520000.00, '3‑bedroom historic townhouse with classic architecture in a charming district.', 4, 'https://i.imgur.com/9VJbU0o.jpeg'),
(64, 'Downtown Studio Apartment', 180000.00, 'Compact studio apartment ideal for students or young professionals.', 1, 'https://i.imgur.com/hhvF9Qf.jpeg'),
(65, 'Countryside Farmhouse', 480000.00, 'Spacious farmhouse with 5 bedrooms, stables, and lots of land.', 2, 'https://i.imgur.com/IdZHRQh.jpeg'),
(66, 'Lakefront Villa', 950000.00, 'Luxury villa with private dock, lake views, and modern amenities.', 3, 'https://i.imgur.com/KiYpk5R.jpeg'),
(67, 'City Center Apartment', 300000.00, '2‑bedroom apartment near restaurants, shops, and public transport.', 1, 'https://i.imgur.com/xwQlyNs.jpeg'),
(68, 'Suburban Duplex', 410000.00, '3‑bedroom duplex in a family-friendly neighborhood with backyard.', 2, 'https://i.imgur.com/nJxFuvh.jpeg'),
(69, 'Modern Loft with Balcony', 350000.00, '1‑bedroom loft with balcony and modern finishes in a trendy district.', 1, 'https://i.imgur.com/uN6QvaM.jpeg'),
(70, 'Coastal Townhouse', 470000.00, '3‑bedroom townhouse near the coast with sea views and outdoor terrace.', 4, 'https://i.imgur.com/ilZt88N.jpeg'),
(71, 'Luxury Beach Villa', 1350000.00, '6‑bedroom villa with private pool, garden, and oceanfront location.', 3, 'https://i.imgur.com/USYqw2o.jpeg'),
(72, 'Modern Condo with View', 320000.00, '2‑bedroom condo with city views and convenient location.', 5, 'https://i.imgur.com/bZRLiUf.png'),
(73, 'Spacious Suburban House', 390000.00, '4‑bedroom house with garage, backyard, and family-friendly location.', 2, 'https://i.imgur.com/7AZ6cQP.jpeg'),
(74, 'Downtown Modern Apartment', 280000.00, '1‑bedroom modern apartment in the heart of the city.', 1, 'https://i.imgur.com/rGSc5yN.jpeg'),
(75, 'Luxury Penthouse', 920000.00, '3‑bedroom penthouse with terrace and skyline views.', 5, 'https://i.imgur.com/KYpya5d.jpeg'),
(76, 'Beach Cottage', 190000.00, '2‑bedroom cozy cottage near the beach with garden.', 2, 'https://i.imgur.com/qp3M2iS.jpeg'),
(77, 'Elegant Townhouse', 500000.00, '3‑bedroom townhouse with modern interiors and private terrace.', 4, 'https://i.imgur.com/QfTYbn0.png'),
(78, 'Downtown Condo', 310000.00, '2‑bedroom condo near central park and metro.', 5, 'https://i.imgur.com/JOJakwR.jpeg'),
(79, 'Suburban Modern House', 430000.00, '4‑bedroom modern house with backyard and garage.', 2, 'https://i.imgur.com/nMLJtDP.jpeg'),
(80, 'Luxury City Apartment', 370000.00, '3‑bedroom city apartment with balcony and modern kitchen.', 1, 'https://i.imgur.com/3iovL2L.png'),
(81, 'Beachfront Villa', 1100000.00, '5‑bedroom villa with direct beach access and pool.', 3, 'https://i.imgur.com/e4CsTHv.jpeg'),
(82, 'Urban Townhouse', 450000.00, '3‑bedroom townhouse close to city amenities.', 4, 'https://i.imgur.com/s1bHRXi.jpeg'),
(83, 'Modern Family Condo', 340000.00, '2‑bedroom condo in a family-friendly complex with pool.', 5, 'https://i.imgur.com/86YHaBT.jpeg'),
(84, 'Countryside House', 400000.00, '3‑bedroom house in peaceful countryside.', 2, 'https://i.imgur.com/1gYuaNd.jpeg'),
(85, 'City Studio Apartment', 200000.00, '1‑bedroom apartment ideal for singles or students.', 1, 'https://i.imgur.com/lLkOPsE.jpeg'),
(86, 'Luxury Townhouse', 510000.00, '4‑bedroom townhouse with premium finishes.', 4, 'https://i.imgur.com/YgcK16w.jpeg'),
(87, 'Coastal Condo', 330000.00, '2‑bedroom condo with ocean view.', 5, 'https://i.imgur.com/KHWgFfw.jpeg'),
(88, 'Modern Villa', 780000.00, '4‑bedroom villa with pool and garden.', 3, 'https://i.imgur.com/LDmSrR0.jpeg'),
(89, 'Downtown Loft Apartment', 290000.00, '2‑bedroom loft with open plan living.', 1, 'https://i.imgur.com/cpejnGG.jpeg'),
(90, 'Suburban Townhouse', 420000.00, '3‑bedroom townhouse with backyard.', 4, 'https://i.imgur.com/0YhuJKX.jpeg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoryId` (`categoryId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
