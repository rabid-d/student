IF DB_ID('UniversityDatabase') IS NULL
BEGIN
	CREATE DATABASE UniversityDatabase;
END
GO

USE UniversityDatabase
GO

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'Room')
Begin
	CREATE TABLE [dbo].[Room] (
		[RoomId] int NOT NULL,

		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDateTime] DATETIME NULL,
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,
		[CreatedDateTime] DATETIME NOT NULL,
	)
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'PK_Room')
Begin
	ALTER TABLE [dbo].[Room]
	ADD CONSTRAINT [PK_Room] PRIMARY KEY ([RoomId])
END



IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'CivilStatus')
Begin
	CREATE TABLE [dbo].[CivilStatus] (
		[CivilStatusId] UNIQUEIDENTIFIER NOT NULL,
		[CivilStatusName] NVARCHAR(128) NOT NULL,
		[DisplayName] NVARCHAR(50) NOT NULL,

		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDateTime] DATETIME NULL,
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,
		[CreatedDateTime] DATETIME NOT NULL,
	)
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'PK_CivilStatus')
Begin
	ALTER TABLE [dbo].[CivilStatus]
	ADD CONSTRAINT [PK_CivilStatus] PRIMARY KEY ([CivilStatusId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'DF_CivilStatus_CivilStatusId')
Begin
	ALTER TABLE [dbo].[CivilStatus]
	ADD CONSTRAINT [DF_CivilStatus_CivilStatusId] DEFAULT (NEWID()) FOR [CivilStatusId]
END



IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'Sex')
Begin
	CREATE TABLE [dbo].[Sex] (
		[SexId] UNIQUEIDENTIFIER NOT NULL,
		[SexName] NVARCHAR(64) NOT NULL,

		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDateTime] DATETIME NULL,
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,
		[CreatedDateTime] DATETIME NOT NULL,
	)
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'PK_Sex')
Begin
	ALTER TABLE [dbo].[Sex]
	ADD CONSTRAINT [PK_Sex] PRIMARY KEY ([SexId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'DF_Sex_SexId')
Begin
	ALTER TABLE [dbo].[Sex]
	ADD CONSTRAINT [DF_Sex_SexId] DEFAULT (NEWID()) FOR [SexId]
END



IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'Student')
Begin
	CREATE TABLE [dbo].[Student] (
		[StudentId] UNIQUEIDENTIFIER NOT NULL,
		[StudentCard] NVARCHAR(32) NOT NULL,
		[FirstName] NVARCHAR(128) NULL,
		[LastName] NVARCHAR(128) NOT NULL,
		[Middlename] NVARCHAR(128),
		[Birthday] DATETIME NOT NULL,
		[BirthPlace] NVARCHAR(256) NOT NULL,
		[Address] NVARCHAR(256) NULL,
		[SexId] UNIQUEIDENTIFIER NULL,
		[CivilStatusId] UNIQUEIDENTIFIER NOT NULL,
		[Room] INT NULL,
		[CurrentGroupId] UNIQUEIDENTIFIER NULL,

		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDateTime] DATETIME NULL,
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,
		[CreatedDateTime] DATETIME NOT NULL,
	)
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'PK_Student')
Begin
	ALTER TABLE [dbo].[Student]
	ADD CONSTRAINT [PK_Student] PRIMARY KEY ([StudentId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'DF_Student_StudentId')
Begin
	ALTER TABLE [dbo].[Student]
	ADD CONSTRAINT [DF_Student_StudentId] DEFAULT (NEWID()) FOR [StudentId]
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'FK_Student_Sex')
Begin
	ALTER TABLE [dbo].[Student]
	ADD CONSTRAINT [FK_Student_Sex] FOREIGN KEY ([SexId]) REFERENCES [dbo].[Sex] ([SexId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'FK_Student_Room')
Begin
	ALTER TABLE [dbo].[Student]
	ADD CONSTRAINT [FK_Student_Room] FOREIGN KEY ([Room]) REFERENCES [dbo].[Room] ([RoomId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'FK_Student_CivilStatus')
Begin
	ALTER TABLE [dbo].[Student]
	ADD CONSTRAINT [FK_Student_CivilStatus] FOREIGN KEY (CivilStatusId) REFERENCES [dbo].[CivilStatus] ([CivilStatusId])
END



IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'Hobby')
Begin
	CREATE TABLE [dbo].[Hobby] (
		[HobbyId] UNIQUEIDENTIFIER NOT NULL,
		[HobbyName] NVARCHAR(256) NOT NULL,

		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDateTime] DATETIME NULL,
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,
		[CreatedDateTime] DATETIME NOT NULL,
	)
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'PK_Hobby')
Begin
	ALTER TABLE [dbo].[Hobby]
	ADD CONSTRAINT [PK_Hobby] PRIMARY KEY ([HobbyId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'DF_Hobby_HobbyId')
Begin
	ALTER TABLE [dbo].[Hobby]
	ADD CONSTRAINT [DF_Hobby_HobbyId] DEFAULT (NEWID()) FOR [HobbyId]
END



IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'StudentHobby')
Begin
	CREATE TABLE [dbo].[StudentHobby] (
		[StudentHobbyId] UNIQUEIDENTIFIER NOT NULL,
		[StudentId] UNIQUEIDENTIFIER NOT NULL,
		[HobbyId] UNIQUEIDENTIFIER NOT NULL,

		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDateTime] DATETIME NULL,
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,
		[CreatedDateTime] DATETIME NOT NULL,
	)
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'PK_student_hobby')
Begin
	ALTER TABLE [dbo].[StudentHobby]
	ADD CONSTRAINT [PK_student_hobby] PRIMARY KEY ([StudentHobbyId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'DF_StudentHobby_StudentHobbyId')
Begin
	ALTER TABLE [dbo].[StudentHobby]
	ADD CONSTRAINT [DF_StudentHobby_StudentHobbyId] DEFAULT (NEWID()) FOR [StudentHobbyId]
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'FK_StudentHobby_Student')
Begin
	ALTER TABLE [dbo].[StudentHobby]
	ADD CONSTRAINT [FK_StudentHobby_Student] FOREIGN KEY ([StudentId]) REFERENCES [dbo].[Student] ([StudentId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'FK_StudentHobby_Hobby')
Begin
	ALTER TABLE [dbo].[StudentHobby]
	ADD CONSTRAINT [FK_StudentHobby_Hobby] FOREIGN KEY (HobbyId) REFERENCES [dbo].[Hobby] ([HobbyId])
END



IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'StudentRating')
Begin
	CREATE TABLE [dbo].[StudentRating] (
		[StudentRatingId] UNIQUEIDENTIFIER NOT NULL,
		[StudentId] UNIQUEIDENTIFIER NOT NULL,
		[StudentRating] FLOAT NOT NULL,
		[StipendSumm] MONEY NOT NULL,
		[AcademicTerm] INT NOT NULL,
		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDateTime] DATETIME NULL,
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,
		[CreatedDateTime] DATETIME NOT NULL,
	)
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'PK_StudentRating')
Begin
	ALTER TABLE [dbo].[StudentRating]
	ADD CONSTRAINT [PK_StudentRating] PRIMARY KEY ([StudentRatingId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'DF_StudentRating_StudentRatingId')
Begin
	ALTER TABLE [dbo].[StudentRating]
	ADD CONSTRAINT [DF_StudentRating_StudentRatingId] DEFAULT (NEWID()) FOR [StudentRatingId]
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'FK_StudentRating_Student')
Begin
	ALTER TABLE [dbo].[StudentRating]
	ADD CONSTRAINT [FK_StudentRating_Student] FOREIGN KEY ([StudentId]) REFERENCES [dbo].[Student] ([StudentId])
