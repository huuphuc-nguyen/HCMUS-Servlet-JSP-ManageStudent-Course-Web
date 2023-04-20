CREATE DATABASE QLSV;

USE QLSV;

CREATE TABLE Course (
    CourseId INT PRIMARY KEY,
    CourseName VARCHAR(50),
    Lecture VARCHAR(50),
    Year INT,
    Note VARCHAR(100)
);

CREATE TABLE Student (
    StudentId INT PRIMARY KEY,
    StudentName VARCHAR(50),
    Grade INT CHECK (Grade BETWEEN 1 AND 12),
    BirthDate DATE,
    Address VARCHAR(100),
    Note VARCHAR(100)
);

CREATE TABLE CourseStudent (
    StudentId INT,
    CourseId INT,
    Score FLOAT,
    PRIMARY KEY (StudentId, CourseId),
    FOREIGN KEY (StudentId) REFERENCES Student(StudentId),
    FOREIGN KEY (CourseId) REFERENCES Course(CourseId)
);

-- Insert 10 courses
INSERT INTO Course (CourseId, CourseName, Lecture, Year, Note)
VALUES
    (1, 'Mathematics', 'Mr. Smith', 2022, 'Advanced course for seniors.'),
    (2, 'Chemistry', 'Dr. Johnson', 2022, 'Introductory course for sophomores.'),
    (3, 'Physics', 'Dr. Lee', 2022, 'Advanced course for juniors.'),
    (4, 'Biology', 'Ms. Brown', 2022, 'Introductory course for freshmen.'),
    (5, 'Computer Science', 'Mr. Kim', 2022, 'Advanced course for seniors.'),
    (6, 'English', 'Ms. Garcia', 2022, 'Introductory course for freshmen.'),
    (7, 'History', 'Mr. Rodriguez', 2022, 'Introductory course for sophomores.'),
    (8, 'Art', 'Ms. Davis', 2022, 'Introductory course for freshmen.'),
    (9, 'Music', 'Mr. Wilson', 2022, 'Introductory course for freshmen.'),
    (10, 'Physical Education', 'Ms. Martinez', 2022, 'Required course for all students.');

-- Insert 20 students
INSERT INTO Student (StudentId, StudentName, Grade, BirthDate, Address, Note)
VALUES
    (1, 'John Smith', 11, '2007-03-15', '123 Main St, Anytown, USA', 'Likes to play basketball.'),
    (2, 'Emma Johnson', 9, '2009-06-25', '456 Oak Ave, Anytown, USA', 'Enjoys playing the piano.'),
    (3, 'Michael Lee', 10, '2008-09-01', '789 Maple St, Anytown, USA', 'Loves playing video games.'),
    (4, 'Olivia Brown', 12, '2006-02-14', '321 Elm St, Anytown, USA', 'Enjoys reading science fiction.'),
    (5, 'Sophia Kim', 11, '2007-11-05', '987 Pine St, Anytown, USA', 'Likes to draw and paint.'),
    (6, 'Jacob Garcia', 9, '2009-04-30', '654 Cedar Ave, Anytown, USA', 'Enjoys playing soccer.'),
    (7, 'Isabella Rodriguez', 10, '2008-07-12', '321 Oak St, Anytown, USA', 'Likes to watch movies.'),
    (8, 'Ethan Davis', 9, '2009-01-18', '789 Birch Rd, Anytown, USA', 'Enjoys playing guitar.'),
    (9, 'Mia Wilson', 11, '2007-08-20', '123 Pine Ave, Anytown, USA', 'Likes to dance.'),
    (10, 'Alexander Martinez', 12, '2006-05-10', '456 Maple St, Anytown, USA', 'Enjoys playing football.'),
    (11, 'Ava Smith', 12, '2006-07-15', '123 Main St, Anytown, USA', 'Likes to play basketball.'),
    (12, 'William Johnson', 11, '2007-02-25', '456 Oak Ave, Anytown, USA', 'Enjoys playing the piano.'),
    (13, 'Benjamin Brown', 10, '2008-01-14', '789 Maple St, Anytown, USA', 'Loves playing video games.'),
    (14, 'Isabella Kim', 12, '2006-11-05', '987 Pine St, Anytown, USA', 'Likes to draw and paint.'),
    (15, 'Michael Garcia', 11, '2007-04-30', '654 Cedar Ave, Anytown, USA', 'Enjoys playing soccer.'),
    (16, 'Emma Rodriguez', 9, '2009-07-12', '321 Oak St, Anytown, USA', 'Likes to watch movies.'),
    (17, 'William Davis', 10, '2008-01-18', '789 Birch Rd, Anytown, USA', 'Enjoys playing guitar.'),
    (18, 'Mia Wilson', 11, '2007-08-20', '123 Pine Ave, Anytown, USA', 'Likes to dance.'),
    (19, 'Alexander Martinez', 12, '2006-05-10', '456 Maple St, Anytown, USA', 'Enjoys playing football.'),
    (20, 'Avery Brown', 9, '2009-03-14', '321 Elm St, Anytown, USA', 'Enjoys playing video games.'),
	(21, 'Emily Kim', 11, '2007-12-05', '987 Pine St, Anytown, USA', 'Likes to draw and paint.'),
    (22, 'James Garcia', 10, '2008-05-30', '654 Cedar Ave, Anytown, USA', 'Enjoys playing soccer.'),
    (23, 'Ethan Rodriguez', 9, '2009-08-12', '321 Oak St, Anytown, USA', 'Likes to watch movies.'),
    (24, 'Avery Davis', 11, '2007-02-18', '789 Birch Rd, Anytown, USA', 'Enjoys playing guitar.'),
    (25, 'Charlotte Wilson', 10, '2008-08-20', '123 Pine Ave, Anytown, USA', 'Likes to dance.'),
    (26, 'Benjamin Martinez', 12, '2006-06-10', '456 Maple St, Anytown, USA', 'Enjoys playing football.'),
    (27, 'Lucas Brown', 11, '2007-01-14', '789 Maple St, Anytown, USA', 'Loves playing video games.'),
    (28, 'Aria Kim', 9, '2009-10-05', '987 Pine St, Anytown, USA', 'Likes to draw and paint.'),
    (29, 'Liam Garcia', 10, '2008-03-30', '654 Cedar Ave, Anytown, USA', 'Enjoys playing soccer.'),
    (30, 'Evelyn Rodriguez', 11, '2007-06-12', '321 Oak St, Anytown, USA', 'Likes to watch movies.');

