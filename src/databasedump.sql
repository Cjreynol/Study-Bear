-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: localhost    Database: studybear
-- ------------------------------------------------------
-- Server version	5.6.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class` (
  `classId` varchar(10) NOT NULL DEFAULT '',
  `universityName` varchar(80) NOT NULL DEFAULT '',
  `className` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`classId`,`universityName`),
  KEY `universityName` (`universityName`),
  CONSTRAINT `class_ibfk_1` FOREIGN KEY (`universityName`) REFERENCES `university` (`universityName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES ('CSCI 1301','GEORGIA REGENTS UNIVERSITY','Principles of Programming I'),('CSCI 1302','GEORGIA REGENTS UNIVERSITY','Principles of Programming II'),('CSCI 3400','GEORGIA REGENTS UNIVERSITY','Data Structures'),('CSCI 3520','GEORGIA REGENTS UNIVERSITY','Introduction to Cyber Security');
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `msgId` int(10) NOT NULL AUTO_INCREMENT,
  `sendingUser` varchar(20) DEFAULT NULL,
  `receivingUser` varchar(20) DEFAULT NULL,
  `body` varchar(250) DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `dateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`msgId`),
  KEY `sendingUser` (`sendingUser`),
  KEY `receivingUser` (`receivingUser`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sendingUser`) REFERENCES `user` (`userName`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receivingUser`) REFERENCES `user` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professor`
--

DROP TABLE IF EXISTS `professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `professor` (
  `professorId` int(10) NOT NULL AUTO_INCREMENT,
  `professorFname` varchar(20) NOT NULL DEFAULT '',
  `professorLname` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`professorFname`,`professorLname`),
  UNIQUE KEY `professorId` (`professorId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor`
--

LOCK TABLES `professor` WRITE;
/*!40000 ALTER TABLE `professor` DISABLE KEYS */;
INSERT INTO `professor` VALUES (1,'Onyeka','Ezenwoye'),(2,'Michael','Dowell'),(3,'Ryan','Wilson');
/*!40000 ALTER TABLE `professor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teaching`
--

DROP TABLE IF EXISTS `teaching`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teaching` (
  `teachingId` int(10) NOT NULL AUTO_INCREMENT,
  `professorId` int(10) NOT NULL DEFAULT '0',
  `classId` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`professorId`,`classId`),
  UNIQUE KEY `teachingId` (`teachingId`),
  KEY `classId` (`classId`),
  CONSTRAINT `teaching_ibfk_1` FOREIGN KEY (`professorId`) REFERENCES `professor` (`professorId`),
  CONSTRAINT `teaching_ibfk_2` FOREIGN KEY (`classId`) REFERENCES `class` (`classId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teaching`
--

LOCK TABLES `teaching` WRITE;
/*!40000 ALTER TABLE `teaching` DISABLE KEYS */;
INSERT INTO `teaching` VALUES (1,1,'CSCI 1301'),(2,2,'CSCI 1302'),(3,2,'CSCI 3400'),(4,3,'CSCI 3520');
/*!40000 ALTER TABLE `teaching` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `university`
--

DROP TABLE IF EXISTS `university`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `university` (
  `universityName` varchar(80) NOT NULL,
  PRIMARY KEY (`universityName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `university`
--

LOCK TABLES `university` WRITE;
/*!40000 ALTER TABLE `university` DISABLE KEYS */;
INSERT INTO `university` VALUES (''),('Georgia Regents University'),('University of South Carolina - Aiken');
/*!40000 ALTER TABLE `university` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `userName` varchar(20) NOT NULL,
  `firstName` varchar(20) DEFAULT NULL,
  `lastName` varchar(20) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `biography` varchar(200) DEFAULT NULL,
  `universityName` varchar(80) DEFAULT NULL,
  `accountStatus` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`userName`),
  KEY `universityName` (`universityName`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`universityName`) REFERENCES `university` (`universityName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('creynolds','Chad','Reynolds','$2y$10$42x6bLBJHjoYhePiSj1Cv.2wIMlViYDECLXCa/i2onKqCPlvf/uuK','@.edu','Hi','Georgia Regents University',''),('dcal','Dazmon','Callaham','$2y$10$ax/AYJnPfl01EbOl77otpezA.5oV8A7Rur4yLZIRMgi/mXFoWVbOW','@.edu','I love learning! And exploring. And watching anime.','Georgia Regents University',''),('jbeezy88','Jeremy','Scott','$2y$10$4vzIuyvv4pNCIlFa4qHVQOI67qKoa0YIKlqR1x42fhGBbP1XAUi4y','@.edu','I like cheese!','Georgia Regents University',''),('jbusch','Josh','Busch','$2y$10$XFJ7ZjAf2LFPURTbJ8zwnOMu4EV9OXkk9eE.nIsRTylnSNdsg7T1G','@.edu','Hi.','Georgia Regents University',''),('jscott88','Javon','Scott','$2y$10$jc3xNxpuXpIkV28xziNUpOEO0m8UPcl8QXYYX.O32rIBXZ6mHpOP6','@.edu','This is a really cool application. Looking to find awesome study buddies! Come hang out with me! I would love to study! Weekends are preferable! This app is still buggy. But','Georgia Regents University',''),('lscott26','Lanae','Scott','$2y$10$FUelHabpnqwhWwZp6L3oou58STltxup3VXnORsXB3FZA352PMaAZ.','@.edu','I love to study. Hello.','Georgia Regents University',''),('odarcie','','','$2y$10$ne4NfhnxcuovY1vdmEqi1.jXUsffRgHGwx3AoaRuzXvBkLzqI2ktm','@.edu','hi','Georgia Regents University',''),('onetwo','one','two','$2y$10$JRlIR6lMQz8BUqTic2f/TeV4BwcwvqVugmCl/udKSjGnvmZOY/sPO','@.edu','hi','Georgia Regents University',''),('sbrown','Scott','Brown','$2y$10$bNtfH.x70osZLa69JJiIIuUoCRDM0r9WbyQmpGN5QBlnE8WUqAWzC','@.edu','','','');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_blocked`
--

DROP TABLE IF EXISTS `user_blocked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_blocked` (
  `userName` varchar(20) DEFAULT NULL,
  `blockeduserName` varchar(20) DEFAULT NULL,
  KEY `userName` (`userName`),
  KEY `blockeduserName` (`blockeduserName`),
  CONSTRAINT `user_blocked_ibfk_1` FOREIGN KEY (`userName`) REFERENCES `user` (`userName`),
  CONSTRAINT `user_blocked_ibfk_2` FOREIGN KEY (`blockeduserName`) REFERENCES `user` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_blocked`
--

LOCK TABLES `user_blocked` WRITE;
/*!40000 ALTER TABLE `user_blocked` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_blocked` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_enrollment`
--

DROP TABLE IF EXISTS `user_enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_enrollment` (
  `userName` varchar(20) NOT NULL DEFAULT '',
  `teachingId` int(10) NOT NULL DEFAULT '0',
  `enrollmentStatus` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`userName`,`teachingId`),
  KEY `teachingId` (`teachingId`),
  CONSTRAINT `user_enrollment_ibfk_1` FOREIGN KEY (`userName`) REFERENCES `user` (`userName`),
  CONSTRAINT `user_enrollment_ibfk_2` FOREIGN KEY (`teachingId`) REFERENCES `teaching` (`teachingId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_enrollment`
--

LOCK TABLES `user_enrollment` WRITE;
/*!40000 ALTER TABLE `user_enrollment` DISABLE KEYS */;
INSERT INTO `user_enrollment` VALUES ('jbeezy88',1,'A'),('jbeezy88',2,'A'),('jbeezy88',3,'A'),('jbeezy88',4,'A'),('jbusch',1,'A'),('jbusch',2,'A'),('jbusch',3,'A'),('jbusch',4,'A'),('jscott88',1,'A'),('jscott88',2,'A'),('jscott88',3,'A'),('jscott88',4,'A'),('lscott26',1,'A'),('lscott26',2,'A'),('lscott26',3,'A'),('lscott26',4,'A');
/*!40000 ALTER TABLE `user_enrollment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-13 20:00:52
