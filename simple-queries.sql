--From our 2010 table, this query selects all the data of suspects whom physical force (specifically handcuffs) were
--used on by the police. The data is in an ascending order of serial numbers.
Select * From NYC_Stop_and_Frisk.NYC_DATA_2010
Where pf_hcuff = True
Order by ser_num

--From our 2011 table, this query leads to a display of all the suspects who were found carrying a pistol. The data is
--in arranged in order from the earliest time of stop to the latest.
Select * From NYC_Stop_and_Frisk.NYC_DATA_2011
Where pistol = True
Order by timestop

--From our 2012 table, this query displays the type of ID, whether or not the arrest was made, gender, and race of
--all the suspects who were suspected to be involved in robbery. The data is in an ascending order of serial numbers.
Select N.typeofid, N.arstmade, N.sex, N.race From NYC_Stop_and_Frisk.NYC_DATA_2012 N
Where crimsusp = "ROBBERY"
Order by ser_num
