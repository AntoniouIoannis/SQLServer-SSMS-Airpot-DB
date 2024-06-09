CREATE TABLE flights 
( fno VARCHAR(4) PRIMARY KEY, 
  fromCity VARCHAR(30) NOT NULL, 
  toCity VARCHAR(30) NOT NULL, 
  distance INT NOT NULL CHECK (distance > 0), 
  depDate DATE NOT NULL,
  depTime TIME NOT NULL,
  arrDate DATE NOT NULL,
  arrTime TIME NOT NULL,
  price INT CHECK (price >0), 
 );

  CREATE TABLE aircrafts 
( aid INT PRIMARY KEY, 
  aname VARCHAR(50), 
  crange INTEGER
 );

CREATE TABLE employees
(empid INT PRIMARY KEY,
 lastname VARCHAR(30) NOT NULL,
 firstname VARCHAR(30) NOT NULL, 
 salary INT CHECK (salary > 0)
 );

CREATE TABLE certified
(empid INT, 
 aid   INT, 
 PRIMARY KEY(empid, aid), 
 FOREIGN KEY (empid) REFERENCES employees (empid),
 FOREIGN KEY (aid) REFERENCES aircrafts (aid)
 ); 


INSERT INTO flights VALUES ('A300', 'Αθήνα', 'Τορόντο', 1000, '2018-05-01', '09:00', '2018-05-01', '18:00', 800);
INSERT INTO flights VALUES ('A301', 'Αθήνα', 'Νέα Υόρκη', 1200, '2018-05-01', '09:00', '2018-05-01', '17:00', 1000);
INSERT INTO flights VALUES ('A302', 'Αθήνα', 'Λονδίνο', 500, '2018-05-02', '18:00', '2018-05-02', '21:00', 500);
INSERT INTO flights VALUES ('A303', 'Αθήνα', 'Λονδίνο', 600, '2018-05-02', '19:00', '2018-05-02', '22:00', 600);
INSERT INTO flights VALUES ('A400', 'Αθήνα', 'Μελβούρνη', 3000, '2018-05-03', '19:00', '2018-05-04', '05:00', 2500);
INSERT INTO flights VALUES ('A401', 'Λονδίνο', 'Μελβούρνη', 2500, '2018-05-03', '09:00', '2018-05-03', '20:00', 3000);
INSERT INTO flights VALUES ('A305', 'Λονδίνο', 'Αθήνα', 500, '2018-05-03', '10:00', '2018-05-03', '12:00', 400);
INSERT INTO flights VALUES ('A306', 'Παρίσι', 'Αθήνα', 700, '2018-05-04', '11:00', '2018-05-04', '13:00', 600);
INSERT INTO flights VALUES ('A307', 'Ρώμη', 'Νέα Υόρκη', 1500, '2018-05-04', '12:00', '2018-05-04', '23:00', 1700);
INSERT INTO flights VALUES ('A308', 'Λονδίνο', 'Νέα Υόρκη', 1700, '2018-05-05', '13:00', '2018-05-05', '21:00', 2000);
INSERT INTO  aircrafts VALUES (1, 'Boeing 787', 10000);
INSERT INTO  aircrafts VALUES (2, 'Boeing 777', 8000);
INSERT INTO  aircrafts VALUES(3, 'Boeing B29', 2000);
INSERT INTO  aircrafts VALUES(4, 'Boeing 747', 3000);
INSERT INTO  aircrafts VALUES(5, 'Airbus A320', 5000);
INSERT INTO  aircrafts VALUES(6, 'Airbus A380', 2000);
INSERT INTO  aircrafts VALUES(7, 'Learjet 23', 1000);
INSERT INTO  aircrafts VALUES(8, 'Douglas DC3', 7000);
INSERT INTO  aircrafts VALUES(9, 'Super Jumbo', 15000);
INSERT INTO  aircrafts VALUES(10, 'Ilyushin', 1500);


INSERT INTO  employees  VALUES (10, 'Αβραμίδης','Μάριος',  6000);
INSERT INTO  employees   VALUES (14, 'Αγγελίδου','Μαρία',  5000);
INSERT INTO  employees    VALUES (15, 'Αγγελοπούλου','Ελένη',  2000);
INSERT INTO  employees    VALUES (11, 'Αθανασιάδης','Αγγελος',  7000);
INSERT INTO  employees    VALUES (16, 'Αλεξάνδρου ','Αννα',  6000);
INSERT INTO  employees    VALUES (17, 'Βαμβακά','Νέλη',  2000);
INSERT INTO  employees   VALUES (12, 'Βλαχόπουλος','Ιωάννης',  1500);
INSERT INTO  employees    VALUES (13, 'Βούλγαρης','Δημήτρης',  3000);
INSERT INTO  employees    VALUES (18, 'Γαλάνη','Νάντια',  1000);
INSERT INTO  employees   VALUES (19, 'Γεωργίου','Γεώργιος',  2000);

INSERT INTO  certified  VALUES (10,1);
INSERT INTO  certified  VALUES (10,2);
INSERT INTO  certified  VALUES (10,3);
INSERT INTO  certified  VALUES (10,4);
INSERT INTO  certified  VALUES (11,2);
INSERT INTO  certified  VALUES (11,3);
INSERT INTO  certified  VALUES (12,1);
INSERT INTO  certified  VALUES (12,2);
INSERT INTO  certified  VALUES (12,5);
INSERT INTO  certified  VALUES (12,6);
INSERT INTO  certified  VALUES (13,7);
INSERT INTO  certified  VALUES (13,8);
INSERT INTO  certified  VALUES (13,9);
INSERT INTO  certified  VALUES (14,10);
INSERT INTO  certified  VALUES (14,1);
INSERT INTO  certified  VALUES (14,9);
INSERT INTO  certified  VALUES (15,10);
INSERT INTO  certified  VALUES (16,8);
INSERT INTO  certified  VALUES (16,9);