INSERT INTO CourseStudent (StudentId, CourseId, Score)
VALUES
    (1, 1, 7.5),
    (1, 2, 8.2),
    (1, 3, 9.1),
    (1, 4, 8.6),
    (2, 1, 8.9),
    (2, 2, 9.5),
    (2, 3, 8.1),
    (2, 4, 9.2),
    (3, 1, 9.1),
    (3, 2, 8.6),
    (3, 3, 9.0),
    (3, 4, 8.4),
    (4, 1, 7.8),
    (4, 2, 8.3),
    (4, 3, 8.9),
    (4, 4, 9.3),
    (5, 1, 9.2),
    (5, 2, 8.1),
    (5, 3, 7.9),
    (5, 4, 8.5),
    (6, 1, 8.5),
    (6, 2, 9.1),
    (6, 3, 8.8),
    (6, 4, 9.5),
    (7, 1, 9.0),
    (7, 2, 8.6),
    (7, 3, 9.1),
    (7, 4, 8.4),
    (8, 1, 7.7),
    (8, 2, 8.4),
    (8, 3, 8.9),
    (8, 4, 9.2),
    (9, 1, 9.3),
    (9, 2, 8.2),
    (9, 3, 8.0),
    (9, 4, 8.6),
    (10, 1, 8.6),
    (10, 2, 9.2),
    (10, 3, 8.7),
    (10, 4, 9.4),
    (11, 1, 9.1),
    (11, 2, 8.6),
    (11, 3, 9.0),
    (11, 4, 8.3),
    (12, 1, 7.8),
    (12, 2, 8.3),
    (12, 3, 8.9),
    (12, 4, 9.3),
	(13, 1, 8.3),
    (13, 2, 9.1),
    (13, 3, 8.6),
    (13, 4, 9.5),
    (14, 1, 8.8),
    (14, 2, 9.2),
    (14, 3, 8.7),
    (14, 4, 9.4),
    (15, 1, 9.1),
    (15, 2, 8.6),
    (15, 3, 9.0),
    (15, 4, 8.3),
    (16, 1, 7.8),
    (16, 2, 8.3),
    (16, 3, 8.9),
    (16, 4, 9.3),
    (17, 1, 9.3),
    (17, 2, 8.2),
    (17, 3, 8.0),
    (17, 4, 8.6),
    (18, 1, 8.6),
    (18, 2, 9.2),
    (18, 3, 8.7),
    (18, 4, 9.4),
    (19, 1, 9.1),
    (19, 2, 8.6),
    (19, 3, 9.0),
    (19, 4, 8.3),
    (20, 1, 7.8),
    (20, 2, 8.3),
    (20, 3, 8.9),
    (20, 4, 9.3),
    (21, 1, 9.3),
    (21, 2, 8.2),
    (21, 3, 8.0),
    (21, 4, 8.6),
    (22, 1, 8.6),
    (22, 2, 9.2),
    (22, 3, 8.7),
    (22, 4, 9.4),
    (23, 1, 9.1),
    (23, 2, 8.6),
    (23, 3, 9.0),
    (23, 4, 8.3),
    (24, 1, 7.8),
    (24, 2, 8.3),
    (24, 3, 8.9),
    (24, 4, 9.3),
    (25, 1, 9.3),
    (25, 2, 8.2),
    (25, 3, 8.0),
    (25, 4, 8.6),
	(26, 1, 8.6),
    (26, 2, 9.2),
    (26, 3, 8.7),
    (26, 4, 9.4),
    (27, 1, 9.1),
    (27, 2, 8.6),
    (27, 3, 9.0),
    (27, 4, 8.3),
    (28, 1, 7.8),
    (28, 2, 8.3),
    (28, 3, 8.9),
    (28, 4, 9.3),
    (29, 1, 9.3),
    (29, 2, 8.2),
    (29, 3, 8.0),
    (29, 4, 8.6),
    (30, 1, 8.6),
    (30, 2, 9.2),
    (30, 3, 8.7),
    (30, 4, 9.4);