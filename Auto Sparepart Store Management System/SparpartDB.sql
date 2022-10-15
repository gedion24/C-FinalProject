create database SparePartDB
go
use SparePartDB
go

	CREATE TABLE Supplier(
	[PID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[city] [varchar](50) NULL,
	[contact_No] [varchar](50) NULL,
	[name] [varchar](50) NULL,
	)

	CREATE TABLE Vehicle(
	[VID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[model] [varchar](50) NULL,
	[model_year] [date] NULL,
	[color_code] [varchar](50) NULL,
	)

CREATE TABLE Spare_parts(
	[PID] [int] NULL FOREIGN KEY REFERENCES Supplier(PID),
	[PartNo] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Condition] [varchar](max) NULL,
	[DateAccuired] [date] NULL,
	[CostPrice] [money] NULL,
	[quantity] [int] NULL,
	[spare_part_name] [varchar](100) NULL,
	[Classification] [varchar](max) NULL,
	[VID] [int] NULL FOREIGN KEY REFERENCES Vehicle(VID),
	)


	CREATE TABLE SalesEmp(
	[SalesEmpID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[f_name] [varchar](50) NULL,
	[l_name] [varchar](50) NULL,
	[b_date] [date] NULL,
	[HouseNumber] [varchar](20) NULL,
	[Street_Name] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[contact_No] [varchar](50) NULL,
	[username] [varchar](50) NULL,
	[Pass] [varchar](100) NULL,
	)



	

CREATE TABLE Customer(
	[CID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[VID] [int] NULL FOREIGN KEY REFERENCES Vehicle(VID),
	[f_name] [varchar](50) NULL,
	[l_name] [varchar](50) NULL,
	[HouseNumber] [varchar](50) NULL,
	[Street_Name] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[contact_No] [varchar](50) NULL,
	[SalesEmpID] [int] NULL FOREIGN KEY REFERENCES SalesEmp(SalesEmpID),
	)

CREATE TABLE c_order(
	[OID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CID] [int] NULL FOREIGN KEY REFERENCES Customer(CID),
	[OrderDate] [date] NULL,
	[DeliveryDate] [date] NULL,
	[PartNo] [int] NULL FOREIGN KEY REFERENCES Spare_parts(PartNo),
	[quantity] [int] NULL,
	[price] [money] NULL,
	)
	

	CREATE TABLE Sales(
	[SalesID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[PartNo] [int] NULL FOREIGN KEY REFERENCES Spare_parts(PartNo),
	[CID] [int] NULL FOREIGN KEY REFERENCES Customer(CID),
	[Quantity] [int] NULL,
	[price] [money] NULL,
	[S_Date] [date] NULL,
	)

	
	CREATE TABLE store_manager(
	[MID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[f_name] [varchar](50) NULL,
	[l_name] [varchar](50) NULL,
	[username] [varchar](50) NULL,
	[Pass] [varchar](100) NULL,
	[HouseNumber] [varchar](50) NULL,
	[Street_Name] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[contact_No] [varchar](50) NULL,
	)

	CREATE TABLE tblNewOrder(
	[OrderId] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[orderDate] [date] NULL,
	[Quantity] [int] NULL,
	[price] [money] NULL,
	[Supplier_ID] [int] NULL,
	[Spare_Part] [varchar](100) NULL,
	)

	Select * from Vehicle
	Select * from Spare_parts
    Select * from Supplier
	Select * from tblNewOrder
	Select * from SalesEmp
	Select * from Customer
	Select * from c_order


	INSERT INTO store_manager (f_name, l_name, username, Pass, HouseNumber, Street_Name, city,contact_No)
VALUES ('Gedion', 'Getachew', 'gedi', '1234', '4006', '4killo','AA','091122333');


/*d*/

