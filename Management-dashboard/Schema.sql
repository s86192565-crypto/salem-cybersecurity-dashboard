DROP DATABASE IF EXISTS Salem_Cybersecurity_Company;
CREATE DATABASE Salem_Cybersecurity_Company;
USE Salem_Cybersecurity_Company;


DROP TABLE IF EXISTS Management;
CREATE TABLE Management (
    MGT_id INT PRIMARY KEY,
    MGT_Name VARCHAR(100) NOT NULL
);
DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
    Dep_ID INT PRIMARY KEY,
    Dep_Name VARCHAR(100) NOT NULL,
    MGT_ID INT NOT NULL,
    FOREIGN KEY (MGT_ID) REFERENCES Management(MGT_id)
);

DROP TABLE IF EXISTS Team_and_difficultys;
CREATE TABLE Team_and_difficultys (
     Team_ID INT PRIMARY KEY,
     Team_Name VARCHAR(100) NOT NULL,
     Difficulty_Critical INT ,
     Difficulty_High INT ,
     Difficulty_Medium INT ,
     Difficulty_Low INT ,
     last_updated DATE NOT NULL,
     Dep_ID INT NOT NULL,
     FOREIGN KEY (Dep_ID) REFERENCES Department(Dep_ID)
);

DROP TABLE IF EXISTS Clients;
CREATE TABLE Clients (
    commercial_register_id BIGINT PRIMARY KEY,
    Company_Name VARCHAR(100) NOT NULL,
    Industry VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    Emp_ID INT PRIMARY KEY,
    Emp_name VARCHAR(100) NOT NULL,
    Specialty VARCHAR(50) NOT NULL,
    Dep_ID INT NOT NULL,
    Team_ID INT NULL, 
    FOREIGN KEY (Dep_ID) REFERENCES Department(Dep_ID),
    FOREIGN KEY (Team_ID) REFERENCES Team_and_difficultys(Team_ID)
);

DROP TABLE IF EXISTS Payroll;
CREATE TABLE Payroll (
    Payroll_ID INT PRIMARY KEY AUTO_INCREMENT,
    Emp_ID INT NOT NULL,
    Basic_Salary DECIMAL(10,2) NOT NULL,
    Allowances DECIMAL(10,2) NOT NULL,
    Date_ DATE NOT NULL,
    
    FOREIGN KEY (Emp_ID) REFERENCES Employees(Emp_ID)
);

DROP TABLE IF EXISTS Contracts;
CREATE TABLE Contracts (
    Contract_ID INT PRIMARY KEY,
    commercial_register_id BIGINT NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE,
    Legal_Terms TEXT,
    CONSTRAINT chk_dates CHECK (End_Date >= Start_Date), 
    FOREIGN KEY (commercial_register_id) REFERENCES Clients(commercial_register_id)
);
DROP TABLE IF EXISTS Vulnerabilities;
CREATE TABLE Vulnerabilities (
    Vuln_ID INT PRIMARY KEY,
    Vuln_Name VARCHAR(100) NOT NULL,
    Severity ENUM('Low', 'Medium', 'High', 'Critical') NOT NULL, 
    Discovery_Date DATE NOT NULL,
    commercial_register_id BIGINT NOT NULL,
    FOREIGN KEY (commercial_register_id) REFERENCES Clients(commercial_register_id)
);

DROP TABLE IF EXISTS Remediation;
CREATE TABLE Remediation (
    Fix_ID INT PRIMARY KEY,
    Vuln_ID INT NOT NULL,
    Team_ID INT NOT NULL,
    Fix_Date DATE NOT NULL,
    Fix_Method VARCHAR(255) NOT NULL,
    FOREIGN KEY (Vuln_ID) REFERENCES Vulnerabilities(Vuln_ID), 
    FOREIGN KEY (Team_ID) REFERENCES Team_and_difficultys(Team_ID)
);

INSERT INTO Management VALUES
(1123254434, 'hatem ayed alqarni'),
(1143215432, 'ali abdulraahman alghamdi'),
(1134219864, 'hatan sultan alghamdi'),
(1141879473, 'ahmed hamad alaseri'),
(1129876543, 'hamed amad alzahrani');


INSERT INTO Department VALUES
(3680, 'Network Security', 1123254434),
(3778, 'LAW Department', 1143215432),
(3754, 'Application Security', 1134219864),
(3789, 'Data Security', 1141879473),
(3949, 'Accounting Department', 1129876543);


INSERT INTO Team_and_difficultys VALUES 
(2684, 'Team khaled' ,0,0,0,0,'2020-01-01', 3680), 
(2342, 'Team salman',0,0,0,0,  '2020-01-01', 3754),
(2678, 'Team fahed',0,0,0,0,  '2020-01-01', 3789);


