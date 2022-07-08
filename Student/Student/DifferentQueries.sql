USE UniversityDatabase
GO

-- SELECT на основі однієї таблиці з використанням сортування за різними напрямами (ORDER BY),
-- накладенням умов зі зв’язками OR та AND.
SELECT [FirstName] + ' ' + [LastName] + ' ' + [Middlename] as [PIB], [Birthday], [BirthPlace], [Grade], [StateGrade]
FROM [dbo].[Grade]
LEFT JOIN [dbo].[Student] ON  [dbo].[Grade].[StudentId] = [dbo].[Student].[StudentId]
WHERE [dbo].[Student].[BirthPlace] = N'м. Львів' OR [dbo].[Student].[BirthPlace] = N'м. Київ' AND [dbo].[Grade].[Grade] > 2   
ORDER BY [StateGrade] desc, [GRADE]


-- SELECT з виводом обчислюваних полів (виразів) в полях результату та з використанням псевдонімів полів.
SELECT [FirstName] + ' ' + [LastName] + ' ' + [Middlename] as [PIB], ROUND(AVG(Cast([Grade] as Float)), 2) AS 'Average grade'
FROM [dbo].[Grade]
LEFT JOIN [dbo].[Student] ON  [dbo].[Grade].[StudentId] = [dbo].[Student].[StudentId]
GROUP BY [FirstName], [LastName], [Middlename]


-- SELECT на основі двох таблиць з використанням поєднання типу INNER JOIN, накладенням умов зі зв’язками OR та AND.
SELECT [FirstName] + ' ' + [LastName] + ' ' + [Middlename] as [PIB], [BirthPlace], [LendedBookId], [IsReturned], [dbo].[LendedBook].[CreatedDateTime]
FROM [dbo].[LendedBook]
INNER JOIN [dbo].[Student] ON [dbo].[LendedBook].[StudentId] = [dbo].[Student].[StudentId]
WHERE DATEDIFF(m, [dbo].[LendedBook].[CreatedDateTime], GETDATE()) > 6 AND ([dbo].[Student].[BirthPlace] = N'м. Львів' OR [dbo].[Student].[BirthPlace] = N'м. Київ')


-- SELECT на основі більше двох таблиць з використанням поєднання типу INNER JOIN, накладенням умов зі зв’язками OR та AND.
SELECT [FirstName] + ' ' + [LastName] + ' ' + [Middlename] as [PIB], [Title], [Author], [Genre], [Price]
FROM [dbo].[Student]
INNER JOIN [dbo].[LendedBook] ON [dbo].[Student].[StudentId] = [dbo].[LendedBook].[StudentId]
INNER JOIN [dbo].[Book] ON [dbo].[LendedBook].[BookId] = [dbo].[Book].[BookId]
WHERE [Price] > 95 AND ((LOWER([GENRE]) LIKE LOWER('%Crime%') OR LOWER([GENRE]) LIKE LOWER('%Science%')))


-- SELECT на основі кількох таблиць з типами поєднання LEFT JOIN, RIGHT JOIN, FULL JOIN, CROSS JOIN.
SELECT [Grade], [DisciplineName], [firstname]
FROM [dbo].[Grade]
left join [dbo].[GroupDiscipline] ON [dbo].[Grade].[GroupDisciplineId] = [dbo].[GroupDiscipline].[GroupDisciplineId]
left join [dbo].[AcademicDiscipline] ON [dbo].[GroupDiscipline].[DisciplineId] = [dbo].[AcademicDiscipline].[AcademicDisciplineId]
left join [dbo].[Student] ON [dbo].[Grade].[StudentId] = [dbo].[Student].[StudentId]

SELECT [Title], [dbo].[LendedBook].[CreatedDateTime] AS 'Lended date', [IsReturned]
FROM [dbo].[LendedBook]
RIGHT JOIN [dbo].[Book] ON [dbo].[LendedBook].[BookId] = [dbo].[Book].[BookId]
ORDER BY [Title]

