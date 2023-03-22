select * from nashville;
#to add another column "salesdate" to nashville
alter table nashville add salesdate date;
#to update the the salesdate column from saledate (converting datetime format to date format)
update nashville set salesdate = cast(saledate as date);
select propertyaddress from nashville
where PropertyAddress is null;
#to get the propertyaddress with null values in which there parcelid is the same and they got unique uniqueid
select a.parcelid, a.propertyaddress,b.parcelid, b.propertyaddress
from nashville a 
join nashville b
   on a.parcelid=b.parcelid
   and a.uniqueid<>b.uniqueid
   where a.propertyaddress is null;
   #to update the propertyaddress with null values with adresses with the same parcelid
update a.nashville
set propertyaddress=ISNULL(a.propertyaddress,b.propertyaddress)
from nashville a 
join nashville b
   on a.parcelid=b.parcelid
   and a.uniqueid<>b.uniqueid
   where a.propertyaddress is null;
#TO split the propertyaddress column into 2 using the ',' delimeter
select 
substring_index(propertyaddress,',',1) as Address,
substring_index(propertyaddress,',',-1) as city 
from nashville;
#to create the columns for the address and city
alter table nashville
add p_address nvarchar(255),
add p_city nvarchar(255);
#to update the two columns with the splitted values
update nashville set p_address = substring_index(propertyaddress,',',1);
update nashville set p_city = substring_index(propertyaddress,',',-1);
#to rename the address and city column
alter table nashville
RENAME COLUMN q_address TO p_city;
#to split the owneraddress into three parts delimeter = ','
#add the column to be splitted into
alter table nashville
add o_address nvarchar(255),
add o_city nvarchar(255),
add o_state nvarchar(255);
#update the columns created with the 3 splitted fields
update nashville set o_address= substring_index(owneraddress,',',1),
update nashville set o_city = substring_index(substring_index(owneraddress,',',2),',',-1);
update nashville set o_state = substring_index(owneraddress,',',-1);
select * from nashville
#to replace the values in the soldasvacant column with the correct values i.e y=yes, n=no
update nashville
set soldasvacant = case when soldasvacant ='Y' then'Yes'
when soldasvacant = 'N' then 'No'
else soldasvacant
end;
select soldasvacant, count(soldasvacant) from nashville
#to remove duplicates 
#to get the duplicates
row_number() over (partition by parcelid,landuse,propertyaddress,saledate) as rn from nashville;
#to get the unique id of the duplicates
select uniqueid from (select * ,row_number() over (partition by parcelid,landuse,propertyaddress,saledate) as rn from nashville) as x
where x.rn > 1
#to delete the duplicates
delete from nashville where uniqueid in (
select uniqueid from (select * ,row_number() over (partition by parcelid,landuse,propertyaddress,saledate) as rn from nashville) as x
where x.rn > 1)