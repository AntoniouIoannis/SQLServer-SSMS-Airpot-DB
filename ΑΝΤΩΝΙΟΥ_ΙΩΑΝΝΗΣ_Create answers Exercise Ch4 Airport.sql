/* 1 */
SELECT * FROM flights
WHERE depDate = '2018-05-01'
  AND toCity = '�������';

  /*  2 */
 SELECT * FROM flights
WHERE distance BETWEEN 900 AND 1500
ORDER BY distance ASC;

/* 3 */
SELECT toCity, COUNT(*) AS total_flights
FROM flights
WHERE depDate BETWEEN '2018-05-01' AND '2018-05-30'
GROUP BY toCity;

/* 4 */
SELECT toCity, COUNT(*) AS total_flights
FROM flights
GROUP BY toCity
HAVING COUNT(*) >= 3;

/*  5 */
SELECT e.firstname, e.lastname
FROM employees e
JOIN certified c ON e.empid = c.empid

GROUP BY e.empid, e.firstname, e.lastname
HAVING COUNT(c.aid) >= 3;

/*  6 */
SELECT SUM(salary) AS total_monthly_salary_cost
FROM employees;

/*  7 */
SELECT SUM(e.salary) AS total_monthly_salary_pilots_costs
FROM employees e
/* ������ ��������� ����� ���������� ������ ��������� ����� �������*/
JOIN certified c ON e.empid = c.empid;

/* 8 */
SELECT SUM(e.salary) AS total_monthly_salary_NOTpilots_costs
FROM employees e
/* ������ ��������� ����� ���������� ������ ��������� ����� �������*/
JOIN certified c ON e.empid <> c.empid;

/* 10 */
SELECT e.firstname, e.lastname
FROM employees e
JOIN certified c ON e.empid = c.empid
JOIN aircrafts a ON c.aid = a.aid
WHERE a.aname LIKE 'Boeing%';


/*  12 */
SELECT firstname, lastname
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

/*  13  */
SELECT firstname, lastname
FROM employees
WHERE salary = (
/* �������� ��� ���������� ����� ��� �� ����� ���������� ��� ��� ���������� ���� */
/* ��� �� ��������� ��� 2� ���������� ����� */
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (
        SELECT MAX(salary)
        FROM employees
    )
);

/*  14  */
SELECT DISTINCT a.aname
FROM aircrafts a
WHERE NOT EXISTS (
    SELECT *
    FROM certified c
    JOIN employees e ON c.empid = e.empid
    WHERE c.aid = a.aid AND e.salary < 6000
);

/* 16  */
SELECT firstname, lastname
FROM employees
WHERE salary < (
    SELECT MIN(price)
    FROM flights
    WHERE toCity = '���������'
);
/*   B. �����   */
/* 18 */
CREATE VIEW pilots AS
SELECT *
FROM employees
WHERE empid IN (
    SELECT empid
    FROM certified
);
CREATE VIEW others AS
SELECT *
FROM employees
WHERE empid NOT IN (
    SELECT empid
    FROM certified
);
/*  18 ---> ���� 7  */
SELECT SUM(salary) AS total_monthly_salary_cost
FROM pilots;
/*  18 ---> ���� 8  */
SELECT firstname, lastname
FROM pilots
WHERE empid IN (
    SELECT empid
    FROM certified
    WHERE aid IN (
        SELECT aid
        FROM aircrafts
        WHERE aname LIKE 'Boeing%'
    )
);
/*  18 ---> ���� 17  */
SELECT DISTINCT a.aname
FROM aircrafts a
WHERE NOT EXISTS (
    SELECT *
    FROM certified c
    JOIN pilots p ON c.empid = p.empid
    WHERE c.aid = a.aid AND p.salary < 6000
);

/*  19 */
CREATE VIEW aircrafts_flights AS
SELECT a.aname, f.fno, f.fromCity, f.toCity
FROM aircrafts a
JOIN flights f ON a.crange >= f.distance;

SELECT aname, COUNT(*) AS num_flights_covered
FROM aircrafts_flights
GROUP BY aname;


/*      �. �����������      */
/*   20  */
CREATE PROCEDURE FlightCostDetails     
BEGIN
    SELECT fno,
           CASE 
               WHEN price <= 500 THEN '�����'
               WHEN price > 500 AND price <= 1500 THEN '��������'
               ELSE '������'
           END AS CostDetails
    FROM flights;
END

/*    21  */
CREATE PROCEDURE CertifyPilotForAircraft(
    IN pilot_name VARCHAR(100),
    IN pilot_id INT,
    IN aircraft_name VARCHAR(100),
    IN aircraft_id INT
)
BEGIN
    DECLARE pilot_exists INT;
    DECLARE aircraft_exists INT;

    -- ������� �� � ������� ������� ��� ���� ���������
    SELECT COUNT(*) INTO pilot_exists FROM employees WHERE empid = pilot_id;
    
    -- ������� �� �� ���������� ������� ��� ���� ���������
    SELECT COUNT(*) INTO aircraft_exists FROM aircrafts WHERE aid = aircraft_id;

    -- �������� ������� �� ��� ������� ��� ����
    IF pilot_exists = 0 THEN
        INSERT INTO employees(empid, lastname, firstname, salary) VALUES (pilot_id, pilot_name, '', 0);
        SELECT '������� ���� �������' AS Message;
    END IF;

    -- �������� ����������� �� ��� ������� ��� ����
    IF aircraft_exists = 0 THEN
        INSERT INTO aircrafts(aid, aname, crange) VALUES (aircraft_id, aircraft_name, 0);
        SELECT '������� ��� ����������' AS Message;
    END IF;

    -- ������� �� � ������� ����� ��� �������������� ��� �� ����������
    IF EXISTS (SELECT * FROM certified WHERE empid = pilot_id AND aid = aircraft_id) THEN
        SELECT '� ������� ����� ��� �������������� ��� �� ����������' AS Message;
    ELSE
        -- ����������� ��� ������� ��� �� ����������
        INSERT INTO certified(empid, aid) VALUES (pilot_id, aircraft_id);
        SELECT '�������� ����������� ��� ������� ��� �� ����������' AS Message;
    END IF;
END



