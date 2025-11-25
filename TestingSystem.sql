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
					  ('BOD'),
                      ('Maketing'),
                      ('Sale'),
                      ('HR'),
                      ('IT');

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
					  ('email1@gmail.com', 'nguyenvanA', N'Nguyễn Văn A', 1, 1, DEFAULT),
                      ('email2@gmail.com', 'nguyenvanB', N'Nguyễn Văn B', 1, 2, DEFAULT),
                      ('email3@gmail.com', 'nguyenvanC', N'Nguyễn Văn C', 2, 3, DEFAULT),
                      ('email4@gmail.com', 'nguyenvanD', N'Nguyễn Văn D', 5, 4, DEFAULT),
                      ('email5@gmail.com', 'nguyenvanE', N'Nguyễn Văn E', 1, 4, DEFAULT);

-- INSERT TABLE Group 
INSERT INTO `Group`(GroupName, CreatorID, CreateDate)
VALUES
					  ('GroupName1', 1, DEFAULT),
                      ('GroupName2', 2, DEFAULT),
                      ('GroupName3', 3, DEFAULT),
                      ('GroupName4', 3, DEFAULT),
                      ('GroupName5', 4, DEFAULT);

-- INSERT TABLE GroupAccount    GroupID AccountID  JoinDate
INSERT INTO GroupAccount(GroupID, AccountID, JoinDate)
VALUES
					  (1, 1, DEFAULT),
                      (2, 2, DEFAULT),
                      (3, 3, DEFAULT),
                      (3, 4, DEFAULT),
                      (5, 4, DEFAULT);

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
                      ('Category5');

-- INSERT TABLE Question  
INSERT INTO Question(Content, CategoryID, TypeID, CreatorID, CreateDate)
VALUES
					  ('Content1', 1, 1, 1, DEFAULT),
                      ('Content2', 2, 1, 2, DEFAULT),
                      ('Content3', 1, 2, 4, DEFAULT),
                      ('Content5', 4, 2, 3, DEFAULT),
                      ('Content4', 5, 2, 5, DEFAULT);

-- INSERT TABLE Answer  
INSERT INTO Answer(Content, QuestionID, isCorrect)
VALUES
					  ('Content1', 1, 1),
                      ('Content2', 2, 1),
                      ('Content3', 1, 0),
                      ('Content5', 4, 0),
                      ('Content4', 5, 1);

-- INSERT TABLE Exam  
INSERT INTO Exam(`Code`, Title, CategoryID, Duration, CreatorID, CreateDate)
VALUES
					  ('Code1', 'Title1', 1, 90, 1, DEFAULT),
                      ('Code2', 'Title2', 2, 90, 2, DEFAULT),
                      ('Code3', 'Title3', 3, 90, 4, DEFAULT),
                      ('Code4', 'Title4', 4, 90, 3, DEFAULT),
                      ('Code5', 'Title5', 5, 90, 5, DEFAULT);

-- INSERT TABLE ExamQuestion 
INSERT INTO ExamQuestion(ExamID, QuestionID)
VALUES
					  (1,2),
                      (1,3),
                      (3,4),
                      (2,3),
                      (4,5);







