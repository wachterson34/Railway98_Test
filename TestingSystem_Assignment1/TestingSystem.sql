DROP DATABASE IF EXISTS Testing_System; 
-- xoa db
CREATE DATABASE Testing_System;
-- tao db
USE Testing_System;
-- su dung db

-- Table 1:Department  
DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
	DepartmentID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE KEY 
);

-- Table 2: Position  
DROP TABLE IF EXISTS Position;
CREATE TABLE `Position`(
	PositionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL UNIQUE KEY 
);

-- Table 3: Account  
DROP TABLE IF EXISTS Account;
CREATE TABLE `Account`(
	AccountID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(50) NOT NULL UNIQUE KEY,
    Username VARCHAR(50) NOT NULL UNIQUE KEY,
    FullName VARCHAR(50) NOT NULL,
    DepartmentID TINYINT UNSIGNED NOT NULL,
    PositionID TINYINT UNSIGNED NOT NULL,
    CreateDate DATETIME DEFAULT NOW(),
    FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);
                        
-- Table 4: Group  
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
	GroupID TINYINT UNSIGNED AUTO_INCREMENT,
    GroupName NVARCHAR(50) NOT NULL, 
    CreatorID TINYINT UNSIGNED NOT NULL,
    CreateDate DATETIME DEFAULT NOW(),
    PRIMARY KEY (GroupID),
    UNIQUE KEY (GroupName),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

-- Table 5: GroupAccount  
DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount(
	GroupID TINYINT UNSIGNED NOT NULL,
    AccountID TINYINT UNSIGNED NOT NULL,
    JoinDate DATETIME DEFAULT NOW(),
    PRIMARY KEY (GroupID, AccountID),
    FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID)
);

-- Table 6: TypeQuestion  
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion(
	TypeID TINYINT UNSIGNED AUTO_INCREMENT,
    TypeName ENUM('Essay', 'Multiple-Choice') NOT NULL UNIQUE KEY,
    PRIMARY KEY (TypeID)
);

-- Table 7: CategoryQuestion
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
	CategoryID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL UNIQUE KEY 
);

-- Table 8: Question  
DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
	QuestionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content NVARCHAR(100) NOT NULL,
    CategoryID TINYINT UNSIGNED NOT NULL,
    TypeID TINYINT UNSIGNED NOT NULL,
    CreatorID TINYINT UNSIGNED NOT NULL,
    CreateDate DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(TypeID) REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

-- Table 9: Answer 
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
	AnswerID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content VARCHAR(500) NOT NULL,
    QuestionID TINYINT UNSIGNED NOT NULL,
    isCorrect BIT DEFAULT 1,
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

