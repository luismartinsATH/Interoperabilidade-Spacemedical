SELECT
  Patient.PatientId
 ,Patient.GivenName
 ,Patient.FamilyName
 ,Test.RecorderSerial
 ,Test.TestTypeName
 ,Test.CreatedDateTime
 ,Test.OrderID
 ,RestingInfo.value('(/RestingInfo/Interpretations)[1]', 'nvarchar(max)') AS Comentários
 ,Test.OrderingPhysician
 ,ReportSignature.DateSigned
 ,ReportSignature.StaffMemberKey
FROM dbo.Test
INNER JOIN dbo.Patient
  ON Test.PatientKey = Patient.[Key]
INNER JOIN dbo.Report
  ON Report.TestKey = Test.[Key]
INNER JOIN dbo.ReportSignature
  ON ReportSignature.ReportKey = Report.[Key]
