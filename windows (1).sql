CREATE DATABASE  IF NOT EXISTS `sonatrach` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `sonatrach`;





DROP TABLE IF EXISTS `action_correctif`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `action_correctif` (
  `id_action` int(11) NOT NULL AUTO_INCREMENT,
  `var_id` varchar(50) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `effect` varchar(255) DEFAULT NULL,
  `cause` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action_correctif`
--

LOCK TABLES `action_correctif` WRITE;
/*!40000 ALTER TABLE `action_correctif` DISABLE KEYS */;
/*!40000 ALTER TABLE `action_correctif` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `action_effectue`
--

DROP TABLE IF EXISTS `action_effectue`;

 SET character_set_client = utf8mb4 ;
CREATE TABLE `action_effectue` (
  `id_admin` varchar(50) NOT NULL,
  `id_action` int(11) NOT NULL,
  `time_date` datetime NOT NULL,
  PRIMARY KEY (`id_admin`,`id_action`,`time_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action_effectue`
--


--
-- Table structure for table `alarme`
--

DROP TABLE IF EXISTS `alarme`;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `alarme` (
  `id_alarme` int(11) NOT NULL AUTO_INCREMENT,
  `var_id` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `seuil_max` int(11) DEFAULT NULL,
  `seuil_min` int(11) DEFAULT NULL,
  `niveau` int(11) DEFAULT NULL,
  `interval_rep` int(11) DEFAULT NULL,
  `etat` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_alarme`),
  UNIQUE KEY `var_niveau` (`var_id`,`niveau`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarme`
--

LOCK TABLES `alarme` WRITE;
/*!40000 ALTER TABLE `alarme` DISABLE KEYS */;
INSERT INTO `alarme` (`id_alarme`, `var_id`, `description`, `seuil_max`, `seuil_min`, `niveau`, `interval_rep`, `etat`) VALUES (1,'gtbp2sz4vygwfr','none',20,0,1,100,1);
/*!40000 ALTER TABLE `alarme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerte`
--

DROP TABLE IF EXISTS `alerte`;

 SET character_set_client = utf8mb4 ;
CREATE TABLE `alerte` (
  `id_alarme` int(11) NOT NULL,
  `date_time` datetime NOT NULL,
  `niveau` int(11) DEFAULT NULL,
  `archive` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_alarme`,`date_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerte`
--

LOCK TABLES `alerte` WRITE;
/*!40000 ALTER TABLE `alerte` DISABLE KEYS */;
INSERT INTO `alerte` (`id_alarme`, `date_time`, `niveau`, `archive`) VALUES (1,'2019-10-08 19:56:12',1,0),(1,'2019-10-08 19:56:28',1,0),(1,'2019-10-08 20:30:21',1,0),(1,'2019-10-08 20:32:13',1,0),(1,'2019-10-08 21:07:10',1,0),(1,'2019-10-08 21:11:19',1,0),(1,'2019-10-08 21:13:11',1,0),(1,'2019-10-08 21:21:27',1,0),(1,'2019-10-08 21:30:47',1,0),(1,'2019-10-08 21:33:43',1,0),(1,'2019-10-08 21:35:20',1,0),(1,'2019-10-08 21:35:35',1,0),(1,'2019-10-08 21:35:51',1,0),(1,'2019-10-08 21:36:08',1,0),(1,'2019-10-08 21:36:23',1,0),(1,'2019-10-08 21:36:39',1,0),(1,'2019-10-08 21:37:59',1,0),(1,'2019-10-08 21:38:16',1,0),(1,'2019-10-08 21:38:33',1,0),(1,'2019-10-08 21:38:52',1,0),(1,'2019-10-09 09:25:46',1,0),(1,'2019-10-09 09:27:22',1,0),(1,'2019-10-09 09:30:34',1,0),(1,'2019-10-09 09:32:42',1,0),(1,'2019-10-09 09:36:58',1,0),(1,'2019-10-09 09:37:14',1,0),(1,'2019-10-09 09:37:30',1,0);
/*!40000 ALTER TABLE `alerte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objet`
--

DROP TABLE IF EXISTS `objet`;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `objet` (
  `obj_id` varchar(50) NOT NULL,
  `obj_pere` varchar(50) DEFAULT NULL,
  `obj_nom_physique` varchar(255) DEFAULT NULL,
  `obj_nom_logique` varchar(255) DEFAULT NULL,
  `obj_type` varchar(50) DEFAULT NULL,
  `obj_adress` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`obj_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Dumping data for table `objet`
--

LOCK TABLES `objet` WRITE;
/*!40000 ALTER TABLE `objet` DISABLE KEYS */;
INSERT INTO `objet` (`obj_id`, `obj_pere`, `obj_nom_physique`, `obj_nom_logique`, `obj_type`, `obj_adress`) VALUES ('1111','aaaa','linux@1','linux@1','os','192.168.1.40'),('2222','bbbb','windows@1','windows@1','os','192.168.1.39'),('3333','2222','mysql@1','mysql@1','database','192.168.1.39:3800'),('aaaa',NULL,'salle1','salle1','salle','data center '),('bbbb',NULL,'salle2','salle2','salle','data center '),('mvwxx83htxexh8','2222','hjjgjhbgjb','kjhkjnk','database','192.168.1.40:3600');
/*!40000 ALTER TABLE `objet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snapshots`
--

DROP TABLE IF EXISTS `snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `snapshots` (
  `var_id` varchar(50) NOT NULL,
  `date_time` datetime NOT NULL,
  `valeur` int(11) DEFAULT NULL,
  PRIMARY KEY (`var_id`,`date_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snapshots`
--

LOCK TABLES `snapshots` WRITE;
/*!40000 ALTER TABLE `snapshots` DISABLE KEYS */;
INSERT INTO `snapshots` (`var_id`, `date_time`, `valeur`) VALUES ('gtbp2sz4vygwfr','2019-10-08 21:19:35',7),('gtbp2sz4vygwfr','2019-10-08 21:19:51',2),('gtbp2sz4vygwfr','2019-10-08 21:20:07',13),('gtbp2sz4vygwfr','2019-10-08 21:20:23',16),('gtbp2sz4vygwfr','2019-10-08 21:20:55',7),('gtbp2sz4vygwfr','2019-10-08 21:21:11',5),('gtbp2sz4vygwfr','2019-10-08 21:21:27',26),('gtbp2sz4vygwfr','2019-10-08 21:21:43',7),('gtbp2sz4vygwfr','2019-10-08 21:21:59',5),('gtbp2sz4vygwfr','2019-10-08 21:22:15',7),('gtbp2sz4vygwfr','2019-10-08 21:22:31',12),('gtbp2sz4vygwfr','2019-10-08 21:22:47',8),('gtbp2sz4vygwfr','2019-10-08 21:23:03',18),('gtbp2sz4vygwfr','2019-10-08 21:23:19',10),('gtbp2sz4vygwfr','2019-10-08 21:23:35',5),('gtbp2sz4vygwfr','2019-10-08 21:23:51',8),('gtbp2sz4vygwfr','2019-10-08 21:24:08',10),('gtbp2sz4vygwfr','2019-10-08 21:24:23',18),('gtbp2sz4vygwfr','2019-10-08 21:24:40',10),('gtbp2sz4vygwfr','2019-10-08 21:24:55',15),('gtbp2sz4vygwfr','2019-10-08 21:25:12',7),('gtbp2sz4vygwfr','2019-10-08 21:25:30',19),('gtbp2sz4vygwfr','2019-10-08 21:25:46',19),('gtbp2sz4vygwfr','2019-10-08 21:26:00',15),('gtbp2sz4vygwfr','2019-10-08 21:26:19',5),('gtbp2sz4vygwfr','2019-10-08 21:26:31',4),('gtbp2sz4vygwfr','2019-10-08 21:26:47',8),('gtbp2sz4vygwfr','2019-10-08 21:27:03',19),('gtbp2sz4vygwfr','2019-10-08 21:27:19',8),('gtbp2sz4vygwfr','2019-10-08 21:27:35',10),('gtbp2sz4vygwfr','2019-10-08 21:27:51',19),('gtbp2sz4vygwfr','2019-10-08 21:28:14',13),('gtbp2sz4vygwfr','2019-10-08 21:28:23',10),('gtbp2sz4vygwfr','2019-10-08 21:28:39',4),('gtbp2sz4vygwfr','2019-10-08 21:28:55',4),('gtbp2sz4vygwfr','2019-10-08 21:29:11',1),('gtbp2sz4vygwfr','2019-10-08 21:29:27',5),('gtbp2sz4vygwfr','2019-10-08 21:29:43',8),('gtbp2sz4vygwfr','2019-10-08 21:29:59',8),('gtbp2sz4vygwfr','2019-10-08 21:30:15',5),('gtbp2sz4vygwfr','2019-10-08 21:30:31',10),('gtbp2sz4vygwfr','2019-10-08 21:30:47',22),('gtbp2sz4vygwfr','2019-10-08 21:31:03',10),('gtbp2sz4vygwfr','2019-10-08 21:31:19',5),('gtbp2sz4vygwfr','2019-10-08 21:31:35',15),('gtbp2sz4vygwfr','2019-10-08 21:31:51',16),('gtbp2sz4vygwfr','2019-10-08 21:32:07',2),('gtbp2sz4vygwfr','2019-10-08 21:32:23',5),('gtbp2sz4vygwfr','2019-10-08 21:32:39',7),('gtbp2sz4vygwfr','2019-10-08 21:32:55',2),('gtbp2sz4vygwfr','2019-10-08 21:33:11',19),('gtbp2sz4vygwfr','2019-10-08 21:33:27',7),('gtbp2sz4vygwfr','2019-10-08 21:33:43',35),('gtbp2sz4vygwfr','2019-10-08 21:33:59',15),('gtbp2sz4vygwfr','2019-10-08 21:34:15',8),('gtbp2sz4vygwfr','2019-10-08 21:34:31',5),('gtbp2sz4vygwfr','2019-10-08 21:34:47',2),('gtbp2sz4vygwfr','2019-10-08 21:35:03',5),('gtbp2sz4vygwfr','2019-10-08 21:35:20',24),('gtbp2sz4vygwfr','2019-10-08 21:35:35',21),('gtbp2sz4vygwfr','2019-10-08 21:35:51',31),('gtbp2sz4vygwfr','2019-10-08 21:36:08',38),('gtbp2sz4vygwfr','2019-10-08 21:36:23',54),('gtbp2sz4vygwfr','2019-10-08 21:36:39',32),('gtbp2sz4vygwfr','2019-10-08 21:36:55',15),('gtbp2sz4vygwfr','2019-10-08 21:37:11',18),('gtbp2sz4vygwfr','2019-10-08 21:37:27',16),('gtbp2sz4vygwfr','2019-10-08 21:37:44',15),('gtbp2sz4vygwfr','2019-10-08 21:37:59',27),('gtbp2sz4vygwfr','2019-10-08 21:38:16',21),('gtbp2sz4vygwfr','2019-10-08 21:38:33',27),('gtbp2sz4vygwfr','2019-10-08 21:38:52',33),('gtbp2sz4vygwfr','2019-10-09 09:16:58',6),('gtbp2sz4vygwfr','2019-10-09 09:17:14',2),('gtbp2sz4vygwfr','2019-10-09 09:17:30',7),('gtbp2sz4vygwfr','2019-10-09 09:17:46',1),('gtbp2sz4vygwfr','2019-10-09 09:18:01',16),('gtbp2sz4vygwfr','2019-10-09 09:18:18',4),('gtbp2sz4vygwfr','2019-10-09 09:18:33',19),('gtbp2sz4vygwfr','2019-10-09 09:18:49',2),('gtbp2sz4vygwfr','2019-10-09 09:19:05',8),('gtbp2sz4vygwfr','2019-10-09 09:19:22',2),('gtbp2sz4vygwfr','2019-10-09 09:19:38',16),('gtbp2sz4vygwfr','2019-10-09 09:19:54',8),('gtbp2sz4vygwfr','2019-10-09 09:20:09',4),('gtbp2sz4vygwfr','2019-10-09 09:20:25',4),('gtbp2sz4vygwfr','2019-10-09 09:20:41',2),('gtbp2sz4vygwfr','2019-10-09 09:20:57',7),('gtbp2sz4vygwfr','2019-10-09 09:21:13',4),('gtbp2sz4vygwfr','2019-10-09 09:21:30',5),('gtbp2sz4vygwfr','2019-10-09 09:21:45',4),('gtbp2sz4vygwfr','2019-10-09 09:22:01',5),('gtbp2sz4vygwfr','2019-10-09 09:22:17',1),('gtbp2sz4vygwfr','2019-10-09 09:22:34',15),('gtbp2sz4vygwfr','2019-10-09 09:22:49',5),('gtbp2sz4vygwfr','2019-10-09 09:23:05',1),('gtbp2sz4vygwfr','2019-10-09 09:23:22',2),('gtbp2sz4vygwfr','2019-10-09 09:23:37',4),('gtbp2sz4vygwfr','2019-10-09 09:23:54',2),('gtbp2sz4vygwfr','2019-10-09 09:24:10',8),('gtbp2sz4vygwfr','2019-10-09 09:24:25',2),('gtbp2sz4vygwfr','2019-10-09 09:24:42',8),('gtbp2sz4vygwfr','2019-10-09 09:24:58',15),('gtbp2sz4vygwfr','2019-10-09 09:25:14',13),('gtbp2sz4vygwfr','2019-10-09 09:25:30',5),('gtbp2sz4vygwfr','2019-10-09 09:25:46',37),('gtbp2sz4vygwfr','2019-10-09 09:26:02',8),('gtbp2sz4vygwfr','2019-10-09 09:26:18',10),('gtbp2sz4vygwfr','2019-10-09 09:26:34',15),('gtbp2sz4vygwfr','2019-10-09 09:26:50',13),('gtbp2sz4vygwfr','2019-10-09 09:27:06',10),('gtbp2sz4vygwfr','2019-10-09 09:27:22',35),('gtbp2sz4vygwfr','2019-10-09 09:27:38',12),('gtbp2sz4vygwfr','2019-10-09 09:27:54',10),('gtbp2sz4vygwfr','2019-10-09 09:28:10',10),('gtbp2sz4vygwfr','2019-10-09 09:28:26',16),('gtbp2sz4vygwfr','2019-10-09 09:28:42',8),('gtbp2sz4vygwfr','2019-10-09 09:28:58',5),('gtbp2sz4vygwfr','2019-10-09 09:29:14',10),('gtbp2sz4vygwfr','2019-10-09 09:29:30',10),('gtbp2sz4vygwfr','2019-10-09 09:29:46',7),('gtbp2sz4vygwfr','2019-10-09 09:30:02',8),('gtbp2sz4vygwfr','2019-10-09 09:30:18',13),('gtbp2sz4vygwfr','2019-10-09 09:30:34',38),('gtbp2sz4vygwfr','2019-10-09 09:30:50',11),('gtbp2sz4vygwfr','2019-10-09 09:31:06',7),('gtbp2sz4vygwfr','2019-10-09 09:31:22',8),('gtbp2sz4vygwfr','2019-10-09 09:31:38',18),('gtbp2sz4vygwfr','2019-10-09 09:31:54',10),('gtbp2sz4vygwfr','2019-10-09 09:32:10',5),('gtbp2sz4vygwfr','2019-10-09 09:32:26',19),('gtbp2sz4vygwfr','2019-10-09 09:32:42',22),('gtbp2sz4vygwfr','2019-10-09 09:32:58',15),('gtbp2sz4vygwfr','2019-10-09 09:33:14',5),('gtbp2sz4vygwfr','2019-10-09 09:33:30',2),('gtbp2sz4vygwfr','2019-10-09 09:33:46',2),('gtbp2sz4vygwfr','2019-10-09 09:34:02',1),('gtbp2sz4vygwfr','2019-10-09 09:34:18',5),('gtbp2sz4vygwfr','2019-10-09 09:34:34',2),('gtbp2sz4vygwfr','2019-10-09 09:34:50',5),('gtbp2sz4vygwfr','2019-10-09 09:35:06',2),('gtbp2sz4vygwfr','2019-10-09 09:35:22',4),('gtbp2sz4vygwfr','2019-10-09 09:35:38',4),('gtbp2sz4vygwfr','2019-10-09 09:35:54',4),('gtbp2sz4vygwfr','2019-10-09 09:36:10',1),('gtbp2sz4vygwfr','2019-10-09 09:36:26',5),('gtbp2sz4vygwfr','2019-10-09 09:36:42',2),('gtbp2sz4vygwfr','2019-10-09 09:36:58',32),('gtbp2sz4vygwfr','2019-10-09 09:37:14',29),('gtbp2sz4vygwfr','2019-10-09 09:37:30',21),('gtbp2sz4vygwfr','2019-10-09 09:37:46',15),('gtbp2sz4vygwfr','2019-10-09 09:38:02',4),('gtbp2sz4vygwfr','2019-10-09 09:38:18',1),('gtbp2sz4vygwfr','2019-10-09 09:38:34',1),('gtbp2sz4vygwfr','2019-10-09 09:38:50',8),('gtbp2sz4vygwfr','2019-10-09 09:39:06',15),('gtbp2sz4vygwfr','2019-10-09 09:39:22',13),('gtbp2sz4vygwfr','2019-10-09 09:39:38',8),('gtbp2sz4vygwfr','2019-10-09 09:39:54',5);
/*!40000 ALTER TABLE `snapshots` ENABLE KEYS */;
UNLOCK TABLES;

DELIMITER ;;

 CREATE  TRIGGER `alerte_ins` AFTER INSERT ON `snapshots` FOR EACH ROW insert into alerte(id_alarme,date_time,niveau) 
    ( select id_alarme,now(),niveau from alarme where (( var_id=new.var_id ) and ( (new.valeur>seuil_max)or(new.valeur<seuil_min ) ) ) 
    order by niveau desc limit 1 ) ;;
DELIMITER ;

--
-- Table structure for table `surveiller`
--

DROP TABLE IF EXISTS `surveiller`;

 SET character_set_client = utf8mb4 ;
CREATE TABLE `surveiller` (
  `user_id` varchar(50) NOT NULL,
  `var_id` varchar(50) NOT NULL,
  `debut_suerveillance` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`,`var_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Dumping data for table `surveiller`
--

LOCK TABLES `surveiller` WRITE;
/*!40000 ALTER TABLE `surveiller` DISABLE KEYS */;
/*!40000 ALTER TABLE `surveiller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_objet`
--

DROP TABLE IF EXISTS `type_objet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `type_objet` (
  `obj_type` varchar(50) NOT NULL,
  PRIMARY KEY (`obj_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_objet`
--

LOCK TABLES `type_objet` WRITE;
/*!40000 ALTER TABLE `type_objet` DISABLE KEYS */;
INSERT INTO `type_objet` (`obj_type`) VALUES ('database'),('os'),('salle');
/*!40000 ALTER TABLE `type_objet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_utilisateur`
--

DROP TABLE IF EXISTS `type_utilisateur`;

 SET character_set_client = utf8mb4 ;
CREATE TABLE `type_utilisateur` (
  `user_type` varchar(50) NOT NULL,
  PRIMARY KEY (`user_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_utilisateur`
--

LOCK TABLES `type_utilisateur` WRITE;
/*!40000 ALTER TABLE `type_utilisateur` DISABLE KEYS */;
INSERT INTO `type_utilisateur` (`user_type`) VALUES ('admin'),('user');
/*!40000 ALTER TABLE `type_utilisateur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `utilisateur` (
  `user_id` varchar(50) NOT NULL,
  `user_nom` varchar(255) DEFAULT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `user_pwd` varchar(255) DEFAULT NULL,
  `user_prenom` varchar(255) DEFAULT NULL,
  `user_poste` varchar(255) DEFAULT NULL,
  `user_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilisateur`
--

LOCK TABLES `utilisateur` WRITE;
/*!40000 ALTER TABLE `utilisateur` DISABLE KEYS */;
INSERT INTO `utilisateur` (`user_id`, `user_nom`, `user_email`, `user_pwd`, `user_prenom`, `user_poste`, `user_type`) VALUES ('23pg1yvqspwuvq','admin','admin','58acb7acccce58ffa8b953b12b5a7702bd42dae441c1ad85057fa70b','admin','admin','admin');
/*!40000 ALTER TABLE `utilisateur` ENABLE KEYS */;
UNLOCK TABLES;



DROP TABLE IF EXISTS `variable`;

 SET character_set_client = utf8mb4 ;
CREATE TABLE `variable` (
  `var_id` varchar(50) NOT NULL,
  `obj_id` varchar(50) DEFAULT NULL,
  `var_nom` varchar(255) NOT NULL,
  `var_description` varchar(255) DEFAULT NULL,
  `var_priorite` int(11) DEFAULT NULL,
  `var_params` varchar(255) DEFAULT NULL,
  `var_line` int(11) NOT NULL DEFAULT '0',
  `var_splitter` varchar(50) DEFAULT NULL,
  `var_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`var_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Dumping data for table `variable`
--

LOCK TABLES `variable` WRITE;
/*!40000 ALTER TABLE `variable` DISABLE KEYS */;
INSERT INTO `variable` (`var_id`, `obj_id`, `var_nom`, `var_description`, `var_priorite`, `var_params`, `var_line`, `var_splitter`, `var_order`) VALUES ('gtbp2sz4vygwfr','2222','cpu_usage','moyenne use cpu during 1-2s',4,NULL,3,NULL,0);
/*!40000 ALTER TABLE `variable` ENABLE KEYS */;
UNLOCK TABLES;

