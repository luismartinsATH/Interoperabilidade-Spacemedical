Use LomondClinicalData
SELECT        RecorderSerial, FacilityKey
FROM            Test

update Test set FacilityKey='{7DD17C2E-B8BF-4FBD-BB5C-8C2334292812}' 
where 
test.RecorderSerial='1848981'
and Test.FacilityKey is Null

update Test set FacilityKey='{9DE79DAF-2193-4B9B-9C57-ABA8E1D1BB76}' 
where 
test.RecorderSerial='1428278'
and Test.FacilityKey is Null
