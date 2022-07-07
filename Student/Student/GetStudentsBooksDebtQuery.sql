/* Interval means how long ago a book was taken from library */
DECLARE @Interval AS BIGINT = 15778463 /* In seconds */

SELECT [FirstName], [LastName], [Middlename], SUM([Price]) AS [Debt], COUNT([LendedBookId]) AS [TotalLendedBooks]
FROM [dbo].[Student]
INNER JOIN [dbo].[LendedBook] ON [dbo].[Student].[StudentId] = [dbo].[LendedBook].[StudentId]
LEFT JOIN [dbo].[Book] ON [dbo].[LendedBook].[BookId] = [dbo].[Book].[BookId]
WHERE DATEDIFF(s, [dbo].[LendedBook].[CreatedDateTime], GETDATE()) > @Interval
GROUP BY [FirstName], [LastName], [Middlename]