SELECT [FirstName], [HobbyName]
FROM [dbo].[Student]
FULL OUTER JOIN [dbo].[StudentHobby] ON [dbo].[Student].[StudentId] = [dbo].[StudentHobby].[StudentId]
LEFT JOIN [dbo].[Hobby] ON [dbo].[StudentHobby].[HobbyId] = [dbo].[Hobby].[HobbyId]
ORDER BY [FirstName], [HobbyName]

SELECT [FirstName], [CivilStatusName]
FROM [dbo].[Student]
CROSS JOIN [dbo].[CivilStatus]


-- SELECT з використанням в секції WHERE операторів Like, Between, IS NULL / IS NOT NULL.
SELECT DISTINCT [Title], [Genre]
FROM [dbo].[Book]
WHERE LOWER([GENRE]) LIKE LOWER('%Science%')

SELECT [StudentId], [Grade]
FROM [dbo].[Grade]
WHERE [Grade] BETWEEN 4 AND 5

SELECT [GroupName], [GroupLeaderId]
FROM [dbo].[Group]
WHERE [GroupLeaderId] IS NULL


--SELECT з використанням статистичних функцій (COUNT, SUM, AVG, MIN, MAX).
SELECT [StudentId], COUNT([BookId]) AS 'Nunmber of lended books'
FROM [dbo].[LendedBook]
GROUP BY [StudentId]

SELECT SUM([Price]) AS 'The cost of all books in the library'
FROM [dbo].[Book]

SELECT [StudentId], ROUND(AVG(Cast([Grade] as Float)), 2) AS 'Average grade'
FROM [dbo].[Grade]
GROUP BY [StudentId]

SELECT MIN([Price]) AS 'The price for the cheapest book in the library'
FROM [dbo].[Book]

SELECT MAX([Price]) AS 'The price for the most expensive book in the library'
FROM [dbo].[Book]


-- SELECT з використанням групування даних та групової статистики (GROUP BY).
SELECT [Title], SUM([Price]) AS 'The total cost of these books'
FROM [dbo].[Book]
GROUP BY [Title]


-- SELECT з використанням фільтрування груп (HAVING).
SELECT [Title], SUM([Price]) AS 'The total cost of these books'
FROM [dbo].[Book]
GROUP BY [Title]
HAVING SUM([Price]) > 400


-- SELECT з використанням підзапитів в секції SELECT.
SELECT [FirstName], 
	(SELECT TOP 1 [Title] 
	 FROM [dbo].[LendedBook] 
	 LEFT JOIN [dbo].[Book] ON [dbo].[LendedBook].[BookId] = [dbo].[Book].[BookId] 
	 WHERE [StudentId] = [St].[StudentId]
	 ORDER BY [dbo].[LendedBook].[CreatedDateTime] DESC
	) AS 'Last lended book'
FROM [dbo].[Student] AS [St]


-- SELECT з використанням підзапитів в секції FROM та з використанням псевдонімів таблиць.
SELECT [Gr].Grade AS 'All state grades'
FROM (SELECT [Grade] FROM [dbo].[Grade] WHERE [StateGrade] = 1) AS [Gr]


-- SELECT з використанням підзапитів в секції WHERE як операндів операторів IN, EXISTS, SOME, ALL, ANY.
SELECT *
FROM [dbo].[Grade]
WHERE [Grade] IN (4, 5)

SELECT *
FROM [dbo].[Student] AS [St]
WHERE NOT EXISTS (SELECT * FROM [dbo].[LendedBook] WHERE [St].[StudentId] = [dbo].[LendedBook].StudentId)

SELECT [StudentId], [FirstName]
FROM [dbo].[Student] AS [St]
WHERE 4 < ANY (SELECT [Grade] FROM [dbo].[Grade] WHERE [dbo].[Grade].[StudentId] = [St].[StudentId] AND [dbo].[Grade].[StateGrade] = 1)