END



IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'Book')
Begin
	CREATE TABLE [dbo].[Book] (
		[BookId] UNIQUEIDENTIFIER NOT NULL,
		[Title] NVARCHAR(256) NOT NULL,
		[Author] NVARCHAR(256) NOT NULL,
		[Genre] NVARCHAR(128) NOT NULL,
		[Isbn] NVARCHAR(50) NOT NULL,
		[Price] MONEY NULL,

		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDateTime] DATETIME NULL,
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,
		[CreatedDateTime] DATETIME NOT NULL,
	)
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'PK_Book')
Begin
	ALTER TABLE [dbo].[Book]
	ADD CONSTRAINT [PK_Book] PRIMARY KEY ([BookId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'DF_Book_BookId')
Begin
	ALTER TABLE [dbo].[Book]
	ADD CONSTRAINT [DF_Book_BookId] DEFAULT (NEWID()) FOR [BookId]
END



IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'LendedBook')
Begin
	CREATE TABLE [dbo].[LendedBook] (
		[LendedBookId] UNIQUEIDENTIFIER NOT NULL,
		[StudentId] UNIQUEIDENTIFIER NOT NULL,
		[BookId] UNIQUEIDENTIFIER NOT NULL,
		[IsReturned] BIT NOT NULL,

		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDateTime] DATETIME NULL,
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,
		[CreatedDateTime] DATETIME NOT NULL,
	)
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'PK_LendedBook')
Begin
	ALTER TABLE [dbo].[LendedBook]
	ADD CONSTRAINT [PK_LendedBook] PRIMARY KEY ([LendedBookId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'DF_LendedBook_LendedBookId')
Begin
	ALTER TABLE [dbo].[LendedBook]
	ADD CONSTRAINT [DF_LendedBook_LendedBookId] DEFAULT (NEWID()) FOR [LendedBookId]
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'FK_LendedBook_Student')
Begin
	ALTER TABLE [dbo].[LendedBook]
	ADD CONSTRAINT [FK_LendedBook_Student] FOREIGN KEY ([StudentId]) REFERENCES [dbo].[Student] ([StudentId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'FK_LendedBook_Book')
Begin
	ALTER TABLE [dbo].[LendedBook]
	ADD CONSTRAINT [FK_LendedBook_Book] FOREIGN KEY ([BookId]) REFERENCES [dbo].[Book] ([BookId])
END



IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'Group')
Begin
	CREATE TABLE [dbo].[Group] (
		[GroupId] UNIQUEIDENTIFIER NOT NULL,
		[GroupName] NVARCHAR(64) NOT NULL,
		[GroupLeaderId] UNIQUEIDENTIFIER NULL,

		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDateTime] DATETIME NULL,
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,
		[CreatedDateTime] DATETIME NOT NULL,
	)
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'PK_Group')
Begin
	ALTER TABLE [dbo].[Group]
	ADD CONSTRAINT [PK_Group] PRIMARY KEY ([GroupId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'DF_Group_GroupId')
Begin
	ALTER TABLE [dbo].[Group]
	ADD CONSTRAINT [DF_Group_GroupId] DEFAULT (NEWID()) FOR [GroupId]
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'FK_Group_Student')
Begin
	ALTER TABLE [dbo].[Group]
	ADD CONSTRAINT [FK_Group_Student] FOREIGN KEY ([GroupLeaderId]) REFERENCES [dbo].[Student] ([StudentId])
