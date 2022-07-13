USE UniversityDatabase
GO

BEGIN TRY
	BEGIN TRANSACTION

	DECLARE @CurrentUserId AS UNIQUEIDENTIFIER = NEWID()
	DECLARE @CurrentDate AS DATETIME = GETDATE()

	INSERT INTO [dbo].[Room] ([RoomId], [CreatedBy], [CreatedDateTime]) 
	VALUES 
		(22, @CurrentUserId, @CurrentDate), 
		(23, @CurrentUserId, @CurrentDate), 
		(24, @CurrentUserId, @CurrentDate)

	INSERT INTO [dbo].[CivilStatus] ([CivilStatusName], [DisplayName], [CreatedBy], [CreatedDateTime]) 
	VALUES 
		('single', 'Single', @CurrentUserId, @CurrentDate),
		('married', 'Married', @CurrentUserId, @CurrentDate), 
		('divorced', 'Divorced', @CurrentUserId, @CurrentDate)

	INSERT INTO [dbo].[Sex] ([SexName], [CreatedBy], [CreatedDateTime]) 
	VALUES 
		('male', @CurrentUserId, @CurrentDate), 
		('female', @CurrentUserId, @CurrentDate)

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
		(N'KC №12029583', N'Іщук', N'Олена', N'Сергіївна', '20050305 00:00:00 AM', N'м. Київ', N'вул. Хрещатик, буд. 1, кв. 45', @FemaleId, @MarriedId, 22, @CurrentUserId, @CurrentDate),
		(N'BC №12067704', N'Тороканець', N'Неля', N'Олександрівна', '20060618 00:00:00 AM', N'м. Львів', N'вул. Городоцька, буд. 72', @FemaleId, @MarriedId, 22, @CurrentUserId, @CurrentDate),
		(N'KB №11761526', N'Браїлко', N'Марія', N'Ігорівна', '20070912 00:00:00 AM', N'м. Львів', N'вул. Шевченка, буд. 30, кв. 10', @FemaleId, @SingleId, 23, @CurrentUserId, @CurrentDate),
		(N'PB №13349080', N'Красицький', N'Олександр', N'Геннадійович', '20070621 00:00:00 AM', N'м. Рівне', N'вул. Соборна, буд. 250, кв 42', @MaleId, @SingleId, 24, @CurrentUserId, @CurrentDate)

	INSERT INTO [dbo].[Hobby] ([HobbyName], [CreatedBy], [CreatedDateTime])
	VALUES 
		('Reading', @CurrentUserId, @CurrentDate),
		('Traveling', @CurrentUserId, @CurrentDate),
		('Fishing', @CurrentUserId, @CurrentDate),
		('Crafting', @CurrentUserId, @CurrentDate),
		('Television', @CurrentUserId, @CurrentDate)

	INSERT INTO [dbo].[StudentHobby] (StudentId, HobbyId, [CreatedBy], [CreatedDateTime])
	VALUES 
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Іщук'), (SELECT [HobbyId] FROM [dbo].[Hobby] WHERE [HobbyName] = 'Reading'), @CurrentUserId, @CurrentDate),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), (SELECT [HobbyId] FROM [dbo].[Hobby] WHERE [HobbyName] = 'Traveling'), @CurrentUserId, @CurrentDate),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), (SELECT [HobbyId] FROM [dbo].[Hobby] WHERE [HobbyName] = 'Fishing'), @CurrentUserId, @CurrentDate),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Браїлко'), (SELECT [HobbyId] FROM [dbo].[Hobby] WHERE [HobbyName] = 'Traveling'), @CurrentUserId, @CurrentDate),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Браїлко'), (SELECT [HobbyId] FROM [dbo].[Hobby] WHERE [HobbyName] = 'Fishing'), @CurrentUserId, @CurrentDate),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Браїлко'), (SELECT [HobbyId] FROM [dbo].[Hobby] WHERE [HobbyName] = 'Crafting'), @CurrentUserId, @CurrentDate),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Красицький'), (SELECT [HobbyId] FROM [dbo].[Hobby] WHERE [HobbyName] = 'Crafting'), @CurrentUserId, @CurrentDate),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Красицький'), (SELECT [HobbyId] FROM [dbo].[Hobby] WHERE [HobbyName] = 'Television'), @CurrentUserId, @CurrentDate)

	INSERT INTO [dbo].[Book] ([Title], [Author], [Genre], [Isbn], [Price], [CreatedBy], [CreatedDateTime])
	Values
		('The Hobbit', 'J. R. R. Tolkien', 'Fantasy', '9780007487301', '100', @CurrentUserId, @CurrentDate),
		('The Hobbit', 'J. R. R. Tolkien', 'Fantasy', '9780007487301', '100', @CurrentUserId, @CurrentDate),
		('The Hobbit', 'J. R. R. Tolkien', 'Fantasy', '9780007487301', '100', @CurrentUserId, @CurrentDate),
		('The Godfather', '	Mario Puzo', '	Crime novel', '9780099528128', '150', @CurrentUserId, @CurrentDate),
		('The Godfather', '	Mario Puzo', '	Crime novel', '9780099528128', '150', @CurrentUserId, @CurrentDate),
		('The Godfather', '	Mario Puzo', '	Crime novel', '9780099528128', '150', @CurrentUserId, @CurrentDate),
		('Nineteen Eighty-Four', 'George Orwell', 'Dystopian, political fiction, social science fiction', '978-0-141-18776-1', '250', @CurrentUserId, @CurrentDate),
		('Nineteen Eighty-Four', 'George Orwell', 'Dystopian, political fiction, social science fiction', '978-0-141-18776-1', '250', @CurrentUserId, @CurrentDate),
		('Dune', 'Frank Herbert', 'Science fiction novel', '9780340960196', '90', @CurrentUserId, @CurrentDate),
		('Dune', 'Frank Herbert', 'Science fiction novel', '9780340960196', '90', @CurrentUserId, @CurrentDate),
		('Dune', 'Frank Herbert', 'Science fiction novel', '9780340960196', '90', @CurrentUserId, @CurrentDate),
		('Dune', 'Frank Herbert', 'Science fiction novel', '9780340960196', '90', @CurrentUserId, @CurrentDate)

	DECLARE @BookIds TABLE
	(
	   [Row] INT,
	   [BookId] UNIQUEIDENTIFIER
	);
	SELECT ROW_NUMBER() OVER(ORDER BY [Title]) AS 'Row', [BookId] INTO BookIds FROM [dbo].[Book]

	INSERT INTO [dbo].[LendedBook] ([StudentId], [BookId], [IsReturned], [CreatedBy], [CreatedDateTime])
	VALUES
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Іщук'), (SELECT [BookId] FROM [dbo].[BookIds] WHERE Row = 2), 0, @CurrentUserId, '2022-04-05 12:30:23'),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Іщук'), (SELECT [BookId] FROM [dbo].[BookIds] WHERE Row = 7), 0, @CurrentUserId, '2021-08-01 16:48:58'),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), (SELECT [BookId] FROM [dbo].[BookIds] WHERE Row = 8), 0, @CurrentUserId, '2021-09-01 10:54:43'),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), (SELECT [BookId] FROM [dbo].[BookIds] WHERE Row = 10), 0, @CurrentUserId, '2021-09-01 10:54:55'),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Браїлко'), (SELECT [BookId] FROM [dbo].[BookIds] WHERE Row = 5), 0, @CurrentUserId, '2022-06-06 12:13:42')

	DROP TABLE BookIds;

	INSERT INTO [dbo].[AcademicDiscipline] ([DisciplineName], [CreatedBy], [CreatedDateTime])
	VALUES
		(N'Українська мова та література', @CurrentUserId, @CurrentDate),
		(N'Математика', @CurrentUserId, @CurrentDate),
		(N'Географія', @CurrentUserId, @CurrentDate)

	INSERT INTO [dbo].[Lecturer] ([LecturerName], [CreatedBy], [CreatedDateTime])
	VALUES
		(N'Володимир Вернадський', @CurrentUserId, @CurrentDate),
		(N'Григорій Сковорода', @CurrentUserId, @CurrentDate),
		(N'Леся Українка', @CurrentUserId, @CurrentDate)

	INSERT INTO [dbo].[Group] ([GroupName], [GroupLeaderId], [CreatedBy], [CreatedDateTime])
	VALUES
		(N'ПІ-21', (SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Іщук'), @CurrentUserId, @CurrentDate),
		(N'МК-11', NULL, @CurrentUserId, @CurrentDate)

	UPDATE [dbo].[Student] SET [CurrentGroupId] = (SELECT [GroupId] FROM [dbo].[Group] WHERE [GroupName]= N'ПІ-21') WHERE [FirstName] = N'Іщук'
	UPDATE [dbo].[Student] SET [CurrentGroupId] = (SELECT [GroupId] FROM [dbo].[Group] WHERE [GroupName]= N'ПІ-21') WHERE [FirstName] = N'Тороканець'
	UPDATE [dbo].[Student] SET [CurrentGroupId] = (SELECT [GroupId] FROM [dbo].[Group] WHERE [GroupName]= N'МК-11') WHERE [FirstName] = N'Браїлко'
	UPDATE [dbo].[Student] SET [CurrentGroupId] = (SELECT [GroupId] FROM [dbo].[Group] WHERE [GroupName]= N'МК-11') WHERE [FirstName] = N'Красицький'

	INSERT INTO [dbo].[GroupDiscipline] ([GroupId], [DisciplineId], [LecturerId], [CreatedBy], [CreatedDateTime])
	VALUES
		(
			(SELECT [GroupId] FROM [dbo].[Group] WHERE [GroupName] = N'ПІ-21'),
			(SELECT [AcademicDisciplineId] FROM [dbo].[AcademicDiscipline] WHERE [DisciplineName] = N'Українська мова та література'),
			(SELECT [LecturerId] FROM [dbo].[Lecturer] WHERE [LecturerName] = N'Володимир Вернадський'),
			@CurrentUserId,
			@CurrentDate
		),
		(
			(SELECT [GroupId] FROM [dbo].[Group] WHERE [GroupName] = N'ПІ-21'),
			(SELECT [AcademicDisciplineId] FROM [dbo].[AcademicDiscipline] WHERE [DisciplineName] = N'Математика'),
			(SELECT [LecturerId] FROM [dbo].Lecturer WHERE LecturerName = N'Григорій Сковорода'),
			@CurrentUserId,
			@CurrentDate
		),
		(
			(SELECT [GroupId] FROM [dbo].[Group] WHERE [GroupName] = N'МК-11'),
			(SELECT [AcademicDisciplineId] FROM [dbo].[AcademicDiscipline] WHERE [DisciplineName] = N'Географія'),
			(SELECT [LecturerId] FROM [dbo].Lecturer WHERE [LecturerName] = N'Леся Українка'),
			@CurrentUserId,
			@CurrentDate
		)

	INSERT INTO [dbo].[Grade] ([StudentId], [GroupDisciplineId], [Grade], [StateGrade], [CreatedBy], [CreatedDateTime])
	VALUES
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Іщук'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Математика'),
			5,
			0,
			@CurrentUserId,
			'2021-09-01 11:04:59'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Іщук'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Математика'),
			4,
			0,
			@CurrentUserId,
			'2021-10-11 15:25:31'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Іщук'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Математика'),
			4,
			1,
			@CurrentUserId,
			'2021-12-09 09:25:12'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Іщук'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Математика'),
			3,
			0,
			@CurrentUserId,
			'2022-01-20 15:13:41'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Іщук'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Математика'),
			4,
			0,
			@CurrentUserId,
			'2022-03-11 11:43:52'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Іщук'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Математика'),
			4,
			1,
			@CurrentUserId,
			'2022-05-03 10:16:22'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Іщук'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Українська мова та література'),
			5,
			0,
			@CurrentUserId,
			'2021-09-16 12:12:55'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Іщук'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Українська мова та література'),
			2,
			0,
			@CurrentUserId,
			'2021-10-15 12:12:55'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Іщук'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Українська мова та література'),
			3,
			1,
			@CurrentUserId,
			'2021-12-15 12:12:55'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Іщук'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Українська мова та література'),
			4,
			0,
			@CurrentUserId,
			'2022-01-16 12:12:55'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Іщук'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Українська мова та література'),
			4,
			1,
			@CurrentUserId,
			'2022-03-15 12:12:55'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Математика'),
			3,
			0,
			@CurrentUserId,
			'2021-09-16 12:12:55'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Математика'),
			3,
			0,
			@CurrentUserId,
			'2021-10-16 12:12:55'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Математика'),
			3,
			1,
			@CurrentUserId,
			'2021-12-16 12:12:55'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Математика'),
			3,
			0,
			@CurrentUserId,
			'2022-01-16 12:12:55'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Математика'),
			3,
			0,
			@CurrentUserId,
			'2022-02-16 12:12:55'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Математика'),
			4,
			1,
			@CurrentUserId,
			'2022-05-16 12:12:55'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Українська мова та література'),
			2,
			0,
			@CurrentUserId,
			'2021-09-16 12:12:55'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Українська мова та література'),
			4,
			0,
			@CurrentUserId,
			'2021-10-16 12:12:55'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Українська мова та література'),
			4,
			1,
			@CurrentUserId,
			'2021-12-16 12:12:55'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Українська мова та література'),
			3,
			0,
			@CurrentUserId,
			'2022-01-16 12:12:55'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Українська мова та література'),
			4,
			0,
			@CurrentUserId,
			'2022-03-16 12:12:55'
		),
		(
			(SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), 
			(SELECT [GroupDisciplineId] FROM [GroupDiscipline] JOIN [AcademicDiscipline] ON [DisciplineId] = [AcademicDisciplineId] WHERE [DisciplineName] = N'Українська мова та література'),
			5,
			1,
			@CurrentUserId,
			'2022-04-16 12:12:55'
		)

	INSERT INTO [dbo].[StudentRating] ([StudentId], [StudentRating], [StipendSumm], [AcademicTerm], [CreatedBy], [CreatedDateTime])
	VALUES 
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Іщук'), 3.5, 0, 1, @CurrentUserId, @CurrentDate),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Іщук'), 4, 1000, 2, @CurrentUserId, @CurrentDate),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), 3.5, 0, 1, @CurrentUserId, @CurrentDate),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Тороканець'), 4.5, 1000, 2,  @CurrentUserId, @CurrentDate),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Браїлко'), 5, 1500, 1, @CurrentUserId, @CurrentDate),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Браїлко'), 5, 1500, 2, @CurrentUserId, @CurrentDate),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Красицький'), 4.1, 1000, 1, @CurrentUserId, @CurrentDate),
		((SELECT [StudentId] FROM [dbo].[Student] WHERE [FirstName] = N'Красицький'), 4.4, 1000, 2, @CurrentUserId, @CurrentDate)

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
GO
