DECLARE @GroupName AS NVARCHAR(64) = N'ϲ-21'

SELECT 
	[FirstName] + ' ' + [LastName] + ' ' + [Middlename] as [PIB],
	(SELECT COUNT(*)
	FROM [dbo].[Student]
	LEFT JOIN [dbo].[Grade] ON [dbo].[Student].[StudentId] = [dbo].[Grade].[StudentId]
	WHERE [FirstName] = [st].[FirstName] AND [Grade] = 2) AS '�����������',
	(SELECT COUNT(*)
	FROM [dbo].[Student]
	LEFT JOIN [dbo].[Grade] ON [dbo].[Student].[StudentId] = [dbo].[Grade].[StudentId]
	WHERE [FirstName] = [st].[FirstName] AND [Grade] = 3) AS '���������',
	(SELECT COUNT(*)
	FROM [dbo].[Student]
	LEFT JOIN [dbo].[Grade] ON [dbo].[Student].[StudentId] = [dbo].[Grade].[StudentId]
	WHERE [FirstName] = [st].[FirstName] AND [Grade] = 4) AS '�����',
	(SELECT COUNT(*)
	FROM [dbo].[Student]
	LEFT JOIN [dbo].[Grade] ON [dbo].[Student].[StudentId] = [dbo].[Grade].[StudentId]
	WHERE [FirstName] = [st].[FirstName] AND [Grade] = 5) AS '³�����',
	(SELECT COUNT(*)
	FROM [dbo].[Student]
	LEFT JOIN [dbo].[Grade] ON [dbo].[Student].[StudentId] = [dbo].[Grade].[StudentId]
	WHERE [FirstName] = [st].[FirstName]) AS '������ ������'
FROM [dbo].[Student] AS [st]
RIGHT JOIN [dbo].[Group] ON [st].[CurrentGroupId] = [dbo].[Group].[GroupId]
WHERE [GroupName] = @GroupName
