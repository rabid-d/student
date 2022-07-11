USE UniversityDatabase
GO

IF OBJECT_ID ( 'dbo.SpTransferStipend', 'P' ) IS NOT NULL
    DROP PROCEDURE [dbo].[SpTransferStipend];
GO

-- This procedure transfers stipend for a specified month to all students.
CREATE PROCEDURE [dbo].[SpTransferStipend]
    @Year INT,
    @Month INT
AS
	DECLARE @CurrentUserId AS UNIQUEIDENTIFIER = NEWID()
	DECLARE @CurrentDate AS DATETIME = GETDATE()
    DECLARE @Id AS UNIQUEIDENTIFIER
    DECLARE @StipendSum AS INT

    SELECT [StudentId] INTO #TempIds FROM [dbo].[Student]

    WHILE EXISTS(SELECT * FROM #TempIds)
    Begin
        SELECT TOP 1 @Id = [StudentId] FROM #TempIds
        DELETE #TempIds WHERE [StudentId] = @Id

        EXEC @StipendSum = [dbo].[FnGetStipendAmount] @StudentId = @Id, @AcademicTerm = 1

        INSERT INTO [dbo].[StipendTransfer] ([StudentId], [StipendAmount], [Year], [Month], [CreatedBy], [CreatedDateTime])
        VALUES (@Id, @StipendSum, @Year, @Month, @CurrentUserId, @CurrentDate)
    END

    DROP TABLE #TempIds
GO


--USE UniversityDatabase;  
--GO  
--EXEC [dbo].[SpTransferStipend] @Year = 2022, @Month = 1;
--GO