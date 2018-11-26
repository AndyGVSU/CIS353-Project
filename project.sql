SPOOL project.out
SET ECHO ON
/*
CIS 353 - Database Design Project
Andy Hudson
Parker Petroff
Zachary Poorman
*/
DROP TABLE Model_Color CASCADE CONSTRAINTS;
DROP TABLE Car_Model CASCADE CONSTRAINTS;
DROP TABLE Car_Order CASCADE CONSTRAINTS;
DROP TABLE Works_On CASCADE CONSTRAINTS;
DROP TABLE Employee CASCADE CONSTRAINTS; 
DROP TABLE Car_List CASCADE CONSTRAINTS;
DROP TABLE Department CASCADE CONSTRAINTS;
DROP TABLE Dealership CASCADE CONSTRAINTS;
DROP TABLE Project CASCADE CONSTRAINTS;
--
-- Create all tables
--
CREATE TABLE Department(
dID INTEGER PRIMARY KEY,
dName CHAR(16) NOT NULL
);
CREATE TABLE Dealership(
lAddress CHAR(24) PRIMARY KEY,
lName CHAR(16) NOT NULL
);
--
CREATE TABLE Car_Model(
	mID			integer PRIMARY KEY,
	manufacturingCost	float NOT NULL,
	mName			char(24) NOT NULL
);
--
CREATE TABLE Project(
pID INTEGER PRIMARY KEY,
pName CHAR(16) NOT NULL,
pStartDate DATE NOT NULL,
pEndDate DATE,
budgetValue DECIMAL(16,2),
budgetSpent DECIMAL(16,2),
--finishedTimeRemaining DATE,
mID INTEGER,
dID INTEGER,
CONSTRAINT pIC0 FOREIGN KEY (mID) REFERENCES Car_Model(mID)
ON DELETE SET NULL,
CONSTRAINT pIC2 FOREIGN KEY (dID) REFERENCES Department(dID)
ON DELETE SET NULL,
CONSTRAINT pIC3 CHECK(budgetValue > 0)
);
--
CREATE TABLE Works_On(
  eSSN INTEGER,
  pID NUMBER(4),
  PRIMARY KEY(eSSN,pID)
);
--
CREATE TABLE Employee(
  eSSN INTEGER PRIMARY KEY,
  eName	varchar2(15),
  eAddress	varchar2(24),
  eBirthDate	date,
  salary	number(10,2),
  jobTitle	varchar(16),
  dID		number(7),
  CONSTRAINT eIC3 CHECK(jobTitle = 'manager' AND salary >= 70000)
);
--
CREATE TABLE Car_List(
  mID		number(8),
  lAddress	char(24),
  modelCount number(12),
  primary key (mID,lAddress)
);
--
CREATE TABLE Model_Color(
	mID	integer NOT NULL,
	color	char(15) NOT NULL,
	primary key (mID,color)
);
--
CREATE TABLE Car_Order(
	lAddress	char(24) NOT NULL,
	dID		integer NOT NULL,
	dateIssued	date NOT NULL,
	primary key(laddress,dID)
);
/*
Add foreign keys:
*/
ALTER TABLE Model_Color
ADD FOREIGN KEY (mID) references Car_Model(mID)
Deferrable initially deferred;
ALTER TABLE Works_On
ADD FOREIGN KEY (eSSN) references Employee(eSSN)
Deferrable initially deferred;
ALTER TABLE Works_On
ADD FOREIGN KEY (pID) references Project(pID)
Deferrable initially deferred;
ALTER TABLE Car_List
ADD FOREIGN KEY (mID) references Car_Model(mID)
Deferrable initially deferred;
ALTER TABLE Car_List
ADD FOREIGN KEY (lAddress) references Dealership(lAddress)
Deferrable initially deferred;
--
--
SET FEEDBACK OFF
--POPULATE TABLES
INSERT INTO Dealership VALUES('12512 Weber Lane','Auto Dealers 01');
INSERT INTO Department VALUES(0, 'Finances');
INSERT INTO Car_Model VALUES(0, 75000, 'Toyota Camry 2018');
INSERT INTO Car_Order VALUES('12512 Weber Lane', 0, TO_DATE('05/15/18','MM/DD/YY'));
INSERT INTO Car_List VALUES(0,'12512 Weber Lane', 5);
INSERT INTO Model_Color VALUES(0, 'black');
INSERT INTO Employee VALUES(10000001,'Andy Hudson','51234 84th St.',TO_DATE('05/29/99','MM/DD/YY'),95000,'manager',0);
INSERT INTO Project VALUES(001,'Camry Reconfig',TO_DATE('12/01/16','MM/DD/YY'),TO_DATE('01/01/17','MM/DD/YY'),120000,80000,0,0);
INSERT INTO Works_On VALUES(10000001,001);
--
SET FEEDBACK ON
COMMIT;
--
--
SELECT * FROM Model_Color;
SELECT * FROM Car_Model;
SELECT * FROM Car_Order;
SELECT * FROM Works_On;
SELECT * FROM Employee; 
SELECT * FROM Car_List;
SELECT * FROM Department;
SELECT * FROM Dealership;
SELECT * FROM Project;
--
--
--QUERIES, in format:
--Q1 - Query Type
--Description in English
--(code)
--
--
--Tests for ICs, in format:
--Testing: IC#
--(code)
COMMIT;
--
SPOOL OFF
