DROP DATABASE if exists SCholastic;

CREATE DATABASE SCholastic;
USE SCholastic;

CREATE TABLE Users (
	userID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    username VARCHAR(20) NOT NULL,
    password VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    university VARCHAR(100) NOT NULL,
    major VARCHAR(50) NOT NULL
);

INSERT INTO Users(username, password, name,email,university, major)
	VALUES	('jltanner', '123', 'John Tanner', 'jltanner@usc.edu', 'USC', 'CSCI'),
			('asheesh','456','Asheesh Chopra','aChopra@usc.edu','USC','CSCI'),
            ('cameron','789','Cameron Durham','cdurham@usc.edu','USC','CSCI'),
            ('sam','000','Sam Abdallah','sam@usc.edu','USC','BUAD'),
            ('austin','111','Austin Traver','traver@usc.edu','USC','CSCI');

CREATE TABLE Classes (
	classID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(1000) NOT NULL,
    teacher VARCHAR(100) NOT NULL,
    coursecode VARCHAR(50) NOT NULL
);

INSERT INTO Classes(name, teacher, coursecode)
	VALUES	('Software Engineering','Jeffrey Miller', 'CSCI-201'),
			('Data Structures and Ob-Design','Sandra Batista', 'CSCI-104'),
			('Algorithm Design','Aaron Cote', 'CSCI-270'),
            ('Some GE','Willimer Harinsomer III', 'BST-420');

CREATE TABLE Ratings (
	ratingID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    classID INT(11) NOT NULL,
    rating DECIMAL(11,1) NOT NULL,
    review VARCHAR(1000) NOT NULL,
    userID INT(11) NOT NULL,
    FOREIGN KEY fk1(classID) REFERENCES Classes(classID),
	FOREIGN KEY fk2(userID) REFERENCES Users(userID)
);

INSERT INTO Ratings(classID, rating, review, userID)
	VALUES 	(2,5.0,'Great Class',1),
			(4,1.0,'Terrible waste of time',4),
            (1,4.5,'Great real-world application',2),
            (3,3.5,'Does P = NP?',3);
            
CREATE TABLE Friends (
	friendID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    userID1 INT(11) NOT NULL,
	userID2 INT(11) NOT NULL,
    pending BOOLEAN NOT NULL,
    FOREIGN KEY fk1(userID1) REFERENCES Users(userID),
    FOREIGN KEY fk2(userID2) REFERENCES Users(userID)
);

-- INSERT INTO Friends(userID1, userID2, pending)
	
