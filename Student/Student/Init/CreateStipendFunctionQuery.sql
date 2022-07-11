USE UniversityDatabase
GO

IF OBJECT_ID('dbo.FnGetStipendAmount') IS NOT NULL
    DROP FUNCTION [dbo].[FnGetStipendAmount]
GO

CREATE FUNCTION [dbo].[FnGetStipendAmount] (@StudentId UNIQUEIDENTIFIER, @AcademicTerm INT)
RETURNS INT
AS
BEGIN
    DECLARE @Rating AS FLOAT

    SELECT @Rating = [StudentRating] 
    FROM [dbo].[StudentRating] 
    WHERE [dbo].[StudentRating].[StudentId] = @StudentId AND [dbo].[StudentRating].[AcademicTerm] = @AcademicTerm
    
    DECLARE @StipendSum AS INT = 
        CASE CAST(@Rating AS INT)
            WHEN 5 THEN 1500
            WHEN 4 THEN 1000
            ELSE 0
        END

    RETURN @StipendSum
END
GO
