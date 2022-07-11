DECLARE @Group AS NVARCHAR(64) = N'ПІ-21'
DECLARE @RatingFrom AS FLOAT = 2.0
DECLARE @RatingTo AS FLOAT = 4.4

SELECT [FirstName], [LastName], [Middlename], [GroupName], [StudentRating], [AcademicTerm]
FROM [dbo].[Student] [St]
JOIN [dbo].[Group] [Gr] ON [St].[CurrentGroupId] = [Gr].[GroupId] AND [Gr].[GroupName] = @Group
JOIN [dbo].[StudentRating] [Sr] ON [St].[StudentId] = [Sr].[StudentId]
WHERE [Sr].[StudentRating] BETWEEN @RatingFrom AND @RatingTo
