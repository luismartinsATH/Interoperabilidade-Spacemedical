Use LomondClinicalData

--localização Coimbra
update Test set FacilityKey='{CE9DEB69-98CD-4774-93EB-1BED023C612B}' , DownloadFacilityKey='{CE9DEB69-98CD-4774-93EB-1BED023C612B}'
where 
test.RecorderSerial='123456789'
and Test.FacilityKey is Null

update Patient set OrganisationKey='{3A2C6F96-9969-4C13-9E92-874E39053A15}'
--SELECT        Test.RecorderSerial AS SN, Organisation.Name AS ORG, Patient.PatientId, Test.TestTypeName, Organisation.[Key]
FROM            Test INNER JOIN
                         Patient ON Test.PatientKey = Patient.[Key] INNER JOIN
                         Organisation ON Patient.OrganisationKey = Organisation.[Key]
WHERE        ((Test.RecorderSerial = '123456789') or (Test.RecorderSerial = '12345678') or (Test.RecorderSerial = '1234567')) 
			and (Patient.OrganisationKey <> '{3A2C6F96-9969-4C13-9E92-874E39053A15}')