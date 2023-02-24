DROP SCHEMA IF EXISTS EMS;
CREATE SCHEMA EMS;
USE EMS;

CREATE TABLE Delegates(
ID INT PRIMARY KEY AUTO_INCREMENT,
Forename VARCHAR(100) NOT NULL,
Surname VARCHAR(100) NOT NULL,
Created_At DATETIME DEFAULT NOW(),
DOB DATE NOT NULL,
Email VARCHAR(255) UNIQUE,
Phone_No VARCHAR(11) UNIQUE,
CONSTRAINT CHK_Phone_No_Length CHECK (LENGTH(Phone_No) = 11) 
);



INSERT INTO Delegates(DOB, Forename, Surname, Email, Phone_No, Created_At) VALUES 
('1953-09-02','Georgi','Facello', 'GeorgiFacello@gmail.com', '07573722742', '2023-01-01 00:00:05'),
('1964-06-02','Bezalel','Simmel', 'BezalelSimmel@gmail.com', '07453208543', '2023-01-01 01:00:05'),
('1959-12-03','Parto','Bamford', 'PartoBamford@gmail.com','07785791116','2023-01-01 02:00:05'),
('1954-05-01','Chirstian','Koblick', 'ChirstianKoblick@gmail.com', '07859236084', '2023-01-01 03:00:05'),
('1955-01-21','Kyoichi','Maliniak', 'KyoichiMaliniak@gmail.com', '07874784746','2023-01-01 04:00:05'),
('1953-04-20','Anneke','Preusig', 'AnnekePreusig@gmail.com', '07873638360','2023-01-01 05:00:05'),
('1957-05-23','Tzvetan','Zielinski', 'TzvetanZielinski@gmail.com', '07714113301', '2023-01-01 06:00:05'),
('1958-02-19','Saniya','Kalloufi', 'SaniyaKalloufi@gmail.com', '07714113311','2023-01-01 07:00:05'),
('1952-04-19','Sumant','Peac', 'SumantPeac@gmail.com', '07482763000','2023-01-01 08:00:05'),
('1963-06-01','Duangkaew','Piveteau', 'DuangkaewPiveteau@gmail.com', '07394184921', '2023-01-01 09:00:05'),
('1953-11-07','Mary','Sluis', 'MarySluis@gmail.com', '07589148522','2023-01-01 10:00:05'),
('1960-10-04','Patricio','Bridgland', 'PatricioBridgland@gmail.com', '07987133376', '2023-01-01 11:00:05'),
('1963-06-07','Eberhardt','Terkki', 'EberhardtTerkki@gmail.com', '07850484040', '2023-01-01 12:00:05'),
('1956-02-12','Berni','Genin', 'BerniGenin@gmail.com', '07835518259', '2023-01-01 13:00:05'),
('1959-08-19','Guoxiang','Nooteboom', 'GuoxiangNooteboom@gmail.com', '07559825010', '2023-01-01 14:00:05');

SELECT 
    *
FROM
    Delegates;

CREATE TABLE Events(
ID INT PRIMARY KEY AUTO_INCREMENT,
Title VARCHAR(100),
Event_Description VARCHAR(255),
Start_Date_Time DATETIME,
End_Date_Time DATETIME,
Quota INT
CONSTRAINT CHK_Positive_Quota CHECK (Quota >= 0)
);

INSERT INTO Events(Title, Event_Description, Start_Date_Time, End_Date_Time, Quota) VALUES 
('Boxing Session 1', 'Boxing' , '2023-01-05 19:30:00',  '2023-01-05 21:00:00', 50),
('Boxing Session 2', 'Boxing', '2023-01-10 19:30:00',  '2023-01-10 20:30:00', 20),
('Boxing Session 3', 'Boxing', '2023-01-12 19:30:00',  '2023-01-12 21:00:00', 50);

SELECT 
    *
FROM
    Events;

CREATE TABLE Bookings (
    Event_ID INT,
    Delegate_ID INT,
    Created DATETIME DEFAULT NOW(),
    Last_Edited DATETIME DEFAULT (`Created`),
    Live_Booking ENUM('Y', 'N') DEFAULT 'Y',
    FOREIGN KEY (Event_ID)
        REFERENCES Events (ID),
    FOREIGN KEY (Delegate_ID)
        REFERENCES Delegates (ID)
);