INSERT INTO Clients VALUES 
(4543219875, 'apple', 'Network Security'),
(4398542186, 'samsung', 'Application Security'),
(4543217654, 'google', 'Data Security'),
(4365432174, 'huawei', 'Network Security'),
(4321765432, 'microsoft', 'Application Security'),
(4432165439, 'tecno', 'Data Security'),
(4321543287, 'dell', 'Network Security'),
(4654321986, 'honor', 'Application Security'),
(4654321987, 'Amazon', 'Data Security');

INSERT INTO Employees VALUES 
(1123254434, 'hatem ayed alqarni', 'Network Security', 3680,NULL),
(1143215432, 'ali abdulraahman alghamdi', 'LAW Department', 3778, NULL),
(1134219864, 'hatan sultan alghamdi', 'Application Security', 3754, NULL),
(1141879473, 'ahmed hamad alaseri', 'Data Security', 3789, NULL),
(1129876543, 'hamed amad alzahrani', 'Accounting Department', 3949, NULL),
(1190807065, 'khaled muhammed alotaibi', 'Network Security', 3680, 2684),
(1154807066, 'salman adam alghamdi', 'Application Security', 3754, 2342),
(1164877067, 'fahed yazan alghamdi', 'Data Security', 3789, 2678),
(1147892034, 'abdulaziz mohammed alzahrani', 'Accounting Department', 3949, NULL),
(1123454349, 'saif khalid almutairi', 'LAW Department',3778, NULL),
(1123456789, 'nasser mohammed alqarni', 'Network Security',3680, 2684),
(1134354321, 'ahmed ali alqarni', 'Data Security', 3789, 2678),
(1134567890, 'hassan mohammed alghamdi', 'Application Security', 3754, 2342),
(1134567865, 'abdullah mohammed alzahrani', 'Accounting Department', 3949, NULL),
(1132546788, 'maher khalid alotaibi', 'LAW Department',3778, NULL);

INSERT INTO Payroll VALUES 
(4535, 1123254434, 200000.00, 5000.00, '2026-02-01'),
(4554, 1143215432, 210000.00, 7000.00, '2026-02-01'),
(4345, 1134219864, 230000.00, 3000.00, '2026-02-01'),
(4123, 1141879473, 213000.00, 9000.00, '2026-02-01'),
(4542, 1129876543, 234000.00, 7000.00, '2026-02-01'),
(4534, 1190807065, 50000.00, 5000.00, '2026-01-01'),
(4431, 1154807066, 60000.00, 6000.00, '2026-01-01'),
(4346, 1164877067, 70000.00, 7000.00, '2026-01-01'),
(4737, 1147892034, 80000.00, 8000.00, '2026-01-01'),
(4548, 1123454349, 90000.00, 9000.00, '2026-01-01'),
(4459, 1123456789, 55000.00, 5500.00, '2026-01-01'),
(4940, 1134354321, 65000.00, 6500.00, '2026-01-01'),
(4351, 1134567890, 75000.00, 7500.00, '2026-01-01'),
(4452, 1134567865, 85000.00, 8500.00, '2026-01-01'),
(4543, 1132546788, 90000.00, 9500.00, '2026-01-01'),
(4532, 1190807065, 50000.00, 6700.00, '2026-02-01'),
(4321, 1154807066, 60000.00, 6800.00, '2026-02-01'),
(4326, 1164877067, 70000.00, 8000.00, '2026-02-01'),
(4327, 1147892034, 80000.00, 9000.00, '2026-02-01'),
(4328, 1123454349, 90000.00, 10000.00, '2026-02-01'),
(4329, 1123456789, 55000.00, 7500.00, '2026-02-01'),
(4330, 1134354321, 65000.00, 6900.00, '2026-02-01'),
(4331, 1134567890, 75000.00, 9400.00, '2026-02-01'),
(4332, 1134567865, 85000.00, 8900.00, '2026-02-01'),
(4333, 1132546788, 90000.00, 10000.00, '2026-02-01');

INSERT INTO Contracts VALUES 
(9321,4543219875, '2021-01-01', '2021-03-01', 'Standard Contract Terms'), 
(9654,4398542186, '2022-04-12', '2022-06-13', 'Standard Contract Terms'),
(9674,4321543287, '2022-07-13', '2022-09-14', 'Standard Contract Terms'),
(9876,4543217654, '2023-09-08', '2023-11-04', 'Standard Contract Terms'),
(9432,4365432174, '2023-12-04', '2024-02-05', 'Standard Contract Terms'),
(9987,4321765432, '2024-04-07', '2024-06-03', 'Standard Contract Terms'),
(9357,4654321986, '2024-06-05', '2024-08-08', 'Standard Contract Terms'),
(9443,4432165439, '2025-01-03', '2025-03-06', 'Standard Contract Terms'),
(9943,4654321987, '2026-01-09', '2026-03-07', 'Standard Contract Terms');

