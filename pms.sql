-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: hospital_db
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `appointment_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `doctor_id` int NOT NULL,
  `appointment_datetime` datetime NOT NULL,
  `duration_minutes` int DEFAULT '30',
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Scheduled','Completed','No-Show','Cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'Scheduled',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`appointment_id`),
  KEY `patient_id` (`patient_id`),
  KEY `idx_appointments_doctor` (`doctor_id`,`appointment_datetime`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`) ON DELETE CASCADE,
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (1,1,1,'2025-11-01 10:00:00',30,'Follow-up','Scheduled','2025-10-26 11:59:32'),(2,2,2,'2025-11-02 11:00:00',45,'Orthopedic consult','Scheduled','2025-10-26 11:59:32'),(3,3,3,'2025-10-26 09:30:00',20,'Vaccination','Scheduled','2025-10-26 11:59:32');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill_items`
--

DROP TABLE IF EXISTS `bill_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int DEFAULT NULL,
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `service_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `bill_id` (`bill_id`),
  CONSTRAINT `bill_items_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`bill_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_items`
--

LOCK TABLES `bill_items` WRITE;
/*!40000 ALTER TABLE `bill_items` DISABLE KEYS */;
INSERT INTO `bill_items` VALUES (1,1,'Room charges - 2 days',8000.00,'ROOM_2D'),(2,1,'Lab test fees',4000.00,'LAB_001'),(3,1,'Medication',2000.00,'MED_001');
/*!40000 ALTER TABLE `bill_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bills` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `visit_id` int DEFAULT NULL,
  `bill_date` date DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`bill_id`),
  KEY `visit_id` (`visit_id`),
  CONSTRAINT `bills_ibfk_1` FOREIGN KEY (`visit_id`) REFERENCES `visits` (`visit_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
INSERT INTO `bills` VALUES (1,1,'2025-10-24',14000.00),(2,2,'2025-10-24',10000.00),(3,1,'2025-10-22',7500.00),(4,2,'2025-10-23',5600.00),(5,3,'2025-10-25',1200.00),(6,4,'2025-10-27',8900.00),(7,5,'2025-10-28',4500.00);
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'General Medicine','Block A','011-1001'),(2,'Orthopedics','Block B','011-1002'),(3,'Pediatrics','Block C','011-1003'),(4,'Radiology','Imaging Center','011-1004'),(5,'Pathology','Lab Building','011-1005'),(6,'Gynecology','Block D','011-1006'),(7,'ENT','Block E','011-1007'),(8,'Oncology','Block F','011-1008'),(9,'Urology','Block G','011-1009'),(10,'Ophthalmology','Block H','011-1010');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `doctor_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `specialization` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,'Rohan','Sharma','Cardiology'),(2,'Meena','Patel','Pediatrics'),(3,'Meena','Khurana','Cardiologist'),(4,'Rajesh','Singh','Neurologist'),(5,'Pooja','Bansal','General Physician'),(6,'Arjun','Reddy','Orthopedic'),(7,'Simran','Kapoor','Dermatologist'),(8,'Anjali','Mehra','Gynecologist'),(9,'Vikram','Sethi','ENT Specialist'),(10,'Kavita','Rao','Oncologist'),(11,'Suresh','Menon','Urologist'),(12,'Tina','Paul','Ophthalmologist');
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab_orders`
--

DROP TABLE IF EXISTS `lab_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_orders` (
  `lab_order_id` int NOT NULL AUTO_INCREMENT,
  `visit_id` int DEFAULT NULL,
  `lab_test_id` int DEFAULT NULL,
  `order_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`lab_order_id`),
  KEY `visit_id` (`visit_id`),
  KEY `lab_test_id` (`lab_test_id`),
  CONSTRAINT `lab_orders_ibfk_1` FOREIGN KEY (`visit_id`) REFERENCES `visits` (`visit_id`) ON DELETE CASCADE,
  CONSTRAINT `lab_orders_ibfk_2` FOREIGN KEY (`lab_test_id`) REFERENCES `lab_tests` (`lab_test_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab_orders`
--

LOCK TABLES `lab_orders` WRITE;
/*!40000 ALTER TABLE `lab_orders` DISABLE KEYS */;
INSERT INTO `lab_orders` VALUES (1,1,1,'2025-10-23 11:00:00'),(2,1,1,'2025-10-20 12:00:00'),(3,2,2,'2025-10-21 13:30:00'),(4,3,3,'2025-10-25 10:00:00'),(5,4,4,'2025-10-26 11:00:00'),(6,5,5,'2025-10-27 15:00:00');
/*!40000 ALTER TABLE `lab_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab_results`
--

DROP TABLE IF EXISTS `lab_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_results` (
  `lab_result_id` int NOT NULL AUTO_INCREMENT,
  `lab_order_id` int DEFAULT NULL,
  `result_value` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `result_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`lab_result_id`),
  KEY `lab_order_id` (`lab_order_id`),
  CONSTRAINT `lab_results_ibfk_1` FOREIGN KEY (`lab_order_id`) REFERENCES `lab_orders` (`lab_order_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab_results`
--

LOCK TABLES `lab_results` WRITE;
/*!40000 ALTER TABLE `lab_results` DISABLE KEYS */;
INSERT INTO `lab_results` VALUES (1,1,'Normal','2025-10-23 15:00:00'),(2,1,'Normal ECG','2025-10-21 09:00:00'),(3,2,'Minor abnormality detected','2025-10-22 10:00:00'),(4,3,'110 mg/dL','2025-10-25 12:00:00'),(5,4,'Fracture detected','2025-10-27 14:00:00'),(6,5,'High Cholesterol','2025-10-28 09:00:00');
/*!40000 ALTER TABLE `lab_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab_tests`
--

DROP TABLE IF EXISTS `lab_tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_tests` (
  `lab_test_id` int NOT NULL AUTO_INCREMENT,
  `test_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`lab_test_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab_tests`
--

LOCK TABLES `lab_tests` WRITE;
/*!40000 ALTER TABLE `lab_tests` DISABLE KEYS */;
INSERT INTO `lab_tests` VALUES (1,'Blood Test',500.00),(2,'X-Ray',1000.00),(3,'ECG',1500.00),(4,'MRI Brain',4000.00),(5,'Blood Sugar',500.00),(6,'X-Ray',1200.00),(7,'Lipid Profile',1000.00);
/*!40000 ALTER TABLE `lab_tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medications`
--

DROP TABLE IF EXISTS `medications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medications` (
  `medication_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dosage` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`medication_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medications`
--

LOCK TABLES `medications` WRITE;
/*!40000 ALTER TABLE `medications` DISABLE KEYS */;
INSERT INTO `medications` VALUES (1,'Paracetamol','500mg'),(2,'Amoxicillin','250mg');
/*!40000 ALTER TABLE `medications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurses`
--

DROP TABLE IF EXISTS `nurses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nurses` (
  `nurse_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`nurse_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `nurses_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurses`
--

LOCK TABLES `nurses` WRITE;
/*!40000 ALTER TABLE `nurses` DISABLE KEYS */;
INSERT INTO `nurses` VALUES (1,'Sita','Khan','900001','sita.khan@hospital.com',1),(2,'Rahul','Singh','900002','rahul.singh@hospital.com',2),(3,'Rekha','Das','900003','rekha.das@hospital.com',3),(4,'Ankit','Sharma','900004','ankit.sharma@hospital.com',4),(5,'Lata','Ghosh','900005','lata.ghosh@hospital.com',5);
/*!40000 ALTER TABLE `nurses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `patient_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,'Kanika','Aggarwal','1997-05-12','Female','999900001','kanika@example.com','123, MG Road','2025-10-26 17:33:44'),(2,'Amit','Kumar','1985-09-01','Male','999900002','amit@example.com','45, Park Street','2025-10-26 17:33:44'),(3,'Riya','Sharma','1995-04-14','Female','9876543210','riya@example.com','Delhi','2025-10-29 22:03:37'),(4,'Aarav','Patel','1990-09-20','Male','9898989898','aarav@example.com','Ahmedabad','2025-10-29 22:03:37'),(5,'Neha','Verma','1988-12-05','Female','9123456780','neha@example.com','Mumbai','2025-10-29 22:03:37'),(6,'Vikram','Mehta','1982-01-15','Male','9812345678','vikram@example.com','Pune','2025-10-29 22:03:37'),(7,'Kiran','Bansal','2000-07-21','Female','9990001112','kiran@example.com','Chandigarh','2025-10-29 22:03:37'),(11,'Aarav','Gupta','1992-04-15','Male','9876543211','aarav.g@hospital.com','Delhi','2025-11-07 09:54:57'),(12,'Nisha','Verma','1985-10-10','Female','9876543212','nisha.v@hospital.com','Mumbai','2025-11-07 09:54:57'),(13,'Karan','Joshi','2000-12-02','Male','9876543213','karan.j@hospital.com','Pune','2025-11-07 09:54:57'),(14,'Sneha','Chopra','1998-07-07','Female','9876543214','sneha.c@hospital.com','Kolkata','2025-11-07 09:54:57'),(15,'Ravi','Bhatia','1975-09-09','Male','9876543215','ravi.b@hospital.com','Jaipur','2025-11-07 09:54:57');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int DEFAULT NULL,
  `payment_datetime` datetime DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `method` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `bill_id` (`bill_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`bill_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,'2025-10-24 18:00:00',14000.00,'Card','TXN0001');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescriptions`
--

DROP TABLE IF EXISTS `prescriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescriptions` (
  `prescription_id` int NOT NULL AUTO_INCREMENT,
  `visit_id` int DEFAULT NULL,
  `medication_id` int DEFAULT NULL,
  `dosage_instructions` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`prescription_id`),
  KEY `visit_id` (`visit_id`),
  KEY `medication_id` (`medication_id`),
  CONSTRAINT `prescriptions_ibfk_1` FOREIGN KEY (`visit_id`) REFERENCES `visits` (`visit_id`) ON DELETE CASCADE,
  CONSTRAINT `prescriptions_ibfk_2` FOREIGN KEY (`medication_id`) REFERENCES `medications` (`medication_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescriptions`
--

LOCK TABLES `prescriptions` WRITE;
/*!40000 ALTER TABLE `prescriptions` DISABLE KEYS */;
INSERT INTO `prescriptions` VALUES (1,1,1,'1 tablet twice daily'),(2,1,1,'1 tablet twice daily after meals'),(3,2,2,'1 capsule every 8 hours'),(4,3,1,'Take after breakfast'),(5,4,2,'Take before sleep'),(6,5,1,'2 tablets after lunch');
/*!40000 ALTER TABLE `prescriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `room_id` int NOT NULL AUTO_INCREMENT,
  `room_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ward` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `capacity` int DEFAULT '1',
  `notes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`room_id`),
  UNIQUE KEY `room_number` (`room_number`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,'101','Ward A',2,'General ward bed'),(2,'102','Ward A',1,'Private room'),(3,'201','ICU',1,'ICU bed'),(4,'103','Ward B',2,'Semi-private room'),(5,'202','ICU',1,'Ventilator available'),(6,'301','Maternity',3,'Gynecology section');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `staff_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'Priya','Nurse','Nurse'),(2,'Amit','Singh','Surgeon'),(3,'Karan','Verma','Receptionist'),(4,'Deepa','Nair','Pharmacist'),(5,'Ravi','Shukla','Lab Technician');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_assignments`
--

DROP TABLE IF EXISTS `staff_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_assignments` (
  `assignment_id` int NOT NULL AUTO_INCREMENT,
  `visit_id` int DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `role` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`assignment_id`),
  KEY `visit_id` (`visit_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `staff_assignments_ibfk_1` FOREIGN KEY (`visit_id`) REFERENCES `visits` (`visit_id`) ON DELETE CASCADE,
  CONSTRAINT `staff_assignments_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_assignments`
--

LOCK TABLES `staff_assignments` WRITE;
/*!40000 ALTER TABLE `staff_assignments` DISABLE KEYS */;
INSERT INTO `staff_assignments` VALUES (1,1,1,'Primary Nurse'),(2,1,2,'Surgeon');
/*!40000 ALTER TABLE `staff_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visits`
--

DROP TABLE IF EXISTS `visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visits` (
  `visit_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int DEFAULT NULL,
  `attending_doctor_id` int DEFAULT NULL,
  `admit_datetime` datetime DEFAULT NULL,
  `discharge_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`visit_id`),
  KEY `patient_id` (`patient_id`),
  KEY `attending_doctor_id` (`attending_doctor_id`),
  CONSTRAINT `visits_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`) ON DELETE CASCADE,
  CONSTRAINT `visits_ibfk_2` FOREIGN KEY (`attending_doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visits`
--

LOCK TABLES `visits` WRITE;
/*!40000 ALTER TABLE `visits` DISABLE KEYS */;
INSERT INTO `visits` VALUES (1,1,1,'2025-10-22 10:00:00','2025-10-24 16:00:00'),(2,2,2,'2025-10-23 09:00:00','2025-10-24 11:00:00'),(3,1,1,'2025-10-20 10:00:00','2025-10-22 14:00:00'),(4,2,2,'2025-10-21 11:30:00','2025-10-23 09:00:00'),(5,3,3,'2025-10-25 09:00:00','2025-10-25 17:00:00'),(6,4,4,'2025-10-26 08:30:00','2025-10-27 16:00:00'),(7,5,5,'2025-10-27 10:15:00','2025-10-28 13:00:00');
/*!40000 ALTER TABLE `visits` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-07 15:30:41
