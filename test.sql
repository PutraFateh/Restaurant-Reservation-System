-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 17, 2020 at 12:10 PM
-- Server version: 5.6.24
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `custinfo`
--

CREATE TABLE IF NOT EXISTS `custinfo` (
  `cust_id` int(11) NOT NULL,
  `cust_email` varchar(255) DEFAULT NULL,
  `cust_password` varchar(255) DEFAULT NULL,
  `cust_name` varchar(255) DEFAULT NULL,
  `cust_contact` varchar(255) DEFAULT NULL,
  `cust_point` int(11) DEFAULT NULL,
  `referral` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `custinfo`
--

INSERT INTO `custinfo` (`cust_id`, `cust_email`, `cust_password`, `cust_name`, `cust_contact`, `cust_point`, `referral`, `type`) VALUES
(11, 'brogrammers@gmail.com', 'bro9', 'Brogrammerssss', '0123847592', 0, 0, 'customer'),
(12, 'faris@gmail.com', 'faris1', 'Faris Handsome wow', '0183628173', 15, 11, 'customer'),
(13, 'admin@gmail.com', 'admin', 'admin', '999', 0, 0, 'admin'),
(19, 'hannan@gmail.com', 'lol', 'Hannan', '0129384755', 0, 0, 'customer');

-- --------------------------------------------------------

--
-- Table structure for table `list_voucher`
--

CREATE TABLE IF NOT EXISTS `list_voucher` (
  `voucher_code` varchar(255) DEFAULT NULL,
  `cust_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `list_voucher`
--

INSERT INTO `list_voucher` (`voucher_code`, `cust_id`) VALUES
('IIUMSTD', 11);

-- --------------------------------------------------------

--
-- Table structure for table `redeem_item`
--

CREATE TABLE IF NOT EXISTS `redeem_item` (
  `redeem_id` int(11) NOT NULL,
  `redeem_item_name` varchar(255) NOT NULL,
  `redeem_point` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `redeem_item`
--

INSERT INTO `redeem_item` (`redeem_id`, `redeem_item_name`, `redeem_point`) VALUES
(4, 'Mineral', 5),
(8, 'Chicken Chop', 10);

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE IF NOT EXISTS `reservation` (
  `reserve_id` int(11) NOT NULL,
  `cust_id` int(11) DEFAULT NULL,
  `reserve_title` varchar(255) DEFAULT NULL,
  `reserve_session` varchar(255) DEFAULT NULL,
  `reserve_time` date DEFAULT NULL,
  `reserve_pax` int(11) DEFAULT NULL,
  `reserve_seat` int(11) DEFAULT NULL,
  `reserve_status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`reserve_id`, `cust_id`, `reserve_title`, `reserve_session`, `reserve_time`, `reserve_pax`, `reserve_seat`, `reserve_status`) VALUES
(35, 11, 'Birthday Party', 'Session A : 12PM - 4PM', '2020-08-18', 4, 17, 'Success'),
(36, 11, 'Dinner', 'Session B : 5PM - 11PM', '2020-08-20', 2, 13, 'Cancelled');

-- --------------------------------------------------------

--
-- Table structure for table `voucher`
--

CREATE TABLE IF NOT EXISTS `voucher` (
  `voucher_id` int(11) NOT NULL,
  `voucher_code` varchar(255) NOT NULL,
  `voucher_limit` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `voucher`
--

INSERT INTO `voucher` (`voucher_id`, `voucher_code`, `voucher_limit`) VALUES
(3, 'IIUMSTD', 4),
(4, 'FREERES', 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `custinfo`
--
ALTER TABLE `custinfo`
  ADD PRIMARY KEY (`cust_id`);

--
-- Indexes for table `redeem_item`
--
ALTER TABLE `redeem_item`
  ADD PRIMARY KEY (`redeem_id`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`reserve_id`), ADD KEY `cust_id` (`cust_id`);

--
-- Indexes for table `voucher`
--
ALTER TABLE `voucher`
  ADD PRIMARY KEY (`voucher_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `custinfo`
--
ALTER TABLE `custinfo`
  MODIFY `cust_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `redeem_item`
--
ALTER TABLE `redeem_item`
  MODIFY `redeem_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `reserve_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT for table `voucher`
--
ALTER TABLE `voucher`
  MODIFY `voucher_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`cust_id`) REFERENCES `custinfo` (`cust_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
