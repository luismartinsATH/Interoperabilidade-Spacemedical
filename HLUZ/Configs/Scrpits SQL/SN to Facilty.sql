Use LomondClinicalData
SELECT        RecorderSerial, FacilityKey, DownloadFacilityKey
FROM            Test

--localização Vila Real
update Test set FacilityKey='{0AE50162-C53B-458E-B3BA-4510CAAF267D}', DownloadFacilityKey='{0AE50162-C53B-458E-B3BA-4510CAAF267D}'
where 
test.RecorderSerial='1137401'
and Test.FacilityKey is Null

update Test set FacilityKey='{0AE50162-C53B-458E-B3BA-4510CAAF267D}', DownloadFacilityKey='{0AE50162-C53B-458E-B3BA-4510CAAF267D}'
where 
test.RecorderSerial='9977537'
and Test.FacilityKey is Null



--localização Arrábida
update Test set FacilityKey='{93A0DA98-A4E9-4F89-A1A5-583ACAAC1A65}' , DownloadFacilityKey='{93A0DA98-A4E9-4F89-A1A5-583ACAAC1A65}'
where 
test.RecorderSerial='1649543'
and Test.FacilityKey is Null


update Test set FacilityKey='{93A0DA98-A4E9-4F89-A1A5-583ACAAC1A65}' , DownloadFacilityKey='{93A0DA98-A4E9-4F89-A1A5-583ACAAC1A65}'
where 
test.RecorderSerial='1394522'
and Test.FacilityKey is Null

--localização Setubal
update Test set FacilityKey='{875277A0-988D-477C-A557-E8E2C179DBC9}' , DownloadFacilityKey='{875277A0-988D-477C-A557-E8E2C179DBC9}'
where 
test.RecorderSerial='5002463'
and Test.FacilityKey is Null

--localização Coimbra
update Test set FacilityKey='{48A52DB5-0A89-4448-B5D3-98E43F6A1095}' , DownloadFacilityKey='{48A52DB5-0A89-4448-B5D3-98E43F6A1095}'
where 
test.RecorderSerial='123456789'
and Test.FacilityKey is Null

