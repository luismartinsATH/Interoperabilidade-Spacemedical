--Global Technical Support - Andy Coldrey 17 December 2013
--This script will delete all tests that do not have an associated Order.
--
--WARNING WARNING WARNING--
--THIS SCRIPT SHOULD NOT BE RUN WITHOUR FIRST BACKING UP THE SENTINEL DATABASES--
--
--LomondAuditData
--LomondClinicalData

Use LomondClinicalData

--Create ToBeDeleted1 temp table containing the case and test keys of all tests to be deleted
SELECT Test.[Key], Test.[CaseKey] INTO ToBeDeleted1 From Test
WHERE Test.Status = '20'
AND Test.[CaseKey] NOT IN (SELECT CaseKey FROM [Order])

--Delete Test, Associated Case and TestStaffMembers Using Entries in ToBeDeleted1 Temp Table
DELETE TSM FROM TestStaffMember as TSM JOIN ToBeDeleted1 as TBD1 ON TSM.TestKey = TBD1.[Key]
DELETE Tst FROM Test as Tst JOIN ToBeDeleted1 as TBD1 ON Tst.[Key] = TBD1.[Key]
DELETE Cse FROM [Case] as Cse JOIN ToBeDeleted1 as TBD1 ON Cse.[Key] = TBD1.CaseKey

DROP TABLE ToBeDeleted1


