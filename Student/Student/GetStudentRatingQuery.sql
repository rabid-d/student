/* First term of the 2021-2022 academic year */
DECLARE @IntervalFrom1 AS DATETIME = '2021-09-01 00:00:00'
DECLARE @IntervalTo1 AS DATETIME = '2021-12-31 00:00:00'
/* Second term */
DECLARE @IntervalFrom2 AS DATETIME = '2022-01-01 00:00:00'
DECLARE @IntervalTo2 AS DATETIME = '2022-05-31 00:00:00'

DECLARE @StudentFirstName AS NVARCHAR(128) = N'Тороканець'

SELECT 
	[FirstName] + ' ' + [LastName] + ' ' + [Middlename] as [PIB],
	AVG(Cast([Grade] as Float)) As [StudentRating], 
	[Stipend] =
      CASE AVG([Grade])
         WHEN 4 THEN 1000
         WHEN 5 THEN 1500
         ELSE 0
      END
FROM [dbo].[Student]
LEFT JOIN [dbo].[Grade] ON [dbo].[Student].[StudentId] = [dbo].[Grade].[StudentId]
WHERE [FirstName] = @StudentFirstName AND [StateGrade] = 1 AND [dbo].[Grade].[CreatedDateTime] BETWEEN @IntervalFrom2 AND @IntervalTo2
GROUP BY [FirstName], [LastName], [MiddleName]