-- SELECT з використанням підзапитів в секції HAVING.
SELECT [FirstName], ROUND(AVG(Cast([Grade] as Float)), 2) AS 'Average grade'
FROM [dbo].[Student] AS [St]
LEFT JOIN [dbo].[Grade] AS [Gr] ON [Gr].[StudentId] = [St].[StudentId]
GROUP BY [FirstName], [Gr].[StudentId]
HAVING ROUND(AVG(Cast([Grade] as Float)), 2) > (SELECT [StudentRating] FROM [dbo].[StudentRating] WHERE [dbo].[StudentRating].[StudentId] = [Gr].[StudentId] AND [AcademicTerm] = 1)


--SELECT з використанням оператора CASE.
SELECT  
	[Grade] =
      CASE [Grade]
         WHEN 5 THEN 'Vidminno'
         WHEN 4 THEN 'Dobre'
         WHEN 3 THEN 'Zadovilno'
         WHEN 2 THEN 'Nezadovilno'
         ELSE ''
      END
FROM [dbo].[Grade]


-- SELECT з використанням оператора INTERSECT.
SELECT 
	[StudentId], 
	[StudentRating], 
	[AcademicTerm], 
	[StipendSumm] =
	  CASE [StipendSumm]
         WHEN 0 THEN 100500
         ELSE [StipendSumm]
	  END
FROM [dbo].[StudentRating]
INTERSECT
SELECT 
	[StudentId], 
	[StudentRating], 
	[AcademicTerm], 
	[StipendSumm]
FROM [dbo].[StudentRating]


-- SELECT з використанням оператора EXCEPT.
SELECT 
	[StudentId], 
	[StudentRating], 
	[AcademicTerm], 
	[StipendSumm] =
	  CASE [StipendSumm]
         WHEN 0 THEN 100500
         ELSE [StipendSumm]
	  END
FROM [dbo].[StudentRating]
EXCEPT
SELECT 
	[StudentId], 
	[StudentRating], 
	[AcademicTerm], 
	[StipendSumm]
FROM [dbo].[StudentRating]


-- SELECT з використанням оператора UNION.
SELECT [ModifiedBy], [ModifiedDateTime], [CreatedBy], [CreatedDateTime]
FROM [dbo].[Room]
UNION
SELECT [ModifiedBy], [ModifiedDateTime], [CreatedBy], [CreatedDateTime]
FROM [dbo].[CivilStatus]


BEGIN TRANSACTION
DECLARE @User AS UNIQUEIDENTIFIER = NEWID()
DECLARE @CurrentDate AS DATETIME = GETDATE()


-- INSERT INTO для додавання записів з явно вказаними значеннями (VALUES).
INSERT INTO [dbo].[Sex] ([SexName], [CreatedBy], [CreatedDateTime])
VALUES ('Nonbinary', @User, @CurrentDate)


-- INSERT INTO для додавання множини записів.
INSERT INTO [dbo].[Sex] ([SexName], [CreatedBy], [CreatedDateTime])
VALUES 
	('Nonbinary', @User, @CurrentDate),
	('Transgender', @User, @CurrentDate),
	('Cisgender', @User, @CurrentDate)

-- SELECT INTO для додавання даних з інших таблиць.
SELECT * INTO [dbo].[NewSexTable]
FROM [dbo].[Sex]


-- UPDATE на базі однієї таблиці.
UPDATE [dbo].[Book]
SET [Price] = 170
WHERE [Isbn] = '9780099528128'


-- UPDATE на базі кількох таблиць з використанням підзапитів.
UPDATE [dbo].[Book]
SET [Price] = 170
WHERE NOT EXISTS (SELECT * FROM [dbo].[LendedBook] WHERE [dbo].[Book].[BookId] = [dbo].[LendedBook].[BookId])


-- DELETE для видалення всіх даних з таблиці.
DELETE FROM [dbo].[StudentRating]


-- DELETE для видалення вибраних записів таблиці з використанням підзапитів.
DELETE FROM [dbo].[Book]
WHERE NOT EXISTS (SELECT * FROM [dbo].[LendedBook] WHERE [dbo].[Book].[BookId] = [dbo].[LendedBook].[BookId])


ROLLBACK TRANSACTION