INSERT INTO Vulnerabilities VALUES 
(5643,'ARP Spoofing/Poisoning' , 'Medium', '2021-01-01', 4543219875),
(5436, 'Input Validation', 'Medium', '2022-04-12', 4398542186),
(5432, 'MITM (Man-in-the-Middle)', 'High', '2022-07-13', 4321543287),
(5663, 'SQL Injection', 'High', '2023-09-08', 4543217654),
(5043, 'Rogue Access Point', 'Low', '2023-12-04', 4365432174), 
(5466, 'Business Logic Attacks', 'Medium', '2024-04-07', 4321765432),
(5442, 'Input Validation', 'High', '2024-06-05', 4654321986),
(5324, 'Insecure Storage of Sensitive Data', 'Critical', '2025-01-03', 4432165439),
(5343, 'SQL Injection', 'High', '2026-01-09', 4654321987);


INSERT INTO Remediation VALUES  
(6763, 5643, 2684, '2021-03-01', 'Static ARP Tables & Port Security Configuration'),
(6443, 5436,2342 , '2022-06-13', 'Deployed Server-Side Regex Validation & Sanitization'),
(6432, 5432,2684, '2022-09-14', 'Enforced SSL/TLS Encryption with Certificate Pinning'),
(6643, 5663, 2678, '2023-11-04', 'Implemented Parameterized Queries (PreparedStatement)'),
(6886, 5043, 2684, '2024-02-05', 'Implemented WIPS (Wireless Intrusion Prevention System)'),
(6865, 5466, 2342, '2024-06-03', 'Refined Application Workflow & State Verification'),  
(6423, 5442, 2342, '2024-08-08', 'Implemented Server-Side Input Validation with Strict Whitelisting'),
(6762, 5324, 2678, '2025-03-06', 'Implemented AES-256 Encryption for Sensitive Data at Rest'),
(6109, 5343, 2678, '2026-03-07', 'Implemented Parameterized Queries (PreparedStatement) and Regular Security Audits');

SELECT* FROM Management;
SELECT* FROM Department;
SELECT* FROM Team_and_difficultys;
SELECT* FROM Clients;
SELECT* FROM Employees;
SELECT* FROM Payroll;
SELECT* FROM Contracts;
SELECT* FROM Vulnerabilities;
SELECT* FROM Remediation;
SET SQL_SAFE_UPDATES = 0;
UPDATE Team_and_difficultys t
JOIN Department d ON t.Dep_ID = d.Dep_ID
SET 
    t.Difficulty_Critical = (SELECT COUNT(*) FROM Vulnerabilities v JOIN Clients c ON v.commercial_register_id = c.commercial_register_id WHERE v.Severity = 'Critical' AND c.Industry = d.Dep_Name
    ),
    t.Difficulty_High = (SELECT COUNT(*) FROM Vulnerabilities v JOIN Clients c ON v.commercial_register_id = c.commercial_register_id WHERE v.Severity = 'High' AND c.Industry = d.Dep_Name
    ),
    t.Difficulty_Medium = ( SELECT COUNT(*) FROM Vulnerabilities v JOIN Clients c ON v.commercial_register_id = c.commercial_register_id WHERE v.Severity = 'Medium' AND c.Industry = d.Dep_Name
    ),
    t.Difficulty_Low = (  SELECT COUNT(*) FROM Vulnerabilities v JOIN Clients c ON v.commercial_register_id = c.commercial_register_id WHERE v.Severity = 'Low' AND c.Industry = d.Dep_Name
    ),
    t.last_updated = CURDATE();

SET SQL_SAFE_UPDATES = 1;
 SELECT SUM(Difficulty_Critical) AS Total_Critical, SUM(Difficulty_High) AS Total_High, SUM(Difficulty_Medium) AS Total_Medium, SUM(Difficulty_Low) AS Total_Low FROM Team_and_difficultys;
SELECT SUM(Basic_Salary + Allowances) AS Total_Payroll FROM Payroll;
SELECT c.Company_Name, v.Vuln_Name, v.Severity, r.Fix_Method, r.Fix_Date
 FROM Vulnerabilities v JOIN Clients c ON v.commercial_register_id = c.commercial_register_id JOIN Remediation r ON v.Vuln_ID = r.Vuln_ID WHERE v.Severity IN ('High', 'Critical')ORDER BY r.Fix_Date DESC;
 SELECT SUM(Difficulty_Critical) + SUM(Difficulty_High) + SUM(Difficulty_Medium) + SUM(Difficulty_Low) AS Total_Vulnerabilities FROM Team_and_difficultys;
 SELECT * FROM Employees where Emp_name like 'al%';
  SELECT * FROM Employees where Emp_name like 'a_';
