UPDATE       Organisation
SET                Name = N'VR'
FROM            Organisation RIGHT OUTER JOIN
                         Patient ON Organisation.[Key] = Patient.OrganisationKey RIGHT OUTER JOIN
                         Test ON Patient.[Key] = Test.PatientKey
WHERE        (Test.RecorderSerial = N'010300')