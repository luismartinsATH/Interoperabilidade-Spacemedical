USE LomondClinicalData
GO

CREATE VIEW IncorrectRestingInfoTests AS
SELECT [Test].[Key], [RestingInfo], [RecordingKey]
FROM [Test], [Report]
WHERE [Test].[RestingInfo].value('(/RestingInfo/Interpretations)[1]', 'nvarchar(max)') LIKE '%Miocárdio%' 
OR [Test].[RestingInfo].value('(/RestingInfo/Interpretations)[1]', 'nvarchar(max)') LIKE '%Enfarte%'
OR [Test].[RestingInfo].value('(/RestingInfo/Interpretations)[1]', 'nvarchar(max)') LIKE '%MiocÃ¡rdio%'
OR Report.Comments LIKE N'%MiocÃ¡rdio%'
GO

BEGIN TRANSACTION

DECLARE @MaxRows INT
DECLARE @RowNum INT = 0
DECLARE @TestKey UNIQUEIDENTIFIER
DECLARE @RestingInfo XML
DECLARE @RecordingKey UNIQUEIDENTIFIER

SELECT @MaxRows = COUNT(*) FROM IncorrectRestingInfoTests

SELECT TOP 1 @TestKey = [Key] FROM IncorrectRestingInfoTests
ORDER BY [Key] ASC

WHILE @RowNum < @MaxRows
BEGIN
	
	SET @RowNum = @RowNum + 1

	SELECT @RestingInfo = RestingInfo, @RecordingKey = RecordingKey
	FROM [Test] 
	WHERE [Key] = @TestKey

	SET @RestingInfo.modify('delete (/RestingInfo/Interpretations[1]/Interpretation)')

	UPDATE [Test]
	SET RestingInfo = @RestingInfo
	WHERE [Key] = @TestKey

	UPDATE [Report]
	SET [Report].[Comments] = ''
	WHERE [Report].[TestKey] = @TestKey

	UPDATE [Recording]
	SET [Recording].[Comments] = ''
	WHERE [Recording].[Key] = @RecordingKey

	SELECT TOP 1 @TestKey = [Key] FROM IncorrectRestingInfoTests
	WHERE [Key] > @TestKey
	ORDER BY [Key] ASC
END
GO

--commit 

--SELECT [Test].[RestingInfo].value('(/RestingInfo/Interpretations)[1]', 'nvarchar(max)') AS Interpretations, [Report].[Comments] AS ReportComments, [Recording].[Comments] AS RecordingComments
--FROM [Test] INNER JOIN
--Report ON [Test].[Key] = [Report].[TestKey] INNER JOIN
--Recording ON [Test].[RecordingKey] = [Recording].[Key]

