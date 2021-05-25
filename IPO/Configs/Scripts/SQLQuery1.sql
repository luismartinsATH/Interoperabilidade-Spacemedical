CREATE VIEW [dbo].[IPO1]

AS

SELECT   top 10 percent     Patient.PatientId, Patient.GivenName AS Nome_Paciente, Patient.FamilyName AS Apelido_Paciente, Test.TestTypeName, Test.CreatedDateTime, Test.OrderID, 
                         Test.RestingInfo.value('(/RestingInfo/Interpretations)[1]', 'nvarchar(max)') AS Comentários, ReportSignature.DateSigned, StaffMember.GivenName AS Nome_Assin, 
                         StaffMember.FamilyName AS Apelido_Assin
FROM            Test INNER JOIN
                         Patient ON Test.PatientKey = Patient.[Key] INNER JOIN
                         Report ON Report.TestKey = Test.[Key] INNER JOIN
                         ReportSignature ON ReportSignature.ReportKey = Report.[Key] FULL OUTER JOIN
                         StaffMember ON ReportSignature.StaffMemberKey = StaffMember.[Key]
WHERE        (Test.OrderID IS NOT NULL) 
ORDER BY ReportSignature.DateSigned DESC

GO