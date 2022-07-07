USE UniversityDatabase
GO

BEGIN TRY
	BEGIN TRANSACTION

	DECLARE @CurrentUserId AS UNIQUEIDENTIFIER = NEWID()

	INSERT INTO [dbo].[Room] ([RoomId], [CreatedBy], [CreatedDateTime]) 
	VALUES 
		(22, @CurrentUserId, GETDATE()), 
		(23, @CurrentUserId, GETDATE()), 
		(24, @CurrentUserId, GETDATE())

	INSERT INTO [dbo].[CivilStatus] ([CivilStatusName], [DisplayName], [CreatedBy], [CreatedDateTime]) 
	VALUES 
		('single', 'Single', @CurrentUserId, GETDATE()),
		('married', 'Married', @CurrentUserId, GETDATE()), 
		('divorced', 'Divorced', @CurrentUserId, GETDATE())

	INSERT INTO [dbo].[Sex] ([SexName], [CreatedBy], [CreatedDateTime]) 
	VALUES 
		('male', @CurrentUserId, GETDATE()), 
		('female', @CurrentUserId, GETDATE())

	DECLARE @MaleId AS UNIQUEIDENTIFIER 
	DECLARE @FemaleId AS UNIQUEIDENTIFIER 
	SELECT @MaleId = [SexId] FROM [dbo].[Sex] WHERE [SexName] = 'male'
	SELECT @FemaleId = [SexId] FROM [dbo].[Sex] WHERE [SexName] = 'female'

	DECLARE @MarriedId AS UNIQUEIDENTIFIER 
	DECLARE @SingleId AS UNIQUEIDENTIFIER 
	SELECT @MarriedId = [CivilStatusId] FROM [dbo].[CivilStatus] WHERE [CivilStatusName] = 'married'
	SELECT @SingleId = [CivilStatusId] FROM [dbo].[CivilStatus] WHERE [CivilStatusName] = 'single'

	INSERT INTO [dbo].[Student] ([StudentCard], [FirstName], [LastName], [Middlename], [Birthday], [BirthPlace], [Address], [SexId], [CivilStatusId], [Room], [CreatedBy], [CreatedDateTime]) 
	VALUES 
		(N'KC �12029583', N'����', N'�����', N'���㳿���', '20050305 00:00:00 AM', N'�. ���', N'���. ��������, ���. 1, ��. 45', @FemaleId, @MarriedId, 22, @CurrentUserId, GETDATE()),
		(N'BC �12067704', N'����������', N'����', N'������������', '20060618 00:00:00 AM', N'�. ����', N'���. ����������, ���. 72', @FemaleId, @MarriedId, 22, @CurrentUserId, GETDATE()),
		(N'KB �11761526', N'������', N'����', N'�������', '20070912 00:00:00 AM', N'�. ����', N'���. ��������, ���. 30, ��. 10', @FemaleId, @SingleId, 23, @CurrentUserId, GETDATE()),
		(N'PB �13349080', N'����������', N'���������', N'�����������', '20070621 00:00:00 AM', N'�. г���', N'���. �������, ���. 250, �� 42', @MaleId, @SingleId, 24, @CurrentUserId, GETDATE())

	INSERT INTO [dbo].[Hobby] ([HobbyName], [CreatedBy], [CreatedDateTime])
	VALUES 
		('Reading', @CurrentUserId, GETDATE()),
		('Traveling', @CurrentUserId, GETDATE()),
		('Fishing', @CurrentUserId, GETDATE()),
		('Crafting', @CurrentUserId, GETDATE()),
		('Television', @CurrentUserId, GETDATE())

	INSERT INTO [dbo].[StudentHobby] (StudentId, HobbyId, [CreatedBy], [CreatedDateTime])
	VALUES 
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����'), (SELECT [HobbyId] FROM [dbo].[Hobby] WHERE [HobbyName] = 'Reading'), @CurrentUserId, GETDATE()),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����������'), (SELECT [HobbyId] FROM [dbo].[Hobby] WHERE [HobbyName] = 'Traveling'), @CurrentUserId, GETDATE()),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����������'), (SELECT [HobbyId] FROM [dbo].[Hobby] WHERE [HobbyName] = 'Fishing'), @CurrentUserId, GETDATE()),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'������'), (SELECT [HobbyId] FROM [dbo].[Hobby] WHERE [HobbyName] = 'Traveling'), @CurrentUserId, GETDATE()),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'������'), (SELECT [HobbyId] FROM [dbo].[Hobby] WHERE [HobbyName] = 'Fishing'), @CurrentUserId, GETDATE()),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'������'), (SELECT [HobbyId] FROM [dbo].[Hobby] WHERE [HobbyName] = 'Crafting'), @CurrentUserId, GETDATE()),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����������'), (SELECT [HobbyId] FROM [dbo].[Hobby] WHERE [HobbyName] = 'Crafting'), @CurrentUserId, GETDATE()),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����������'), (SELECT [HobbyId] FROM [dbo].[Hobby] WHERE [HobbyName] = 'Television'), @CurrentUserId, GETDATE())

	INSERT INTO [dbo].[Book] ([Title], [Author], [Genre], [Isbn], [Price], [CreatedBy], [CreatedDateTime])
	Values
		('The Hobbit', 'J. R. R. Tolkien', 'Fantasy', '9780007487301', '100', @CurrentUserId, GETDATE()),
		('The Hobbit', 'J. R. R. Tolkien', 'Fantasy', '9780007487301', '100', @CurrentUserId, GETDATE()),
		('The Hobbit', 'J. R. R. Tolkien', 'Fantasy', '9780007487301', '100', @CurrentUserId, GETDATE()),
		('The Godfather', '	Mario Puzo', '	Crime novel', '9780099528128', '150', @CurrentUserId, GETDATE()),
		('The Godfather', '	Mario Puzo', '	Crime novel', '9780099528128', '150', @CurrentUserId, GETDATE()),
		('The Godfather', '	Mario Puzo', '	Crime novel', '9780099528128', '150', @CurrentUserId, GETDATE()),
		('Nineteen Eighty-Four', 'George Orwell', 'Dystopian, political fiction, social science fiction', '978-0-141-18776-1', '250', @CurrentUserId, GETDATE()),
		('Nineteen Eighty-Four', 'George Orwell', 'Dystopian, political fiction, social science fiction', '978-0-141-18776-1', '250', @CurrentUserId, GETDATE()),
		('Dune', 'Frank Herbert', 'Science fiction novel', '9780340960196', '90', @CurrentUserId, GETDATE()),
		('Dune', 'Frank Herbert', 'Science fiction novel', '9780340960196', '90', @CurrentUserId, GETDATE()),
		('Dune', 'Frank Herbert', 'Science fiction novel', '9780340960196', '90', @CurrentUserId, GETDATE()),
		('Dune', 'Frank Herbert', 'Science fiction novel', '9780340960196', '90', @CurrentUserId, GETDATE())

	DECLARE @BookIds TABLE
	(
	   [Row] INT,
	   [BookId] UNIQUEIDENTIFIER
	);
	SELECT ROW_NUMBER() OVER(ORDER BY [Title]) AS 'Row', [BookId] INTO BookIds FROM [dbo].[Book]

	INSERT INTO [dbo].[LendedBook] ([StudentId], [BookId], [IsReturned], [CreatedBy], [CreatedDateTime])
	VALUES
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����'), (SELECT [BookId] FROM [dbo].[BookIds] WHERE Row = 2), 0, @CurrentUserId, GETDATE()),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����'), (SELECT [BookId] FROM [dbo].[BookIds] WHERE Row = 7), 0, @CurrentUserId, GETDATE()),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����������'), (SELECT [BookId] FROM [dbo].[BookIds] WHERE Row = 8), 0, @CurrentUserId, GETDATE()),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����������'), (SELECT [BookId] FROM [dbo].[BookIds] WHERE Row = 10), 0, @CurrentUserId, GETDATE()),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'������'), (SELECT [BookId] FROM [dbo].[BookIds] WHERE Row = 5), 0, @CurrentUserId, GETDATE())
	
	DROP TABLE BookIds;

	INSERT INTO [dbo].[AcademicDiscipline] ([DisciplineName], [CreatedBy], [CreatedDateTime])
	VALUES
		(N'��������� ���� �� ���������', @CurrentUserId, GETDATE()),
		(N'����������', @CurrentUserId, GETDATE()),
		(N'���������', @CurrentUserId, GETDATE())

	INSERT INTO [dbo].[Lecturer] ([LecturerName], [CreatedBy], [CreatedDateTime])
	VALUES
		(N'��������� �����������', @CurrentUserId, GETDATE()),
		(N'������� ���������', @CurrentUserId, GETDATE()),
		(N'���� �������', @CurrentUserId, GETDATE())

	INSERT INTO [dbo].[Group] ([GroupName], [GroupLeaderId], [CreatedBy], [CreatedDateTime])
	VALUES
		(N'ϲ-21', (SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����'), @CurrentUserId, GETDATE()),
		(N'��-11', NULL, @CurrentUserId, GETDATE())

	INSERT INTO [dbo].[GroupDiscipline] ([GroupId], [DisciplineId], [LecturerId], [CreatedBy], [CreatedDateTime])
	VALUES
		(
			(SELECT [GroupId] FROM [dbo].[Group] WHERE [GroupName] = N'ϲ-21'),
			(SELECT [AcademicDisciplineId] FROM [dbo].[AcademicDiscipline] WHERE [DisciplineName] = N'��������� ���� �� ���������'),
			(SELECT [LecturerId] FROM [dbo].[Lecturer] WHERE [LecturerName] = N'��������� �����������'),
			@CurrentUserId,
			GETDATE()
		),
		(
			(SELECT [GroupId] FROM [dbo].[Group] WHERE [GroupName] = N'ϲ-21'),
			(SELECT [AcademicDisciplineId] FROM [dbo].[AcademicDiscipline] WHERE [DisciplineName] = N'����������'),
			(SELECT [LecturerId] FROM [dbo].Lecturer WHERE LecturerName = N'������� ���������'),
			@CurrentUserId,
			GETDATE()
		),
		(
			(SELECT [GroupId] FROM [dbo].[Group] WHERE [GroupName] = N'��-11'),
			(SELECT [AcademicDisciplineId] FROM [dbo].[AcademicDiscipline] WHERE [DisciplineName] = N'���������'),
			(SELECT [LecturerId] FROM [dbo].Lecturer WHERE [LecturerName] = N'���� �������'),
			@CurrentUserId,
			GETDATE()
		)

	INSERT INTO [dbo].[Grade] ([StudentId], [GroupDisciplineId], [Grade], [StateGrade], [CreatedBy], [CreatedDateTime])
	VALUES
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'����������'),
			5,
			0,
			@CurrentUserId,
			GETDATE()
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'����������'),
			4,
			0,
			@CurrentUserId,
			GETDATE()
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'��������� ���� �� ���������'),
			5,
			0,
			@CurrentUserId,
			GETDATE()
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����������'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'����������'),
			3,
			0,
			@CurrentUserId,
			GETDATE()
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����������'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'��������� ���� �� ���������'),
			2,
			0,
			@CurrentUserId,
			GETDATE()
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����������'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'��������� ���� �� ���������'),
			4,
			0,
			@CurrentUserId,
			GETDATE()
		)

	INSERT INTO [dbo].[StudentRating] ([StudentId], [StudentRating], [StipendSumm],  [CreatedBy], [CreatedDateTime])
	VALUES 
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����'), 4.5, 1000, @CurrentUserId, GETDATE()),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����������'), 4, 1000, @CurrentUserId, GETDATE()),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'������'), 5, 1500, @CurrentUserId, GETDATE()),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'����������'), 3, 1000, @CurrentUserId, GETDATE())

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION;

	SELECT 
		ERROR_NUMBER() AS ErrorNumber, 
		ERROR_SEVERITY() AS ErrorSeverity, 
		ERROR_STATE() AS ErrorState, 
		ERROR_PROCEDURE() AS ErrorProcedure, 
		ERROR_LINE() AS ErrorLine, 
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH
