-- Below is the code for the Database table creation:

-- Table customer:
CREATE TABLE `customer` (
  `idnfc` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `birthday` varchar(45) NOT NULL,
  `iddocnumber` varchar(45) NOT NULL,
  `iddoctype` varchar(45) NOT NULL,
  `iddocauthority` varchar(45) NOT NULL,
  PRIMARY KEY (`idnfc`),
  UNIQUE KEY `idnfc_UNIQUE` (`idnfc`),
  UNIQUE KEY `idpapernumber_UNIQUE` (`iddocnumber`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Customers of the hotel';

-- Table email:
CREATE TABLE `email` (
  `idnfc` int NOT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`idnfc`,`email`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  CONSTRAINT `email_idnfc` FOREIGN KEY (`idnfc`) REFERENCES `customer` (`idnfc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table has_access:
CREATE TABLE `has_access` (
  `idplace` int NOT NULL,
  `idnfc` int NOT NULL,
  `startdatetime` datetime NOT NULL,
  `enddatetime` datetime NOT NULL,
  PRIMARY KEY (`idplace`,`idnfc`),
  KEY `has_access_idnfc_idx` (`idnfc`),
  CONSTRAINT `has_access_idnfc` FOREIGN KEY (`idnfc`) REFERENCES `customer` (`idnfc`),
  CONSTRAINT `has_access_idplace` FOREIGN KEY (`idplace`) REFERENCES `place` (`idplace`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table phone_number:
CREATE TABLE `phone_number` (
  `idnfc` int NOT NULL,
  `phonenumber` varchar(45) NOT NULL,
  PRIMARY KEY (`idnfc`,`phonenumber`),
  UNIQUE KEY `phonenumber_UNIQUE` (`phonenumber`),
  CONSTRAINT `phone_number_idnfc` FOREIGN KEY (`idnfc`) REFERENCES `customer` (`idnfc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table place:
CREATE TABLE `place` (
  `idplace` int NOT NULL,
  `bedcount` int NOT NULL DEFAULT '0',
  `placename` varchar(45) NOT NULL,
  `placedescription` varchar(45) NOT NULL,
  PRIMARY KEY (`idplace`),
  UNIQUE KEY `idplaces_UNIQUE` (`idplace`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Places in the hotel';

--Table provided_in
CREATE TABLE `provided_in` (
  `idplace` int NOT NULL,
  `idservice` int NOT NULL,
  PRIMARY KEY (`idplace`,`idservice`),
  KEY `provided_in_idservice_idx` (`idservice`),
  CONSTRAINT `provided_in_idplace` FOREIGN KEY (`idplace`) REFERENCES `place` (`idplace`),
  CONSTRAINT `provided_in_idservice` FOREIGN KEY (`idservice`) REFERENCES `service` (`idservice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table register_in_service:
CREATE TABLE `register_in_service` (
  `idservice` int NOT NULL,
  `idnfc` int NOT NULL,
  `registerdatetime` datetime NOT NULL,
  PRIMARY KEY (`idservice`,`idnfc`),
  KEY `register_idnfc_idx` (`idnfc`),
  CONSTRAINT `register_idnfc` FOREIGN KEY (`idnfc`) REFERENCES `customer` (`idnfc`),
  CONSTRAINT `register_service` FOREIGN KEY (`idservice`) REFERENCES `service` (`idservice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--Table service
CREATE TABLE `service` (
  `idservice` int NOT NULL AUTO_INCREMENT,
  `servicedescription` varchar(45) NOT NULL,
  `needsregistration` tinyint NOT NULL,
  PRIMARY KEY (`idservice`),
  UNIQUE KEY `idservice_UNIQUE` (`idservice`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table service_change:
CREATE TABLE `service_charge` (
  `idservice` int NOT NULL,
  `idnfc` int NOT NULL,
  `chargedatetime` datetime NOT NULL,
  `description` varchar(45) NOT NULL,
  `cost` double NOT NULL,
  PRIMARY KEY (`idservice`,`idnfc`,`chargedatetime`),
  KEY `charge_idnfc_idx` (`idnfc`),
  CONSTRAINT `charge_idnfc` FOREIGN KEY (`idnfc`) REFERENCES `customer` (`idnfc`),
  CONSTRAINT `charge_idservice` FOREIGN KEY (`idservice`) REFERENCES `service` (`idservice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table visits:
CREATE TABLE `visits` (
  `idplace` int NOT NULL,
  `idnfc` int NOT NULL,
  `entrydatetime` datetime NOT NULL,
  `exitdatetime` datetime NOT NULL,
  PRIMARY KEY (`idnfc`,`idplace`),
  KEY `visits_idplace_idx` (`idplace`),
  CONSTRAINT `visits_idnfc` FOREIGN KEY (`idnfc`) REFERENCES `customer` (`idnfc`),
  CONSTRAINT `visits_idplace` FOREIGN KEY (`idplace`) REFERENCES `place` (`idplace`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

------------------------------------------------------------------------------------------------------------------------

-- Below is the code for the Data insertion:

-- Insert data into customer:
INSERT INTO `customer` VALUES (1,'Bob','Myers','1978-10-21','MB5959346','Passport','Police Department of Korydallos'),(2,'Byron','Holden','1956-05-03','HI2145639','Passport','Police Department of Peiraias'),(3,'Brock','Delgado','2014-11-20','CS2491175','Passport','Police Department of Kallithea'),(4,'Bruno','Ballard','2004-07-15','WM1609761','Passport','Police Department of Alimos'),(5,'Jana','Fitzgerald','2015-06-19','CD4156667','Passport','Police Department of Zografos'),(6,'Ulla','Montoya','1973-08-11','TL7452608','Passport','Police Department of Vyronas'),(7,'Akeem','Chaney','1983-03-21','ZY6554981','Passport','Police Department of Glyfada'),(8,'Genevieve','Walton','1951-06-10','HN2490123','Passport','Police Department of Peiraias'),(9,'Ora','Garrison','1993-10-12','VR3109651','Passport','Police Department of Peiraias'),(10,'Natalie','Good','2017-07-03','UB4209210','Passport','Police Department of Keratsini'),(11,'Graham','Mcgowan','2000-05-19','LE6805340','Passport','Police Department of Galatsi'),(12,'Kevin','Woods','1994-11-02','FK6492514','Passport','Police Department of Elliniko'),(13,'Hayes','Mcguire','1970-03-25','HI4259642','Passport','Police Department of Keratsini'),(14,'Ira','Rosales','2020-10-12','RA8602544','Passport','Police Department of Palaio Falhro'),(15,'Desirae','Dalton','1969-01-10','AO9929813','Passport','Police Department of Athina'),(16,'Amethyst','Dejesus','1967-07-31','MP5736610','Passport','Police Department of Kallithea'),(17,'Delilah','Nelson','1961-06-28','BE1203259','Passport','Police Department of Palaio Falhro'),(18,'Brian','Spears','1951-12-24','UR0290293','Passport','Police Department of Palaio Falhro'),(19,'Adele','Maldonado','1990-02-19','MN8807247','Passport','Police Department of Galatsi'),(20,'Gage','Morin','1963-08-26','XS7566085','Passport','Police Department of Kallithea'),(21,'Alisa','Campos','1965-12-21','NZ870986','ID Card','Police Department of Keratsini'),(22,'Jeremy','Greer','1993-11-23','GG029307','ID Card','Police Department of Vyronas'),(23,'Griffith','Kaufman','1995-11-12','JB819561','ID Card','Police Department of Glyfada'),(24,'Angelica','Barker','2006-09-21','PD352002','ID Card','Police Department of Keratsini'),(25,'Amber','Sanford','1967-12-15','OE159212','ID Card','Police Department of Korydallos'),(26,'Graham','Buchanan','1970-09-25','UP653319','ID Card','Police Department of Glyfada'),(27,'Sylvia','Francis','1968-06-16','LQ062559','ID Card','Police Department of Vyronas'),(28,'Rinah','Holden','1998-12-05','WZ308718','ID Card','Police Department of Vyronas'),(29,'Troy','Mccoy','1981-05-30','OD047951','ID Card','Police Department of Glyfada'),(30,'Dora','Strong','1996-08-25','JQ659758','ID Card','Police Department of Kallithea');

-- Insert data into email:
INSERT INTO `email` VALUES (19,'adelemaldonado25@gmail.com'),(7,'akeemchaney13@gmail.com'),(21,'alisacampos67@gmail.com'),(25,'ambersanford73@gmail.com'),(16,'amethystdejesus98@gmail.com'),(24,'angelicabarker53@gmail.com'),(18,'brianspears91@gmail.com'),(3,'brockdelgado22@gmail.com'),(4,'brunoballard75@gmail.com'),(2,'byronholden48@gmail.com'),(17,'delilahnelson27@gmail.com'),(15,'desiraedalton94@gmail.com'),(30,'dorastrong92@gmail.com'),(20,'gagemorin74@gmail.com'),(8,'genevievewalton73@gmail.com'),(26,'grahambuchanan58@gmail.com'),(11,'grahammcgowan51@gmail.com'),(23,'griffithkaufman44@gmail.com'),(13,'hayesmcguire94@gmail.com'),(14,'irarosales32@gmail.com'),(5,'janafitzgerald69@gmail.com'),(22,'jeremygreer74@gmail.com'),(12,'kevinwoods69@gmail.com'),(10,'nataliegood22@gmail.com'),(9,'oragarrison73@gmail.com'),(28,'rinahholden36@gmail.com'),(27,'sylviafrancis71@gmail.com'),(1,'toddmyers93@gmail.com'),(29,'troymccoy71@gmail.com'),(6,'ullamontoya72@gmail.com');

-- Insert data into has_access:
INSERT INTO `has_access` VALUES (1,1,'2021-06-16 18:10:32','2021-06-23 18:10:32'),(2,2,'2021-06-17 15:06:51','2021-06-24 15:06:51'),(3,3,'2021-06-16 00:19:32','2021-06-23 00:19:32'),(4,4,'2021-06-18 02:17:09','2021-06-25 02:17:09'),(5,5,'2021-06-16 23:20:31','2021-06-23 23:20:31'),(6,6,'2021-06-16 16:12:05','2021-06-23 16:12:05'),(7,7,'2021-06-16 02:39:57','2021-06-23 02:39:57'),(8,8,'2021-06-18 16:15:48','2021-06-25 16:15:48'),(9,9,'2021-06-16 18:34:31','2021-06-23 18:34:31'),(10,10,'2021-06-17 06:12:46','2021-06-24 06:12:46'),(11,11,'2021-06-18 00:44:37','2021-06-25 00:44:37'),(12,12,'2021-06-18 21:19:30','2021-06-25 21:19:30'),(13,13,'2021-06-17 10:07:24','2021-06-24 10:07:24'),(14,14,'2021-06-17 14:16:44','2021-06-24 14:16:44'),(15,15,'2021-06-18 10:26:58','2021-06-25 10:26:58'),(16,16,'2021-06-18 15:51:18','2021-06-25 15:51:18'),(17,17,'2021-06-18 16:57:00','2021-06-25 16:57:00'),(18,18,'2021-06-17 04:20:40','2021-06-24 04:20:40'),(19,19,'2021-06-16 20:06:58','2021-06-23 20:06:58'),(20,20,'2021-06-18 21:13:07','2021-06-25 21:13:07'),(21,21,'2021-06-18 09:36:06','2021-06-25 09:36:06'),(22,22,'2021-06-18 05:30:18','2021-06-25 05:30:18'),(23,23,'2021-06-16 14:55:52','2021-06-23 14:55:52'),(24,24,'2021-06-18 05:44:24','2021-06-25 05:44:24'),(25,25,'2021-06-17 21:23:26','2021-06-24 21:23:26'),(26,26,'2021-06-17 14:02:48','2021-06-24 14:02:48'),(27,27,'2021-06-17 07:54:40','2021-06-24 07:54:40'),(28,28,'2021-06-18 18:31:18','2021-06-25 18:31:18'),(29,29,'2021-06-18 19:15:33','2021-06-25 19:15:33'),(30,30,'2021-06-17 05:13:56','2021-06-24 05:13:56'),(81,2,'2021-06-20 18:26:10','2021-06-27 18:26:10'),(81,16,'2021-06-21 09:26:06','2021-06-28 09:26:06'),(81,20,'2021-06-23 18:16:31','2021-06-30 18:16:31'),(81,21,'2021-06-21 04:47:52','2021-06-28 04:47:52'),(81,25,'2021-06-22 12:48:58','2021-06-29 12:48:58'),(82,2,'2021-06-20 18:26:10','2021-06-27 18:26:10'),(82,16,'2021-06-21 09:26:06','2021-06-28 09:26:06'),(82,20,'2021-06-23 18:16:31','2021-06-30 18:16:31'),(82,21,'2021-06-21 04:47:52','2021-06-28 04:47:52'),(82,25,'2021-06-22 12:48:58','2021-06-29 12:48:58'),(83,2,'2021-06-20 18:26:10','2021-06-27 18:26:10'),(83,16,'2021-06-21 09:26:06','2021-06-28 09:26:06'),(83,20,'2021-06-23 18:16:31','2021-06-30 18:16:31'),(83,21,'2021-06-21 04:47:52','2021-06-28 04:47:52'),(83,25,'2021-06-22 12:48:58','2021-06-29 12:48:58'),(84,2,'2021-06-20 18:26:10','2021-06-27 18:26:10'),(84,16,'2021-06-21 09:26:06','2021-06-28 09:26:06'),(84,20,'2021-06-23 18:16:31','2021-06-30 18:16:31'),(84,21,'2021-06-21 04:47:52','2021-06-28 04:47:52'),(84,25,'2021-06-22 12:48:58','2021-06-29 12:48:58'),(85,2,'2021-06-20 18:26:10','2021-06-27 18:26:10'),(85,16,'2021-06-21 09:26:06','2021-06-28 09:26:06'),(85,20,'2021-06-23 18:16:31','2021-06-30 18:16:31'),(85,21,'2021-06-21 04:47:52','2021-06-28 04:47:52'),(85,25,'2021-06-22 12:48:58','2021-06-29 12:48:58'),(86,2,'2021-06-23 17:33:56','2021-06-30 17:33:56'),(86,3,'2021-06-21 11:39:02','2021-06-28 11:39:02'),(86,13,'2021-06-21 19:39:56','2021-06-28 19:39:56'),(86,14,'2021-06-20 18:36:36','2021-06-27 18:36:36'),(86,16,'2021-06-20 08:33:13','2021-06-27 08:33:13'),(86,19,'2021-06-23 16:34:17','2021-06-30 16:34:17'),(86,24,'2021-06-19 03:55:39','2021-06-26 03:55:39'),(86,25,'2021-06-19 08:22:59','2021-06-26 08:22:59'),(87,2,'2021-06-23 17:33:56','2021-06-30 17:33:56'),(87,3,'2021-06-21 11:39:02','2021-06-28 11:39:02'),(87,13,'2021-06-21 19:39:56','2021-06-28 19:39:56'),(87,14,'2021-06-20 18:36:36','2021-06-27 18:36:36'),(87,16,'2021-06-20 08:33:13','2021-06-27 08:33:13'),(87,19,'2021-06-23 16:34:17','2021-06-30 16:34:17'),(87,24,'2021-06-19 03:55:39','2021-06-26 03:55:39'),(87,25,'2021-06-19 08:22:59','2021-06-26 08:22:59'),(88,5,'2021-06-22 07:08:24','2021-06-29 07:08:24'),(88,12,'2021-06-20 07:52:04','2021-06-27 07:52:04'),(88,15,'2021-06-20 19:19:34','2021-06-27 19:19:34'),(88,18,'2021-06-19 07:24:04','2021-06-26 07:24:04'),(88,30,'2021-06-23 19:49:54','2021-06-30 19:49:54'),(89,3,'2021-06-23 23:05:53','2021-06-30 23:05:53'),(89,5,'2021-06-20 07:01:25','2021-06-27 07:01:25'),(89,6,'2021-06-21 09:37:41','2021-06-28 09:37:41'),(89,7,'2021-06-20 22:57:37','2021-06-27 22:57:37'),(89,8,'2021-06-20 12:35:59','2021-06-27 12:35:59'),(89,10,'2021-06-22 05:04:58','2021-06-29 05:04:58'),(89,12,'2021-06-23 20:10:58','2021-06-30 20:10:58'),(89,13,'2021-06-21 13:41:04','2021-06-28 13:41:04'),(89,14,'2021-06-22 16:03:02','2021-06-29 16:03:02'),(89,22,'2021-06-20 08:25:03','2021-06-27 08:25:03'),(89,27,'2021-06-23 16:09:04','2021-06-30 16:09:04'),(89,28,'2021-06-19 18:43:30','2021-06-26 18:43:30'),(89,29,'2021-06-19 14:22:15','2021-06-26 14:22:15'),(89,30,'2021-06-21 17:23:07','2021-06-28 17:23:07'),(90,3,'2021-06-23 23:05:53','2021-06-30 23:05:53'),(90,5,'2021-06-20 07:01:25','2021-06-27 07:01:25'),(90,6,'2021-06-21 09:37:41','2021-06-28 09:37:41'),(90,7,'2021-06-20 22:57:37','2021-06-27 22:57:37'),(90,8,'2021-06-20 12:35:59','2021-06-27 12:35:59'),(90,10,'2021-06-22 05:04:58','2021-06-29 05:04:58'),(90,12,'2021-06-23 20:10:58','2021-06-30 20:10:58'),(90,13,'2021-06-21 13:41:04','2021-06-28 13:41:04'),(90,14,'2021-06-22 16:03:02','2021-06-29 16:03:02'),(90,22,'2021-06-20 08:25:03','2021-06-27 08:25:03'),(90,27,'2021-06-23 16:09:04','2021-06-30 16:09:04'),(90,28,'2021-06-19 18:43:30','2021-06-26 18:43:30'),(90,29,'2021-06-19 14:22:15','2021-06-26 14:22:15'),(90,30,'2021-06-21 17:23:07','2021-06-28 17:23:07'),(91,1,'2021-06-21 00:23:11','2021-06-28 00:23:11'),(91,4,'2021-06-22 20:51:46','2021-06-29 20:51:46'),(91,9,'2021-06-19 18:29:16','2021-06-26 18:29:16'),(91,11,'2021-06-21 06:00:47','2021-06-28 06:00:47'),(91,15,'2021-06-23 02:20:28','2021-06-30 02:20:28'),(91,17,'2021-06-23 11:06:42','2021-06-30 11:06:42'),(91,18,'2021-06-20 17:56:25','2021-06-27 17:56:25'),(91,19,'2021-06-21 15:40:28','2021-06-28 15:40:28'),(91,23,'2021-06-23 19:08:11','2021-06-30 19:08:11'),(91,24,'2021-06-19 14:57:57','2021-06-26 14:57:57'),(91,26,'2021-06-21 17:18:16','2021-06-28 17:18:16'),(93,1,'2021-06-21 00:23:11','2021-06-28 00:23:11'),(93,4,'2021-06-22 20:51:46','2021-06-29 20:51:46'),(93,9,'2021-06-19 18:29:16','2021-06-26 18:29:16'),(93,11,'2021-06-21 06:00:47','2021-06-28 06:00:47'),(93,15,'2021-06-23 02:20:28','2021-06-30 02:20:28'),(93,17,'2021-06-23 11:06:42','2021-06-30 11:06:42'),(93,18,'2021-06-20 17:56:25','2021-06-27 17:56:25'),(93,19,'2021-06-21 15:40:28','2021-06-28 15:40:28'),(93,23,'2021-06-23 19:08:11','2021-06-30 19:08:11'),(93,24,'2021-06-19 14:57:57','2021-06-26 14:57:57'),(93,26,'2021-06-21 17:18:16','2021-06-28 17:18:16'),(94,1,'2021-06-21 00:23:11','2021-06-28 00:23:11'),(94,4,'2021-06-22 20:51:46','2021-06-29 20:51:46'),(94,9,'2021-06-19 18:29:16','2021-06-26 18:29:16'),(94,11,'2021-06-21 06:00:47','2021-06-28 06:00:47'),(94,15,'2021-06-23 02:20:28','2021-06-30 02:20:28'),(94,17,'2021-06-23 11:06:42','2021-06-30 11:06:42'),(94,18,'2021-06-20 17:56:25','2021-06-27 17:56:25'),(94,19,'2021-06-21 15:40:28','2021-06-28 15:40:28'),(94,23,'2021-06-23 19:08:11','2021-06-30 19:08:11'),(94,24,'2021-06-19 14:57:57','2021-06-26 14:57:57'),(94,26,'2021-06-21 17:18:16','2021-06-28 17:18:16'),(95,1,'2021-06-21 00:23:11','2021-06-28 00:23:11'),(95,4,'2021-06-22 20:51:46','2021-06-29 20:51:46'),(95,9,'2021-06-19 18:29:16','2021-06-26 18:29:16'),(95,11,'2021-06-21 06:00:47','2021-06-28 06:00:47'),(95,15,'2021-06-23 02:20:28','2021-06-30 02:20:28'),(95,17,'2021-06-23 11:06:42','2021-06-30 11:06:42'),(95,18,'2021-06-20 17:56:25','2021-06-27 17:56:25'),(95,19,'2021-06-21 15:40:28','2021-06-28 15:40:28'),(95,23,'2021-06-23 19:08:11','2021-06-30 19:08:11'),(95,24,'2021-06-19 14:57:57','2021-06-26 14:57:57'),(95,26,'2021-06-21 17:18:16','2021-06-28 17:18:16'),(96,1,'2021-06-21 00:23:11','2021-06-28 00:23:11'),(96,4,'2021-06-22 20:51:46','2021-06-29 20:51:46'),(96,9,'2021-06-19 18:29:16','2021-06-26 18:29:16'),(96,11,'2021-06-21 06:00:47','2021-06-28 06:00:47'),(96,15,'2021-06-23 02:20:28','2021-06-30 02:20:28'),(96,17,'2021-06-23 11:06:42','2021-06-30 11:06:42'),(96,18,'2021-06-20 17:56:25','2021-06-27 17:56:25'),(96,19,'2021-06-21 15:40:28','2021-06-28 15:40:28'),(96,23,'2021-06-23 19:08:11','2021-06-30 19:08:11'),(96,24,'2021-06-19 14:57:57','2021-06-26 14:57:57'),(96,26,'2021-06-21 17:18:16','2021-06-28 17:18:16'),(99,1,'2021-06-23 16:22:49','2021-06-30 16:22:49'),(99,4,'2021-06-23 22:20:05','2021-06-30 22:20:05'),(99,6,'2021-06-22 08:08:28','2021-06-29 08:08:28'),(99,7,'2021-06-20 10:51:51','2021-06-27 10:51:51'),(99,8,'2021-06-21 22:26:27','2021-06-28 22:26:27'),(99,9,'2021-06-23 08:27:46','2021-06-30 08:27:46'),(99,10,'2021-06-23 04:56:03','2021-06-30 04:56:03'),(99,11,'2021-06-22 19:48:57','2021-06-29 19:48:57'),(99,17,'2021-06-20 21:20:26','2021-06-27 21:20:26'),(99,20,'2021-06-21 00:26:36','2021-06-28 00:26:36'),(99,21,'2021-06-23 19:39:28','2021-06-30 19:39:28'),(99,22,'2021-06-20 00:51:24','2021-06-27 00:51:24'),(99,23,'2021-06-21 12:09:50','2021-06-28 12:09:50'),(99,26,'2021-06-23 20:43:33','2021-06-30 20:43:33'),(99,27,'2021-06-22 03:51:51','2021-06-29 03:51:51'),(99,28,'2021-06-20 02:45:11','2021-06-27 02:45:11'),(99,29,'2021-06-19 05:00:47','2021-06-26 05:00:47'),(100,1,'2021-06-23 16:22:49','2021-06-30 16:22:49'),(100,4,'2021-06-23 22:20:05','2021-06-30 22:20:05'),(100,6,'2021-06-22 08:08:28','2021-06-29 08:08:28'),(100,7,'2021-06-20 10:51:51','2021-06-27 10:51:51'),(100,8,'2021-06-21 22:26:27','2021-06-28 22:26:27'),(100,9,'2021-06-23 08:27:46','2021-06-30 08:27:46'),(100,10,'2021-06-23 04:56:03','2021-06-30 04:56:03'),(100,11,'2021-06-22 19:48:57','2021-06-29 19:48:57'),(100,17,'2021-06-20 21:20:26','2021-06-27 21:20:26'),(100,20,'2021-06-21 00:26:36','2021-06-28 00:26:36'),(100,21,'2021-06-23 19:39:28','2021-06-30 19:39:28'),(100,22,'2021-06-20 00:51:24','2021-06-27 00:51:24'),(100,23,'2021-06-21 12:09:50','2021-06-28 12:09:50'),(100,26,'2021-06-23 20:43:33','2021-06-30 20:43:33'),(100,27,'2021-06-22 03:51:51','2021-06-29 03:51:51'),(100,28,'2021-06-20 02:45:11','2021-06-27 02:45:11'),(100,29,'2021-06-19 05:00:47','2021-06-26 05:00:47');

-- Insert data into phone_number:
INSERT INTO `phone_number` VALUES (28,'306901905755'),(24,'306909842905'),(25,'306910939806'),(13,'306911750711'),(10,'306912153227'),(3,'306913739184'),(23,'306913981305'),(12,'306926871956'),(22,'306931082218'),(29,'306934329188'),(30,'306935951585'),(2,'306936578622'),(6,'306937691690'),(16,'306939848155'),(9,'306944604243'),(20,'306946600676'),(27,'306947063142'),(11,'306947293403'),(17,'306953131578'),(26,'306955826792'),(5,'306959139019'),(15,'306959519041'),(7,'306960153372'),(4,'306960700042'),(1,'306961235927'),(8,'306978834766'),(14,'306982139532'),(18,'306988751865'),(21,'306990304465'),(19,'306993144395');

-- Insert data into place:
INSERT INTO `place` VALUES (1,4,'Room','3 North'),(2,4,'Room','2 West'),(3,3,'Room','4 West'),(4,3,'Room','2 East'),(5,3,'Room','5 West'),(6,3,'Room','1 North'),(7,3,'Room','2 East'),(8,1,'Room','1 North'),(9,4,'Room','4 West'),(10,1,'Room','1 West'),(11,3,'Room','5 East'),(12,2,'Room','1 North'),(13,3,'Room','3 North'),(14,2,'Room','4 West'),(15,4,'Room','2 North'),(16,2,'Room','5 South'),(17,4,'Room','3 North'),(18,3,'Room','5 West'),(19,2,'Room','4 West'),(20,3,'Room','4 South'),(21,3,'Room','4 South'),(22,2,'Room','5 North'),(23,1,'Room','2 West'),(24,2,'Room','1 West'),(25,2,'Room','4 East'),(26,2,'Room','3 North'),(27,3,'Room','3 North'),(28,3,'Room','5 East'),(29,4,'Room','4 South'),(30,2,'Room','3 South'),(31,1,'Room','1 North'),(32,3,'Room','4 South'),(33,3,'Room','2 West'),(34,2,'Room','3 West'),(35,2,'Room','4 West'),(36,1,'Room','4 West'),(37,4,'Room','4 East'),(38,1,'Room','4 North'),(39,4,'Room','3 South'),(40,2,'Room','3 North'),(41,2,'Room','4 West'),(42,2,'Room','2 North'),(43,2,'Room','3 East'),(44,3,'Room','4 West'),(45,1,'Room','4 West'),(46,4,'Room','4 West'),(47,3,'Room','3 North'),(48,2,'Room','3 South'),(49,2,'Room','4 South'),(50,3,'Room','5 East'),(51,4,'Room','2 East'),(52,1,'Room','1 North'),(53,1,'Room','2 North'),(54,2,'Room','2 West'),(55,1,'Room','1 West'),(56,2,'Room','1 North'),(57,3,'Room','3 South'),(58,2,'Room','2 West'),(59,1,'Room','3 North'),(60,3,'Room','2 East'),(61,1,'Room','4 West'),(62,1,'Room','4 East'),(63,4,'Room','2 South'),(64,4,'Room','2 South'),(65,3,'Room','5 North'),(66,4,'Room','3 North'),(67,2,'Room','1 North'),(68,3,'Room','4 West'),(69,2,'Room','5 East'),(70,4,'Room','2 West'),(71,3,'Room','4 West'),(72,1,'Room','5 East'),(73,2,'Room','5 East'),(74,2,'Room','5 North'),(75,3,'Room','4 South'),(76,3,'Room','1 West'),(77,1,'Room','5 North'),(78,4,'Room','4 South'),(79,3,'Room','3 West'),(80,3,'Room','2 East'),(81,0,'Conference Room','2 North'),(82,0,'Conference Room','5 North'),(83,0,'Conference Room','1 East'),(84,0,'Conference Room','1 North'),(85,0,'Conference Room','5 South'),(86,0,'Bar','3 East'),(87,0,'Bar','4 West'),(88,0,'Barbershop','4 West'),(89,0,'Gym','2 West'),(90,0,'Gym','2 East'),(91,0,'Sauna','4 West'),(92,0,'Reception','1 West'),(93,0,'Sauna','1 South'),(94,0,'Sauna','3 North'),(95,0,'Sauna','4 South'),(96,0,'Sauna','3 North'),(97,0,'Elevator','4 East'),(98,0,'Elevator','1 North'),(99,0,'Restaurant','2 South'),(100,0,'Restaurant','3 North');

-- Insert data into provided_in:
INSERT INTO `provided_in` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(24,1),(25,1),(26,1),(27,1),(28,1),(29,1),(30,1),(31,1),(32,1),(33,1),(34,1),(35,1),(36,1),(37,1),(38,1),(39,1),(40,1),(41,1),(42,1),(43,1),(44,1),(45,1),(46,1),(47,1),(48,1),(49,1),(50,1),(51,1),(52,1),(53,1),(54,1),(55,1),(56,1),(57,1),(58,1),(59,1),(60,1),(61,1),(62,1),(63,1),(64,1),(65,1),(66,1),(67,1),(68,1),(69,1),(70,1),(71,1),(72,1),(73,1),(74,1),(75,1),(76,1),(77,1),(78,1),(79,1),(80,1),(86,2),(87,2),(99,3),(100,3),(88,4),(89,5),(90,5),(81,6),(82,6),(83,6),(84,6),(85,6),(91,7),(93,7),(94,7),(95,7),(96,7);

-- Insert data into register_in_service:
INSERT INTO `register_in_service` VALUES (1,1,'2021-06-16 18:10:32'),(1,2,'2021-06-17 15:06:51'),(1,3,'2021-06-16 00:19:32'),(1,4,'2021-06-18 02:17:09'),(1,5,'2021-06-16 23:20:31'),(1,6,'2021-06-16 16:12:05'),(1,7,'2021-06-16 02:39:57'),(1,8,'2021-06-18 16:15:48'),(1,9,'2021-06-16 18:34:31'),(1,10,'2021-06-17 06:12:46'),(1,11,'2021-06-18 00:44:37'),(1,12,'2021-06-18 21:19:30'),(1,13,'2021-06-17 10:07:24'),(1,14,'2021-06-17 14:16:44'),(1,15,'2021-06-18 10:26:58'),(1,16,'2021-06-18 15:51:18'),(1,17,'2021-06-18 16:57:00'),(1,18,'2021-06-17 04:20:40'),(1,19,'2021-06-16 20:06:58'),(1,20,'2021-06-18 21:13:07'),(1,21,'2021-06-18 09:36:06'),(1,22,'2021-06-18 05:30:18'),(1,23,'2021-06-16 14:55:52'),(1,24,'2021-06-18 05:44:24'),(1,25,'2021-06-17 21:23:26'),(1,26,'2021-06-17 14:02:48'),(1,27,'2021-06-17 07:54:40'),(1,28,'2021-06-18 18:31:18'),(1,29,'2021-06-18 19:15:33'),(1,30,'2021-06-17 05:13:56'),(2,2,'2021-06-23 17:33:56'),(2,3,'2021-06-21 11:39:02'),(2,13,'2021-06-21 19:39:56'),(2,14,'2021-06-20 18:36:36'),(2,16,'2021-06-20 08:33:13'),(2,19,'2021-06-23 16:34:17'),(2,24,'2021-06-19 03:55:39'),(2,25,'2021-06-19 08:22:59'),(3,1,'2021-06-23 16:22:49'),(3,4,'2021-06-23 22:20:05'),(3,6,'2021-06-22 08:08:28'),(3,7,'2021-06-20 10:51:51'),(3,8,'2021-06-21 22:26:27'),(3,9,'2021-06-23 08:27:46'),(3,10,'2021-06-23 04:56:03'),(3,11,'2021-06-22 19:48:57'),(3,17,'2021-06-20 21:20:26'),(3,20,'2021-06-21 00:26:36'),(3,21,'2021-06-23 19:39:28'),(3,22,'2021-06-20 00:51:24'),(3,23,'2021-06-21 12:09:50'),(3,26,'2021-06-23 20:43:33'),(3,27,'2021-06-22 03:51:51'),(3,28,'2021-06-20 02:45:11'),(3,29,'2021-06-19 05:00:47'),(4,5,'2021-06-22 07:08:24'),(4,12,'2021-06-20 07:52:04'),(4,15,'2021-06-20 19:19:34'),(4,18,'2021-06-19 07:24:04'),(4,30,'2021-06-23 19:49:54'),(5,3,'2021-06-23 23:05:53'),(5,5,'2021-06-20 07:01:25'),(5,6,'2021-06-21 09:37:41'),(5,7,'2021-06-20 22:57:37'),(5,8,'2021-06-20 12:35:59'),(5,9,'2021-06-21 04:47:52'),(5,10,'2021-06-22 05:04:58'),(5,12,'2021-06-23 20:10:58'),(5,13,'2021-06-21 13:41:04'),(5,14,'2021-06-22 16:03:02'),(5,22,'2021-06-20 08:25:03'),(5,27,'2021-06-23 16:09:04'),(5,28,'2021-06-19 18:43:30'),(5,29,'2021-06-19 14:22:15'),(5,30,'2021-06-21 17:23:07'),(6,2,'2021-06-20 18:26:10'),(6,16,'2021-06-21 09:26:06'),(6,20,'2021-06-23 18:16:31'),(6,21,'2021-06-21 04:47:52'),(6,25,'2021-06-22 12:48:58'),(7,1,'2021-06-21 00:23:11'),(7,4,'2021-06-22 20:51:46'),(7,9,'2021-06-19 18:29:16'),(7,11,'2021-06-21 06:00:47'),(7,15,'2021-06-23 02:20:28'),(7,17,'2021-06-23 11:06:42'),(7,18,'2021-06-20 17:56:25'),(7,19,'2021-06-21 15:40:28'),(7,23,'2021-06-23 19:08:11'),(7,24,'2021-06-19 14:57:57'),(7,26,'2021-06-21 17:18:16');

-- Insert data into service:
INSERT INTO `service` VALUES (1,'Room',1),(2,'Bar',0),(3,'Restaurant',0),(4,'Barbershop',0),(5,'Gym',1),(6,'Conference Room',1),(7,'Sauna',1);

-- Insert data into service_charge:
INSERT INTO `service_charge` VALUES (1,1,'2021-06-16 18:10:32','Visit fee',200),(1,2,'2021-06-17 15:06:51','Visit fee',500),(1,3,'2021-06-16 00:19:32','Visit fee',200),(1,4,'2021-06-18 02:17:09','Visit fee',500),(1,5,'2021-06-16 23:20:31','Visit fee',200),(1,6,'2021-06-16 16:12:05','Visit fee',500),(1,7,'2021-06-16 02:39:57','Visit fee',200),(1,8,'2021-06-18 16:15:48','Visit fee',500),(1,9,'2021-06-16 18:34:31','Visit fee',200),(1,10,'2021-06-17 06:12:46','Visit fee',500),(1,11,'2021-06-18 00:44:37','Visit fee',200),(1,12,'2021-06-18 21:19:30','Visit fee',500),(1,13,'2021-06-17 10:07:24','Visit fee',200),(1,14,'2021-06-17 14:16:44','Visit fee',500),(1,15,'2021-06-18 10:26:58','Visit fee',200),(1,16,'2021-06-18 15:51:18','Visit fee',500),(1,17,'2021-06-18 16:57:00','Visit fee',200),(1,18,'2021-06-17 04:20:40','Visit fee',500),(1,19,'2021-06-16 20:06:58','Visit fee',200),(1,20,'2021-06-18 21:13:07','Visit fee',500),(1,21,'2021-06-18 09:36:06','Visit fee',200),(1,22,'2021-06-18 05:30:18','Visit fee',500),(1,23,'2021-06-16 14:55:52','Visit fee',200),(1,24,'2021-06-18 05:44:24','Visit fee',500),(1,25,'2021-06-17 21:23:26','Visit fee',200),(1,26,'2021-06-17 14:02:48','Visit fee',500),(1,27,'2021-06-17 07:54:40','Visit fee',200),(1,28,'2021-06-18 18:31:18','Visit fee',500),(1,29,'2021-06-18 19:15:33','Visit fee',200),(1,30,'2021-06-17 05:13:56','Visit fee',500),(2,2,'2021-06-23 17:33:56','Drink fee',10),(2,3,'2021-06-21 11:39:02','Drink fee',10),(2,9,'2021-06-26 18:10:32','Drink fee',40),(2,9,'2021-06-27 15:06:51','Drink fee',10),(2,12,'2021-06-26 18:10:32','Drink fee',40),(2,13,'2021-06-21 19:39:56','Drink fee',10),(2,14,'2021-06-20 18:36:36','Drink fee',10),(2,16,'2021-06-20 08:33:13','Drink fee',10),(2,19,'2021-06-23 16:34:17','Drink fee',10),(2,24,'2021-06-19 03:55:39','Drink fee',10),(2,25,'2021-06-19 08:22:59','Drink fee',10),(3,1,'2021-06-23 16:22:49','Meal fee',25),(3,4,'2021-06-23 22:20:05','Meal fee',25),(3,6,'2021-06-22 08:08:28','Meal fee',25),(3,7,'2021-06-20 10:51:51','Meal fee',25),(3,8,'2021-06-21 22:26:27','Meal fee',25),(3,9,'2021-06-23 08:27:46','Meal fee',25),(3,10,'2021-06-23 04:56:03','Meal fee',25),(3,11,'2021-06-22 19:48:57','Meal fee',25),(3,17,'2021-06-20 21:20:26','Meal fee',25),(3,20,'2021-06-21 00:26:36','Meal fee',25),(3,21,'2021-06-23 19:39:28','Meal fee',25),(3,22,'2021-06-20 00:51:24','Meal fee',25),(3,23,'2021-06-21 12:09:50','Meal fee',25),(3,26,'2021-06-23 20:43:33','Meal fee',25),(3,27,'2021-06-22 03:51:51','Meal fee',25),(3,28,'2021-06-20 02:45:11','Meal fee',25),(3,29,'2021-06-19 05:00:47','Meal fee',25),(4,5,'2021-06-22 07:08:24','Haircut fee',20),(4,12,'2021-06-20 07:52:04','Haircut fee',20),(4,15,'2021-06-20 19:19:34','Haircut fee',20),(4,18,'2021-06-19 07:24:04','Haircut fee',20),(4,30,'2021-06-23 19:49:54','Haircut fee',20),(5,3,'2021-06-23 23:05:53','Training fee',15),(5,5,'2021-06-20 07:01:25','Training fee',15),(5,6,'2021-06-21 09:37:41','Training fee',15),(5,7,'2021-06-20 22:57:37','Training fee',15),(5,8,'2021-06-20 12:35:59','Training fee',15),(5,10,'2021-06-22 05:04:58','Training fee',15),(5,12,'2021-06-23 20:10:58','Training fee',15),(5,13,'2021-06-21 13:41:04','Training fee',15),(5,14,'2021-06-22 16:03:02','Training fee',15),(5,22,'2021-06-20 08:25:03','Training fee',15),(5,27,'2021-06-23 16:09:04','Training fee',15),(5,28,'2021-06-19 18:43:30','Training fee',15),(5,29,'2021-06-19 14:22:15','Training fee',15),(5,30,'2021-06-21 17:23:07','Training fee',15),(6,1,'2021-06-21 00:23:11','Sauna fee',30),(6,2,'2021-06-20 18:26:10','Conference room rental fee',80),(6,4,'2021-06-22 20:51:46','Sauna fee',30),(6,9,'2021-06-19 18:29:16','Sauna fee',30),(6,11,'2021-06-21 06:00:47','Sauna fee',30),(6,15,'2021-06-23 02:20:28','Sauna fee',30),(6,16,'2021-06-21 09:26:06','Conference room rental fee',80),(6,17,'2021-06-23 11:06:42','Sauna fee',30),(6,18,'2021-06-20 17:56:25','Sauna fee',30),(6,19,'2021-06-21 15:40:28','Sauna fee',30),(6,20,'2021-06-23 18:16:31','Conference room rental fee',80),(6,21,'2021-06-21 04:47:52','Conference room rental fee',80),(6,23,'2021-06-23 19:08:11','Sauna fee',30),(6,24,'2021-06-19 14:57:57','Sauna fee',30),(6,25,'2021-06-22 12:48:58','Conference room rental fee',80),(6,26,'2021-06-21 17:18:16','Sauna fee',30);

-- Insert data into visits:
INSERT INTO `visits` VALUES (1,1,'2021-06-16 18:10:32','2021-06-17 18:10:32'),(91,1,'2021-06-21 00:23:11','2021-06-22 00:23:11'),(99,1,'2021-06-23 16:22:49','2021-06-24 16:22:49'),(2,2,'2021-06-17 15:06:51','2021-06-18 15:06:51'),(81,2,'2021-06-20 18:26:10','2021-06-21 18:26:10'),(86,2,'2021-06-23 17:33:56','2021-06-24 17:33:56'),(3,3,'2021-06-16 00:19:32','2021-06-17 00:19:32'),(86,3,'2021-06-21 11:39:02','2021-06-22 11:39:02'),(89,3,'2021-06-23 23:05:53','2021-06-24 23:05:53'),(4,4,'2021-06-18 02:17:09','2021-06-19 02:17:09'),(91,4,'2021-06-22 20:51:46','2021-06-23 20:51:46'),(99,4,'2021-06-23 22:20:05','2021-06-24 22:20:05'),(5,5,'2021-06-16 23:20:31','2021-06-17 23:20:31'),(88,5,'2021-06-22 07:08:24','2021-06-23 07:08:24'),(89,5,'2021-06-20 07:01:25','2021-06-21 07:01:25'),(6,6,'2021-06-16 16:12:05','2021-06-17 16:12:05'),(89,6,'2021-06-21 09:37:41','2021-06-22 09:37:41'),(99,6,'2021-06-22 08:08:28','2021-06-23 08:08:28'),(7,7,'2021-06-16 02:39:57','2021-06-17 02:39:57'),(89,7,'2021-06-20 22:57:37','2021-06-21 22:57:37'),(99,7,'2021-06-20 10:51:51','2021-06-21 10:51:51'),(8,8,'2021-06-18 16:15:48','2021-06-19 16:15:48'),(89,8,'2021-06-20 12:35:59','2021-06-21 12:35:59'),(99,8,'2021-06-21 22:26:27','2021-06-22 22:26:27'),(9,9,'2021-06-16 18:34:31','2021-06-17 18:34:31'),(91,9,'2021-06-19 18:29:16','2021-06-20 18:29:16'),(99,9,'2021-06-23 08:27:46','2021-06-24 08:27:46'),(10,10,'2021-06-17 06:12:46','2021-06-18 06:12:46'),(89,10,'2021-06-22 05:04:58','2021-06-23 05:04:58'),(99,10,'2021-06-23 04:56:03','2021-06-24 04:56:03'),(11,11,'2021-06-18 00:44:37','2021-06-19 00:44:37'),(91,11,'2021-06-21 06:00:47','2021-06-22 06:00:47'),(99,11,'2021-06-22 19:48:57','2021-06-23 19:48:57'),(12,12,'2021-06-18 21:19:30','2021-06-19 21:19:30'),(88,12,'2021-06-20 07:52:04','2021-06-21 07:52:04'),(89,12,'2021-06-23 20:10:58','2021-06-24 20:10:58'),(13,13,'2021-06-17 10:07:24','2021-06-18 10:07:24'),(86,13,'2021-06-21 19:39:56','2021-06-22 19:39:56'),(89,13,'2021-06-21 13:41:04','2021-06-22 13:41:04'),(14,14,'2021-06-17 14:16:44','2021-06-18 14:16:44'),(86,14,'2021-06-20 18:36:36','2021-06-21 18:36:36'),(89,14,'2021-06-22 16:03:02','2021-06-23 16:03:02'),(15,15,'2021-06-18 10:26:58','2021-06-19 10:26:58'),(88,15,'2021-06-20 19:19:34','2021-06-21 19:19:34'),(91,15,'2021-06-23 02:20:28','2021-06-24 02:20:28'),(16,16,'2021-06-18 15:51:18','2021-06-19 15:51:18'),(81,16,'2021-06-21 09:26:06','2021-06-22 09:26:06'),(86,16,'2021-06-20 08:33:13','2021-06-21 08:33:13'),(17,17,'2021-06-18 16:57:00','2021-06-19 16:57:00'),(91,17,'2021-06-23 11:06:42','2021-06-24 11:06:42'),(99,17,'2021-06-20 21:20:26','2021-06-21 21:20:26'),(18,18,'2021-06-17 04:20:40','2021-06-18 04:20:40'),(88,18,'2021-06-19 07:24:04','2021-06-20 07:24:04'),(91,18,'2021-06-20 17:56:25','2021-06-21 17:56:25'),(19,19,'2021-06-16 20:06:58','2021-06-17 20:06:58'),(86,19,'2021-06-23 16:34:17','2021-06-24 16:34:17'),(91,19,'2021-06-21 15:40:28','2021-06-22 15:40:28'),(20,20,'2021-06-18 21:13:07','2021-06-19 21:13:07'),(81,20,'2021-06-23 18:16:31','2021-06-24 18:16:31'),(99,20,'2021-06-21 00:26:36','2021-06-22 00:26:36'),(21,21,'2021-06-18 09:36:06','2021-06-19 09:36:06'),(81,21,'2021-06-21 04:47:52','2021-06-22 04:47:52'),(99,21,'2021-06-23 19:39:28','2021-06-24 19:39:28'),(22,22,'2021-06-18 05:30:18','2021-06-19 05:30:18'),(89,22,'2021-06-20 08:25:03','2021-06-21 08:25:03'),(99,22,'2021-06-20 00:51:24','2021-06-21 00:51:24'),(23,23,'2021-06-16 14:55:52','2021-06-17 14:55:52'),(91,23,'2021-06-23 19:08:11','2021-06-24 19:08:11'),(99,23,'2021-06-21 12:09:50','2021-06-22 12:09:50'),(24,24,'2021-06-18 05:44:24','2021-06-19 05:44:24'),(86,24,'2021-06-19 03:55:39','2021-06-20 03:55:39'),(91,24,'2021-06-19 14:57:57','2021-06-20 14:57:57'),(25,25,'2021-06-17 21:23:26','2021-06-18 21:23:26'),(81,25,'2021-06-22 12:48:58','2021-06-23 12:48:58'),(86,25,'2021-06-19 08:22:59','2021-06-20 08:22:59'),(26,26,'2021-06-17 14:02:48','2021-06-18 14:02:48'),(91,26,'2021-06-21 17:18:16','2021-06-22 17:18:16'),(99,26,'2021-06-23 20:43:33','2021-06-24 20:43:33'),(27,27,'2021-06-17 07:54:40','2021-06-18 07:54:40'),(89,27,'2021-06-23 16:09:04','2021-06-24 16:09:04'),(99,27,'2021-06-22 03:51:51','2021-06-23 03:51:51'),(28,28,'2021-06-18 18:31:18','2021-06-19 18:31:18'),(89,28,'2021-06-19 18:43:30','2021-06-20 18:43:30'),(99,28,'2021-06-20 02:45:11','2021-06-21 02:45:11'),(29,29,'2021-06-18 19:15:33','2021-06-19 19:15:33'),(89,29,'2021-06-19 14:22:15','2021-06-20 14:22:15'),(99,29,'2021-06-19 05:00:47','2021-06-20 05:00:47'),(30,30,'2021-06-17 05:13:56','2021-06-18 05:13:56'),(88,30,'2021-06-23 19:49:54','2021-06-24 19:49:54'),(89,30,'2021-06-21 17:23:07','2021-06-22 17:23:07');

------------------------------------------------------------------------------------------------------------------------

-- Below is the code for the Views creation:

-- Question 8.1: Show views for sales per service category 
CREATE VIEW sales AS
SELECT B.servicedescription, COUNT(A.idservice) as sales_per_service  
FROM service_charge as A, service as B
WHERE A.idservice = B.idservice
GROUP BY B.servicedescription;
SELECT * FROM sales;

-- Question 8.2: Show view for customer details
CREATE VIEW customer_details AS
SELECT * FROM customer;

------------------------------------------------------------------------------------------------------------------------

-- Below is the code for the SQL Queries:

-- Question 7.1: Show services
SELECT *
FROM services;

-- Question 7.2: Show visits
SELECT S.idservice, C.idnfc, SC.chargedatetime, SC.description, SC.cost, C.firstname, C.lastname, S.servicedescription
FROM service_charge AS SC, customer AS C, service AS S
WHERE SC.idnfc = C.idnfc AND SC.idservice = S.idservice AND S.servicedescription IN ("Bar", "Gym") AND SC.cost BETWEEN 0 AND 100 AND SC.chargedatetime BETWEEN '2021-06-16' AND '2021-06-22';

-- Question 8.1: Retrieve view and check if view is updatable
SELECT * FROM sales;

UPDATE sales 
SET sales_per_service = 15
WHERE servicedescription = 'Bar';

-- Question 8.2: Retrieve view and check if view is updatable
SELECT * FROM customer_details;

UPDATE customer_details 
SET firstname = 'Bob'
WHERE idnfc = 1;

-- Question 9: Show places the infected person entered
SELECT  P.idplace, P.placename, P.placedescription, V.entrydatetime, V.exitdatetime
FROM visits AS V, customer AS C, place AS P
WHERE V.idnfc = C.idnfc AND V.idplace = P.idplace AND C.idnfc = 'idnfc';

-- Question 10: Show people at risk 
SELECT C.firstname, C.lastname, C.idnfc, B.idplace, B.entrydatetime, B.exitdatetime
FROM visits A, visits B, customer C
WHERE B.idnfc = C.idnfc AND A.idnfc = 'idnfc' AND A.idnfc <> B.idnfc AND A.idplace = B.idplace AND NOT(B.entrydatetime > DATE_ADD(A.exitdatetime, INTERVAL 1 DAY) OR B.exitdatetime < A.entrydatetime);

-- Question 11.1: Show for 3 age groups the most visited places (3 sample queries)
SELECT P.idplace, P.placename, COUNT(P.idplace) as visit_count
FROM visits as V, place as P, customer as C
WHERE V.idplace = P.idplace AND V.idnfc = C.idnfc AND C.birthday <= DATE_SUB(CURDATE(), INTERVAL 20 YEAR) AND C.birthday > DATE_SUB(CURDATE(), INTERVAL 41 YEAR)  AND V.entrydatetime >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY P.idplace
ORDER BY COUNT(P.idplace) DESC;

SELECT  P.idplace, P.placename, COUNT(P.idplace) as visit_count
FROM visits as V, place as P, customer as C
WHERE V.idplace = P.idplace AND V.idnfc = C.idnfc AND C.birthday <= DATE_SUB(CURDATE(), INTERVAL 41 YEAR) AND C.birthday > DATE_SUB(CURDATE(), INTERVAL 61 YEAR)  AND V.entrydatetime >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY P.idplace
ORDER BY COUNT(P.idplace) DESC;

SELECT  P.idplace, P.placename, COUNT(P.idplace) as visit_count
FROM visits as V, place as P, customer as C
WHERE V.idplace = P.idplace AND V.idnfc = C.idnfc AND C.birthday <= DATE_SUB(CURDATE(), INTERVAL 61 YEAR) AND V.entrydatetime >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY P.idplace
ORDER BY COUNT(P.idplace) DESC;

-- Question 11.2: Show for 3 age groups the most used services (3 sample queries)
SELECT S.servicedescription, COUNT(V.idservice) as count 
FROM service_charge as V, customer as C, service as S
WHERE  V.idnfc = C.idnfc AND V.idservice = S.idservice AND C.birthday <= DATE_SUB(CURDATE(), INTERVAL 20 YEAR) AND C.birthday > DATE_SUB(CURDATE(), INTERVAL 41 YEAR) AND V.chargedatetime >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY S.servicedescription
ORDER BY COUNT(V.idservice) DESC;

SELECT S.servicedescription, COUNT(V.idservice) as count 
FROM service_charge as V, customer as C, service as S
WHERE  V.idnfc = C.idnfc AND V.idservice = S.idservice AND C.birthday <= DATE_SUB(CURDATE(), INTERVAL 41 YEAR) AND C.birthday > DATE_SUB(CURDATE(), INTERVAL 61 YEAR) AND V.chargedatetime >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY S.servicedescription
ORDER BY COUNT(V.idservice) DESC;

SELECT S.servicedescription, COUNT(V.idservice) as count 
FROM service_charge as V, customer as C, service as S
WHERE  V.idnfc = C.idnfc AND V.idservice = S.idservice AND C.birthday <= DATE_SUB(CURDATE(), INTERVAL 61 YEAR) AND V.chargedatetime >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY S.servicedescription
ORDER BY COUNT(V.idservice) DESC;

-- Question 11.3: Show for 3 age groups the services with most users (3 sample queries)
SELECT S.servicedescription, COUNT(DISTINCT C.idnfc) as count
FROM customer as C, service as S, service_charge as R
WHERE R.idservice = S.idservice AND R.idnfc = C.idnfc AND C.birthday <= DATE_SUB(CURDATE(), INTERVAL 20 YEAR) AND C.birthday > DATE_SUB(CURDATE(), INTERVAL 41 YEAR) AND R.chargedatetime >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY S.servicedescription
ORDER BY COUNT(DISTINCT C.idnfc) DESC;

SELECT S.servicedescription, COUNT(DISTINCT C.idnfc) as count
FROM customer as C, service as S, service_charge as R
WHERE R.idservice = S.idservice AND R.idnfc = C.idnfc AND C.birthday <= DATE_SUB(CURDATE(), INTERVAL 41 YEAR) AND C.birthday > DATE_SUB(CURDATE(), INTERVAL 61 YEAR) AND R.chargedatetime >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY S.servicedescription
ORDER BY COUNT(DISTINCT C.idnfc) DESC;

SELECT S.servicedescription, COUNT(DISTINCT C.idnfc) as count
FROM customer as C, service as S, service_charge as R
WHERE R.idservice = S.idservice AND R.idnfc = C.idnfc AND C.birthday <= DATE_SUB(CURDATE(), INTERVAL 61 YEAR) AND R.chargedatetime >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY S.servicedescription
ORDER BY COUNT(DISTINCT C.idnfc) DESC;