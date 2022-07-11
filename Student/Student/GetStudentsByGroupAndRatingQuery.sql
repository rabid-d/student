DECLARE @Group AS NVARCHAR(64) = N'ПІ-21'
DECLARE @RatingFrom AS FLOAT = 2.0
DECLARE @RatingTo AS FLOAT = 4.4

SELECT [FirstName], [LastName], [Middlename], [GroupName], [StudentRating], [AcademicTerm]
FROM [dbo].[Student]
RIGHT JOIN [dbo].[Group] ON [CurrentGroupId] = [GroupId]
LEFT JOIN [dbo].[StudentRating] ON [dbo].[Student].[StudentId] = [dbo].[StudentRating].[StudentId]
WHERE [GroupName] = @Group AND [StudentRating] BETWEEN @RatingFrom AND @RatingTo