END



IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'AcademicDiscipline')
Begin
	CREATE TABLE [dbo].[AcademicDiscipline] (
		[AcademicDisciplineId] UNIQUEIDENTIFIER NOT NULL,
		[DisciplineName] NVARCHAR(256) NOT NULL,

		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDateTime] DATETIME NULL,
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,
		[CreatedDateTime] DATETIME NOT NULL,
	)
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'PK_AcademicDiscipline')
Begin
	ALTER TABLE [dbo].[AcademicDiscipline]
	ADD CONSTRAINT [PK_AcademicDiscipline] PRIMARY KEY ([AcademicDisciplineId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'DF_AcademicDiscipline_AcademicDisciplineId')
Begin
	ALTER TABLE [dbo].[AcademicDiscipline]
	ADD CONSTRAINT [DF_AcademicDiscipline_AcademicDisciplineId] DEFAULT (NEWID()) FOR [AcademicDisciplineId]
END



IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'Lecturer')
Begin
	CREATE TABLE [dbo].[Lecturer] (
		[LecturerId] UNIQUEIDENTIFIER NOT NULL,
		[LecturerName] NVARCHAR(256) NOT NULL,

		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDateTime] DATETIME NULL,
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,
		[CreatedDateTime] DATETIME NOT NULL,
	)
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'PK_Lecturer')
Begin
	ALTER TABLE [dbo].[Lecturer]
	ADD CONSTRAINT [PK_Lecturer] PRIMARY KEY ([LecturerId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'DF_Lecturer_LecturerId')
Begin
	ALTER TABLE [dbo].[Lecturer]
	ADD CONSTRAINT [DF_Lecturer_LecturerId] DEFAULT (NEWID()) FOR [LecturerId]
END



IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'GroupDiscipline')
Begin
	CREATE TABLE [dbo].[GroupDiscipline] (
		[GroupDisciplineId] UNIQUEIDENTIFIER NOT NULL,
		[GroupId] UNIQUEIDENTIFIER NOT NULL,
		[DisciplineId] UNIQUEIDENTIFIER NOT NULL,
		[LecturerId] UNIQUEIDENTIFIER NOT NULL,

		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDateTime] DATETIME NULL,
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,
		[CreatedDateTime] DATETIME NOT NULL,
	)
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'PK_GroupDiscipline')
Begin
	ALTER TABLE [dbo].[GroupDiscipline]
	ADD CONSTRAINT [PK_GroupDiscipline] PRIMARY KEY ([GroupDisciplineId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'DF_GroupDiscipline_GroupDisciplineId')
Begin
	ALTER TABLE [dbo].[GroupDiscipline]
	ADD CONSTRAINT [DF_GroupDiscipline_GroupDisciplineId] DEFAULT (NEWID()) FOR [GroupDisciplineId]
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'FK_GroupDiscipline_Group')
Begin
	ALTER TABLE [dbo].[GroupDiscipline]
	ADD CONSTRAINT [FK_GroupDiscipline_Group] FOREIGN KEY ([GroupId]) REFERENCES [dbo].[Group] ([GroupId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'FK_GroupDiscipline_AcademicDiscipline')
Begin
	ALTER TABLE [dbo].[GroupDiscipline]
	ADD CONSTRAINT [FK_GroupDiscipline_AcademicDiscipline] FOREIGN KEY ([DisciplineId]) REFERENCES dbo.[AcademicDiscipline] ([AcademicDisciplineId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'FK_GroupDiscipline_Lecturer')
Begin
	ALTER TABLE [dbo].[GroupDiscipline]
	ADD CONSTRAINT [FK_GroupDiscipline_Lecturer] FOREIGN KEY ([LecturerId]) REFERENCES dbo.[Lecturer] ([LecturerId])
END



IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'Grade' AND type = 'U')
Begin
	CREATE TABLE [dbo].[Grade] (
		[GradeId] UNIQUEIDENTIFIER NOT NULL,
		[StudentId] UNIQUEIDENTIFIER NOT NULL,
		[GroupDisciplineId] UNIQUEIDENTIFIER NOT NULL,
		[Grade] INT NOT NULL,
		[StateGrade] BIT NOT NULL,

		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDateTime] DATETIME NULL,
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,
		[CreatedDateTime] DATETIME NOT NULL,
	)
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'PK_Grade' AND type = 'PK')
Begin
	ALTER TABLE [dbo].[Grade]
	ADD CONSTRAINT [PK_Grade] PRIMARY KEY ([GradeId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'DF_Grade_GradeId')
Begin
	ALTER TABLE [dbo].[Grade]
	ADD CONSTRAINT [DF_Grade_GradeId] DEFAULT (NEWID()) FOR [GradeId]
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'FK_Grade_Student' AND type = 'F')
Begin
	ALTER TABLE [dbo].[Grade]
	ADD CONSTRAINT [FK_Grade_Student] FOREIGN KEY ([StudentId]) REFERENCES dbo.[Student] ([StudentId])
END

IF NOT EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'FK_Grade_GroupDiscipline' AND type = 'F')
Begin
	ALTER TABLE [dbo].[Grade]
	ADD CONSTRAINT [FK_Grade_GroupDiscipline] FOREIGN KEY ([GroupDisciplineId]) REFERENCES [dbo].[GroupDiscipline] ([GroupDisciplineId])
END



IF EXISTS(SELECT * FROM SYS.OBJECTS WHERE [Name] = 'LendedBook')
Begin
	ALTER TABLE [dbo].[LendedBook]
	ADD [ReturnDate] DATETIME NULL
END