INSERT INTO Bookings (Event_ID, Delegate_ID, Created) VALUES 
(1, 1 , '2023-01-01 09:00:05'),
(1, 2 , '2023-01-01 08:00:05'),
(1, 3, '2023-01-02 09:00:05' ),
(1, 4 , '2023-01-02 09:01:05'),
(1, 5, '2023-01-02 09:00:05'),
(1, 6, '2023-01-03 09:00:05'),
(1, 7 , '2023-01-03 09:00:05'),
(1, 8 , '2023-01-03 09:00:05'),
(1, 9 , '2023-01-03 09:00:05'),
(1, 10, '2023-01-03 09:00:05'),
(1, 11, '2023-01-03 09:00:05'),
(1, 13, '2023-01-03 09:00:05'),
(1, 14, '2023-01-03 09:00:05'),
(2, 1, '2023-01-03 09:00:05'),
(2, 2, '2023-01-03 09:00:05'),
(2, 3, '2023-01-03 09:00:05'),
(2, 4, '2023-01-03 09:00:05'),
(2, 5, '2023-01-03 09:00:05'),
(2, 6, '2023-01-03 09:00:05'),
(2, 7, '2023-01-03 09:00:05'),
(2, 8, '2023-01-03 09:00:05'),
(3, 9, '2023-01-03 09:00:05'),
(3, 10, '2023-01-03 09:00:05'),
(3, 11, '2023-01-03 09:00:05'),
(3, 13, '2023-01-03 09:00:05'),
(3, 14, '2023-01-03 09:00:05');

UPDATE Bookings 
SET 
    Live_Booking = 'N',
    Last_Edited = '2023-01-03 10:00:05'
WHERE
    Delegate_ID = 2 OR Delegate_ID = 3;
    
UPDATE Bookings 
SET 
    Live_Booking = 'N',
    Last_Edited = '2023-01-02 09:30:05'
WHERE
    Delegate_ID = 2 OR Delegate_ID = 4;   
    
INSERT INTO Bookings (Event_ID, Delegate_ID) VALUES
(1,2),
(1,5);
 

SELECT 
    *
FROM
    Bookings;

-- A list of delegates booked onto a particular event, ordered by surname
CREATE INDEX delegateid ON Bookings(Delegate_ID);
CREATE INDEX livebooking ON Bookings(Live_Booking);
SELECT Surname, Forename, Email, Phone_No FROM Bookings
INNER JOIN Delegates ON Bookings.Delegate_ID = Delegates.ID
WHERE Event_ID = 1 AND Live_Booking = 'Y'
ORDER BY Surname ASC;

--  A list of cancellations for a particular event, ordered by date or time of cancellation;
SELECT Surname, Forename, Email, Phone_No, Last_Edited FROM Bookings
INNER JOIN Delegates ON Bookings.Delegate_ID = Delegates.ID
WHERE Event_ID = 1 AND Live_Booking = 'N'
ORDER BY Last_Edited;

-- A list of all delegates in the system who have never made an event booking, ordered by order of registering with the system;
CREATE INDEX eventid ON Bookings(Event_ID);
SELECT Delegates.ID, Forename, Surname, Created_At, Email, Phone_No, Event_ID FROM Delegates
LEFT JOIN Bookings ON Delegates.ID = Bookings.Delegate_ID
WHERE Event_ID IS NULL
ORDER BY Created_At Desc;

-- The average number of booked delegates per event (considering live bookings only)
SELECT AVG(`Count`) AS Average_Attendance_Per_Event  FROM (SELECT COUNT(Delegate_ID) AS Count FROM Bookings
WHERE Live_Booking = 'Y'
GROUP BY Event_ID) as nested;

-- The name of the person to have made the most recent live booking (on any event)
SELECT Delegate_ID, MAX(Last_Edited) AS Most_Recent_Booking_Time FROM Bookings
WHERE Live_Booking = 'Y';

DELIMITER /
CREATE PROCEDURE insertBooking(
IN aEvent_ID INT, 
IN aDelegate_ID INT
)
BEGIN 
INSERT INTO bookings (Event_ID, Delegate_ID) 
VALUES (aEvent_ID, aDelegate_ID);
END;
/