-- Table 10: Exam  
DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam(
	ExamID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code` CHAR(10) NOT NULL,
    Title NVARCHAR(50) NOT NULL,
    CategoryID TINYINT UNSIGNED NOT NULL,
    Duration INT UNSIGNED NOT NULL,
    CreatorID TINYINT UNSIGNED NOT NULL,
    CreateDate DATETIME DEFAULT NOW(),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID)
);

-- Table 11: ExamQuestion
DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
	ExamID TINYINT UNSIGNED NOT NULL,
    QuestionID TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (ExamID, QuestionID),
    FOREIGN KEY(ExamID) REFERENCES Exam(ExamID),
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);
-- INSERT INTO Department(DepartmentName)
-- VALUES
-- 						( 'BOD'),
-- 						( 'Maketing'),
-- 						( 'Sale'),
--                         ( 'HR'),
--                         ( 'IT');
                        
-- =======================================================================Testing_System_Assignment_2=======================================================================

-- INSERT TABLE Department
INSERT INTO Department(DepartmentName)
VALUES 
					  ('DepartmentName1'),
                      ('DepartmentName2'),
                      ('DepartmentName3'),
                      ('DepartmentName4'),
                      ('DepartmentName5'),
					  ('DepartmentName6'),
                      ('DepartmentName7'),
                      ('DepartmentName8'),
                      ('DepartmentName9'),
                      ('DepartmentName10');

-- INSERT TABLE Position 'Dev', 'Test', 'Scrum Master', 'PM'
INSERT INTO `Position`(PositionName)
VALUES 
					  ('Dev'),
                      ('Test'),
                      ('Scrum Master'),
                      ('PM');

-- INSERT TABLE `Account`
INSERT INTO `Account`(Email, Username, FullName, DepartmentID, PositionID, CreateDate)
VALUES
					  ('email1@gmail.com', 'nguyenvan1', 'Nguyễn Văn 1', 1, 1, DEFAULT),
                      ('email2@gmail.com', 'nguyenvan2', 'Nguyễn Văn 2', 2, 2, DEFAULT),
                      ('email3@gmail.com', 'nguyenvan3', 'Nguyễn Văn 3', 3, 3, DEFAULT),
                      ('email4@gmail.com', 'nguyenvan4', 'Nguyễn Văn 4', 4, 4, DEFAULT),
                      ('email5@gmail.com', 'nguyenvan5', 'Nguyễn Văn 5', 5, 4, DEFAULT),
					  ('email6@gmail.com', 'nguyenvan6', 'Nguyễn Văn 6', 6, 3, DEFAULT),
                      ('email7@gmail.com', 'nguyenvan7', 'Nguyễn Văn 7', 7, 2, DEFAULT),
                      ('email8@gmail.com', 'nguyenvan8', 'Nguyễn Văn 8', 8, 3, DEFAULT),
                      ('email9@gmail.com', 'nguyenvan9', 'Nguyễn Văn 9', 9, 4, DEFAULT),
                      ('email10@gmail.com', 'nguyenvan10', 'Nguyễn Văn 10', 10, 4, DEFAULT);

-- INSERT TABLE Group 
INSERT INTO `Group`(GroupName, CreatorID, CreateDate)
VALUES
					  ('GroupName1', 1, DEFAULT),
                      ('GroupName2', 2, DEFAULT),
                      ('GroupName3', 3, DEFAULT),
                      ('GroupName4', 3, DEFAULT),
                      ('GroupName5', 4, DEFAULT),
					  ('GroupName6', 5, DEFAULT),
                      ('GroupName7', 2, DEFAULT),
                      ('GroupName8', 7, DEFAULT),
                      ('GroupName9', 3, DEFAULT),
                      ('GroupName10', 9, DEFAULT);

-- INSERT TABLE GroupAccount    GroupID AccountID  JoinDate
INSERT INTO GroupAccount(GroupID, AccountID, JoinDate)
VALUES
					  (1, 1, DEFAULT),
                      (2, 2, DEFAULT),
                      (3, 3, DEFAULT),
                      (3, 4, DEFAULT),
                      (5, 4, DEFAULT),
					  (1, 6, DEFAULT),
                      (2, 8, DEFAULT),
                      (3, 6, DEFAULT),
                      (3, 9, DEFAULT),
                      (5, 1, DEFAULT);

-- INSERT TABLE TypeQuestion
INSERT INTO TypeQuestion(TypeName)
VALUES
					  ('Essay'),
                      ('Multiple-Choice');

-- INSERT TABLE CategoryQuestion
INSERT INTO CategoryQuestion(CategoryName)
VALUES
					  ('Category1'),
                      ('Category2'),
                      ('Category3'),
                      ('Category4'),
                      ('Category5'),
					  ('Category6'),
                      ('Category7'),
                      ('Category8'),
                      ('Category9'),
                      ('Category10');

-- INSERT TABLE Question  
INSERT INTO Question(Content, CategoryID, TypeID, CreatorID, CreateDate)
VALUES
					  ('Content1', 1, 1, 1, DEFAULT),
                      ('Content2', 2, 1, 2, DEFAULT),
                      ('Content3', 3, 2, 4, DEFAULT),
                      ('Content5', 4, 2, 3, DEFAULT),
                      ('Content4', 5, 2, 5, DEFAULT),
					  ('Content6', 6, 1, 6, DEFAULT),
                      ('Content7', 7, 1, 7, DEFAULT),
                      ('Content8', 8, 2, 4, DEFAULT),
                      ('Content9', 9, 2, 3, DEFAULT),
                      ('Content10', 10, 2, 5, DEFAULT);

-- INSERT TABLE Answer  
INSERT INTO Answer(Content, QuestionID, isCorrect)
VALUES
					  ('Content1', 1, 1),
                      ('Content2', 2, 1),
                      ('Content3', 3, 0),
                      ('Content5', 4, 0),
                      ('Content4', 5, 1),
					  ('Content6', 6, 1),
                      ('Content7', 7, 1),
                      ('Content8', 8, 0),
                      ('Content9', 9, 0),
                      ('Content10', 10, 1);

-- INSERT TABLE Exam  
INSERT INTO Exam(`Code`, Title, CategoryID, Duration, CreatorID, CreateDate)
VALUES
					  ('Code1', 'Title1', 1, 90, 1, DEFAULT),
                      ('Code2', 'Title2', 2, 90, 2, DEFAULT),
                      ('Code3', 'Title3', 3, 90, 4, DEFAULT),
                      ('Code4', 'Title4', 4, 90, 3, DEFAULT),
                      ('Code5', 'Title5', 5, 90, 5, DEFAULT),
					  ('Code6', 'Title6', 6, 90, 1, DEFAULT),
                      ('Code7', 'Title7', 7, 90, 2, DEFAULT),
                      ('Code8', 'Title8', 8, 90, 4, DEFAULT),
                      ('Code9', 'Title9', 9, 90, 3, DEFAULT),
                      ('Code10', 'Title10', 10, 90, 5, DEFAULT);

-- INSERT TABLE ExamQuestion 
INSERT INTO ExamQuestion(ExamID, QuestionID)
VALUES
					  (1,2),
                      (1,3),
                      (3,4),
                      (2,3),
                      (4,5),
					  (2,2),
                      (3,3),
                      (5,4),
                      (6,3),
                      (7,5);

-- Lay du lieu
-- Lấy ra tất cả danh sách Account có trên hệ thống
SELECT * FROM Account;
SELECT * FROM Department;
SELECT * FROM Position;
-- Lấy ra tất cả danh sách Account hiển thị thông tin AccountID, Email, Fullname
SELECT AccountID, Email, FullName FROM Account;
SELECT DISTINCT(FullName) FROM Account;
-- Lấy ra tất cả danh sách Account mà thuộc phòng ban số 1 ==> Điều kiện DepartmentID=1
SELECT * FROM Account WHERE DepartmentID=5;
SELECT * FROM Account WHERE DepartmentID=1 AND PositionID=2;
SELECT * FROM Account WHERE DepartmentID=1 OR DepartmentID=2;
SELECT * FROM Account WHERE DepartmentID=1 OR DepartmentID=2 OR DepartmentID=5;
SELECT * FROM Account WHERE DepartmentID IN (1,2,5);
SELECT * FROM Account WHERE DepartmentID BETWEEN 1 AND 20;
SELECT * FROM Account WHERE CreateDate IS NULL;
SELECT * FROM Account WHERE CreateDate IS NOT NULL;
SELECT * FROM Account WHERE CreateDate > '2025-11-26 00:13:35';

-- Lấy ra tất cả các bản ghi trong bảng Account, mà có fullname bắt đầu bằng chữ N
SELECT * FROM Account WHERE FullName LIKE 'N%'; -- LIKE: Su dung so sanh gan dung
-- Lấy ra tất cả các bản ghi trong bảng Account, mà fullname có chữ thứ 2 là u
SELECT * FROM Account WHERE FullName LIKE '_g%';

-- Hãy đếm số bản ghi trong bảng Account
SELECT COUNT(*) FROM Account;
SELECT COUNT(1) FROM Account;
SELECT *,(1) FROM Account;
SELECT COUNT(Email) FROM Account;
SELECT length('FullName');
SELECT length(FullName) FROM Account;
SELECT NOW();
SELECT SUM(DepartmentID) FROM Account;

DROP TABLE IF EXISTS Student;
CREATE TABLE `Student`(
     Id		                    TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	 Student_Name				VARCHAR(50) NOT NULL,
     Subject_Name		      	VARCHAR(50) NOT NULL,
     Point_Student				TINYINT
);

SELECT * FROM Student;

INSERT INTO Student (Student_Name, Subject_Name, Point_Student)
VALUES				('Name1',	'Sql', 		'7'),
					('Name2',	'Java', 	'8'),
                    ('Name3',	'Java', 	'9'),
                    ('Name4',	'Sql', 		'5'),
                    ('Name5',	'Java', 	'4'),
                    ('Name6',	'Spring', 	'5'),
                    ('Name7',	'Java', 	'8'),
                    ('Name8',	'Spring', 	'8'),
					('Name9',	'Sql', 	'5'),
                    ('Name10',	'Spring', 	'4'),
                    ('Name11',	'Sql', 	'5'),
                    ('Name12',	'Spring', 	'8'),
                    ('Name13',	'Sql', 	'8');
SELECT SUM(Point_Student) FROM Student;
-- Tìm điểm số lớn nhất và nhỏ nhất, điểm số trung bình trong bảng điểm
SELECT Max(Point_Student) FROM Student;
SELECT MIN(Point_Student) FROM Student;
SELECT AVG(Point_Student) FROM Student;
-- Tìm điểm số lớn nhất của môn SQL
SELECT Max(Point_Student) FROM Student WHERE Subject_Name = 'Sql';
-- Tìm điểm số lớn nhất của môn Java
SELECT Max(Point_Student) FROM Student WHERE Subject_Name = 'Java';
-- Tìm điểm số lớn nhất của môn spring
SELECT Max(Point_Student) FROM Student WHERE Subject_Name = 'Spring';

-- Question 2: Lấy ra tất cả các phòng ban
SELECT * FROM Department;
-- Question 3: Lấy ra id của phòng ban "Sale" 
SELECT DepartmentID FROM Department WHERE DepartmentName = 'Sale';
-- Question 4: Lấy ra thông tin account có full name dài nhất
SELECT * FROM Account WHERE length(FullName) = (SELECT max(length(FullName)) FROM Account);
-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id  = 3
SELECT * FROM Account WHERE DepartmentID=3 AND length(FullName) = (SELECT max(length(FullName)) FROM Account WHERE DepartmentID=3);
-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019 
SELECT GroupName FROM `Group` WHERE CreateDate < '2019-12-20 00:00:00';
-- Question 7: Lấy ra ID của question có >= 4 câu trả lời 
-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT Code FROM Exam WHERE Duration >=60 AND CreateDate < '2019-12-20';
-- Question 9: Lấy ra 5 group được tạo gần đây nhất 
-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT COUNT(*) FROM Account WHERE DepartmentID=2;
-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o" 
SELECT * FROM Account WHERE FullName LIKE 'D%' AND FullName LIKE '%o';
