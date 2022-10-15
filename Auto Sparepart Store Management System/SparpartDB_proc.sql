use SparePartDB
go

CREATE proc Login_chk
@un varchar(50),@pass varchar(20),@q int = 1
as
begin
declare @p varchar(100),@r int = -1
if(@q = 1)
begin
if EXISTS(select pass from store_manager where username = @un COLLATE Latin1_General_CS_AS) 
begin
select @p = pass from store_manager where username = @un COLLATE Latin1_General_CS_AS
if(@p = @pass COLLATE Latin1_General_CS_AS)
set @r = 1
end
end
else if(@q = 2)
begin
if EXISTS(select pass from SalesEmp where username = @un COLLATE Latin1_General_CS_AS)
begin
select @p = pass from SalesEmp where username = @un COLLATE Latin1_General_CS_AS
if(@p = @pass COLLATE Latin1_General_CS_AS)
set @r = 2
end
end
select @r
end
GO
CREATE proc addCustOrder
@cust varchar(100),@sp varchar(100),@qun int,@price money,@delivery_Date date
as
begin
if not exists ((select CID from Customer where f_name + ' ' + l_name = @cust))
begin
Select 'Customer does not exist'
return 
end
if not exists ((select PartNo from Spare_parts where spare_part_name = @sp))
begin
select 'The Spare part you entered does not exist'
return
end
insert into c_order values((select CID from Customer where f_name + ' ' + l_name = @cust),getdate(),@delivery_Date,(select PartNo from Spare_parts where spare_part_name = @sp),@qun,@price)
end
GO

CREATE proc AddSpareParts
@supp varchar(max), @Condition varchar(max),@price money,@qun int,@n varchar(100),@classification varchar(max),@Veh varchar(max)
as
begin
if not exists(select PID from Supplier where name = @supp)
begin
select 'Supplier does not exist!!!'
return
end
if not exists (select VID from Vehicle where model = @Veh)
begin
select 'Vehicle does not exist'
return
end
insert into Spare_parts values ((select PID from Supplier where name = @supp),@Condition,GETDATE(),@price,@qun,@n,@classification,(select VID from Vehicle where model = @Veh))
end
GO

CREATE proc getSuppNames
@supp varchar(50) = ''
as
begin
if(@supp != '')
Select name from Supplier where name like '%' + @supp +'%'
else
Select name from Supplier
end
GO

CREATE proc getVehicle
@veh varchar(50)
as
begin
if(@veh != '')
Select model from Vehicle where model like '%' + @veh +'%'
else
Select model from Vehicle
end
GO
CREATE proc Addorder
@quantity int,@price money,@supp varchar(50),@spare_part varchar(50)
as
begin
if not exists(select PID from Supplier where name = @supp)
begin
select 'Supplier does not exist!!'
return
end
insert into tblNewOrder values(GETDATE(),@quantity,@price,(select PID from Supplier where name = @supp),@spare_part)
end
GO

create proc updateOrder
@ID int,@quantity int,@price money,@supp varchar(50),@spare_part varchar(50)
as 
begin
if not exists(Select PID from Supplier where name = @supp)
begin
select 'Supplier does not exist'
return
end
update tblNewOrder
set Quantity = @quantity, price = @price,Supplier_ID = (Select PID from Supplier where name = @supp),Spare_Part = @spare_part where OrderId = @ID
end
GO

create proc updtCustOrder
@orderId int, @cust varchar(100),@sp varchar(100),@qun int,@price money,@delivery_Date date
as
begin
update c_order set CID = (select CID from Customer where f_name + ' ' + l_name = @cust),DeliveryDate = @delivery_Date,PartNo = (select PartNo from Spare_parts where spare_part_name = @sp),quantity = @qun, price= @price 
where OID = @orderId 
end
GO


CREATE proc AddCustomer
@fname varchar(50),@lname varchar(50),@vmodel varchar(50),@CN varchar(50),@HN varchar(50),@SN varchar(50),@city varchar(50),@un varchar(70)
as
begin
if not exists(Select VID from Vehicle where model = @vmodel)
begin
select 'Vehicle dose not exist'
return
end
Insert into Customer values((Select VID from Vehicle where model = @vmodel),@fname,@lname,@HN,@SN,@city,@CN,(Select SalesEmpID from SalesEmp where username = @un))
end
GO

CREATE proc UpdCustomer
@CID int,@fname varchar(50),@lname varchar(50),@vmodel varchar(50),@CN varchar(50),@HN varchar(50),@SN varchar(50),@city varchar(50)
as
begin
update Customer set VID = (Select VID from Vehicle where model = @vmodel),f_name = @fname,l_name = @lname,HouseNumber = @HN,Street_Name = @SN,city = @city,contact_No = @CN
end

create proc viewCustOrder
@cust varchar(100)
as
begin
select OID,(Select f_name + ' ' + l_name from Customer where CID = c_order.CID),OrderDate,DeliveryDate,(Select Spare_part_name from Spare_parts where PartNo = c_order.PartNo),quantity,price
from c_order where CID = (Select CID from Customer where (f_name + ' ' + l_name) =  @cust)
end
GO



DROP PROCEDURE addCustOrder


