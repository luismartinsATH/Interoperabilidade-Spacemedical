Use LomondClinicalData

Update Organisation 
Set Name = 'VR' 
FROM Test INNER JOIN
             Patient ON Test.PatientKey = Patient.[Key] 
			 INNER JOIN Organisation ON Patient.OrganisationKey = Organisation.[Key]
WHERE (Test.RecorderSerial = N'010300')


