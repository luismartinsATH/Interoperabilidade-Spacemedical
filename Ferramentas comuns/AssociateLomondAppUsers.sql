-- This script file should be used to associate a LomondApp login with a LomondApp database user for the Sentinel database.
-- This would be needed if the database had been restored to a new server and a LomondApp login had been created manually. 

use LomondAuditData;
go

sp_change_users_login 'Update_One', 'LomondApp', 'LomondApp';
go

use LomondClinicalData;
go

sp_change_users_login 'Update_One', 'LomondApp', 'LomondApp';
go