CREATE PROCEDURE insertDelegate(
IN aForeName VARCHAR(100),
IN aSurname VARCHAR(100),
IN aDOB DATE,
IN aEmail VARCHAR(255),
IN aPhone_No VARCHAR(11),
OUT delegateID INT
)
BEGIN
INSERT INTO delegates(Forename,Surname,DOB,Email,Phone_No) 
VALUES (aForeName, aSurname, aDOB,aEmail,aPhone_No);
SET delegateID = LAST_INSERT_ID();
SELECT(CONCAT(aForeName, ' ',aSurname, ' was created with ID: ', delegateID)) AS Output;
END;
/

CREATE PROCEDURE insertEvent(
IN aTitle VARCHAR(100),
IN aEvent_Description VARCHAR(255),
IN aStart_Date_Time DATETIME,
IN aEND_Date_Time DATETIME,
IN aQuota INT,
OUT EventID INT
)
BEGIN
INSERT INTO events (Title,Event_Description,Start_Date_Time,End_Date_Time,Quota) 
VALUES (aTitle, aEvent_Description, aStart_Date_Time,aEnd_Date_Time,Quota);
SET EventID = LAST_INSERT_ID();
SELECT(CONCAT(aTitle, ' was created with ID: ', EventID)) AS Output;
END;
/

CREATE DEFINER=`root`@`localhost` TRIGGER `bookings_BEFORE_INSERT` BEFORE INSERT ON `bookings` FOR EACH ROW BEGIN
-- get the quota of the event
   SET @Quota = (SELECT 
            A.Quota
        FROM
            `event_management_system`.`Events` A
        WHERE
            A.ID = NEW.Event_ID);

-- get the count of live bookings for this event
SET @Count = (SELECT 
            COUNT(*)
        FROM
            `event_management_system`.`Events` A
        WHERE
            A.Event_ID = NEW.Event_ID
                AND A.Live_Booking = 'Y'
        GROUP BY Event_ID);
-- if the quota is met throw an error
IF (@Count = @Quota) THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Event Quota is met. No further bookings can be made for to this event!';
END IF;

-- if the live booking alread yexists throw an error
IF NEW.Delegate_ID IN (SELECT A.Delegate_ID FROM `event_management_system`.`bookings` A WHERE NEW.Event_ID = A.Event_ID) THEN            
IF NEW.Event_ID IN (SELECT A.Event_ID FROM `event_management_system`.`bookings` A WHERE NEW.Event_ID = A.Event_ID) THEN             
IF NEW.Live_Booking IN (SELECT A.Live_Booking FROM `event_management_system`.`bookings` A WHERE A.Live_Booking = 'Y')  THEN 
            SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Live Booking Already Exists!';
 END IF;
 END IF;
 END IF; 

END 
/

CREATE DEFINER=`root`@`localhost` TRIGGER `bookings_BEFORE_UPDATE` BEFORE UPDATE ON `bookings` FOR EACH ROW BEGIN
-- get the quota of the event
   SET @Quota = (SELECT 
            A.Quota
        FROM
            `event_management_system`.`Events` A
        WHERE
            A.ID = NEW.Event_ID);

-- get the count of live bookings for this event
SET @Count = (SELECT 
            COUNT(*)
        FROM
            `event_management_system`.`Events` A
        WHERE
            A.Event_ID = NEW.Event_ID
                AND A.Live_Booking = 'Y'
        GROUP BY Event_ID);
-- if the quota is met throw an error
IF (@Count = @Quota) THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Event Quota is met. No further bookings can be made for to this event!';
END IF;

-- if the live booking alread yexists throw an error
IF NEW.Delegate_ID IN (SELECT A.Delegate_ID FROM `event_management_system`.`bookings` A WHERE NEW.Event_ID = A.Event_ID) THEN            
IF NEW.Event_ID IN (SELECT A.Event_ID FROM `event_management_system`.`bookings` A WHERE NEW.Event_ID = A.Event_ID) THEN             
IF NEW.Live_Booking IN (SELECT A.Live_Booking FROM `event_management_system`.`bookings` A WHERE A.Live_Booking = 'Y')  THEN 
            SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Live Booking Already Exists!';
 END IF;
 END IF;
 END IF; 

END
/
DELIMITER /

SELECT * FROM Delegates;