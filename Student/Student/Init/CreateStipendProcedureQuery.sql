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

    INSERT INTO [dbo].[StipendTransfer] ([StudentId], [StipendAmount], [Year], [Month], [CreatedBy], [CreatedDateTime])
    SELECT [St].[StudentId], [dbo].[FnGetStipendAmount]([St].[StudentId], 1), @Year, @Month, @CurrentUserId, @CurrentDate
    FROM [dbo].[Student] [St]
GO


--USE UniversityDatabase;  
--GO  
--EXEC [dbo].[SpTransferStipend] @Year = 2022, @Month = 1;
--GO
