DECLARE @BookLendedBeforeDate AS DATETIME = '2021-07-12 00:00:00'

SELECT [FirstName], [LastName], [Middlename], SUM([Price]) AS [Debt], COUNT([LendedBookId]) AS [TotalLendedBooks]
FROM [dbo].[Student] [St]
INNER JOIN [dbo].[LendedBook] [Lb] ON [St].[StudentId] = [Lb].[StudentId]
LEFT JOIN [dbo].[Book] [Bk] ON [Lb].[BookId] = [Bk].[BookId]
WHERE [Lb].[IsReturned] = 0 AND [Lb].[CreatedDateTime] < @BookLendedBeforeDate
GROUP BY [FirstName], [LastName], [Middlename]
