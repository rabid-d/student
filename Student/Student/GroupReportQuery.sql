DECLARE @GroupName AS NVARCHAR(64) = N'ПІ-21'

SELECT 
	[FirstName] + ' ' + [LastName] + ' ' + [Middlename] as [PIB],
	(SELECT COUNT(*)
	FROM [dbo].[Student]
	JOIN [dbo].[Grade] ON [dbo].[Student].[StudentId] = [dbo].[Grade].[StudentId]
	WHERE [FirstName] = [st].[FirstName] AND [Grade] = 2) AS 'Незадовільно',
	(SELECT COUNT(*)
	FROM [dbo].[Student]
	JOIN [dbo].[Grade] ON [dbo].[Student].[StudentId] = [dbo].[Grade].[StudentId]
	WHERE [FirstName] = [st].[FirstName] AND [Grade] = 3) AS 'Задовільно',
	(SELECT COUNT(*)
	FROM [dbo].[Student]
	JOIN [dbo].[Grade] ON [dbo].[Student].[StudentId] = [dbo].[Grade].[StudentId]
	WHERE [FirstName] = [st].[FirstName] AND [Grade] = 4) AS 'Добре',
	(SELECT COUNT(*)
	FROM [dbo].[Student]
	JOIN [dbo].[Grade] ON [dbo].[Student].[StudentId] = [dbo].[Grade].[StudentId]
	WHERE [FirstName] = [st].[FirstName] AND [Grade] = 5) AS 'Відмінно',
	(SELECT COUNT(*)
	FROM [dbo].[Student]
	JOIN [dbo].[Grade] ON [dbo].[Student].[StudentId] = [dbo].[Grade].[StudentId]
	WHERE [FirstName] = [st].[FirstName]) AS 'Всього оцінок'
FROM [dbo].[Student] AS [st]
RIGHT JOIN [dbo].[Group] ON [st].[CurrentGroupId] = [dbo].[Group].[GroupId]
WHERE [GroupName] = @GroupName
