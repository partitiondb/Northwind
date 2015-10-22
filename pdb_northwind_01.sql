/*
-- Deleted
CustomerCustomerDemo
CustomerDemographics

-- Common -- Moved to partition for example but ideal
Categories
Customers
Products
Shippers
Suppliers

-- Moved to Partition
Employees 			-- adding RegionID
EmployeeTerritories -- adding RegionID
Orders 				-- adding RegionID
Order Details 		-- adding RegionID
Region
Territories
*/

use master;
begin
declare @sql nvarchar(max);
select @sql = coalesce(@sql,'') + 'kill ' + convert(varchar, spid) + ';'
from master..sysprocesses
where dbid in (db_id('NorthwindGate'),db_id('NorthwindEasternDB'),db_id('NorthwindWesternDB'),db_id('NorthwindNorthernDB'),db_id('NorthwindSouthernDB')) and cmd = 'AWAITING COMMAND' and spid <> @@spid;
exec(@sql);
end;
go
if db_id('NorthwindGate') 		is not null drop database NorthwindGate;
if db_id('NorthwindEasternDB') 	is not null drop database NorthwindEasternDB;
if db_id('NorthwindWesternDB')  is not null drop database NorthwindWesternDB;
if db_id('NorthwindNorthernDB') is not null drop database NorthwindNorthernDB;
if db_id('NorthwindSouthernDB') is not null drop database NorthwindSouthernDB;
create database NorthwindEasternDB;
create database NorthwindWesternDB;
create database NorthwindNorthernDB;
create database NorthwindSouthernDB;
use PdbLogic;
exec Pdbinstall 'NorthwindGate',@ColumnName='RegionID',@ColumnType='int';
go
use NorthwindGate;
exec PdbcreatePartition 'NorthwindGate','NorthwindEasternDB',1;
exec PdbcreatePartition 'NorthwindGate','NorthwindWesternDB',2;	
exec PdbcreatePartition 'NorthwindGate','NorthwindNorthernDB',3;
exec PdbcreatePartition 'NorthwindGate','NorthwindSouthernDB',4;

/****** Object:  Table [dbo].[Categories] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[RegionID] [int] NOT NULL, -- Temp NEW
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](15) NOT NULL,
	[Description] [ntext] NULL,
	[Picture] [image] NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customers] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[RegionID] [int] NOT NULL, -- Temp NEW
	[CustomerID] [nchar](5) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[ContactName] [nvarchar](30) NULL,
	[ContactTitle] [nvarchar](30) NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[RegionID] [int] NOT NULL, -- Temp NEW
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](40) NOT NULL,
	[SupplierID] [int] NULL,
	[CategoryID] [int] NULL,
	[QuantityPerUnit] [nvarchar](20) NULL,
	[UnitPrice] [money] NULL CONSTRAINT [DF_Products_UnitPrice]  DEFAULT ((0)),
	[UnitsInStock] [smallint] NULL CONSTRAINT [DF_Products_UnitsInStock]  DEFAULT ((0)),
	[UnitsOnOrder] [smallint] NULL CONSTRAINT [DF_Products_UnitsOnOrder]  DEFAULT ((0)),
	[ReorderLevel] [smallint] NULL CONSTRAINT [DF_Products_ReorderLevel]  DEFAULT ((0)),
	[Discontinued] [bit] NOT NULL CONSTRAINT [DF_Products_Discontinued]  DEFAULT ((0)),
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shippers] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shippers](
	[RegionID] [int] NOT NULL, -- Temp NEW
	[ShipperID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[Phone] [nvarchar](24) NULL,
 CONSTRAINT [PK_Shippers] PRIMARY KEY CLUSTERED 
(
	[ShipperID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Suppliers] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[RegionID] [int] NOT NULL, -- Temp NEW
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[ContactName] [nvarchar](30) NULL,
	[ContactTitle] [nvarchar](30) NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL,
	[HomePage] [ntext] NULL,
 CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Employees] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[RegionID] [int] NOT NULL, -- NEW
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[FirstName] [nvarchar](10) NOT NULL,
	[Title] [nvarchar](30) NULL,
	[TitleOfCourtesy] [nvarchar](25) NULL,
	[BirthDate] [datetime] NULL,
	[HireDate] [datetime] NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[HomePhone] [nvarchar](24) NULL,
	[Extension] [nvarchar](4) NULL,
	[Photo] [image] NULL,
	[Notes] [ntext] NULL,
	[ReportsTo] [int] NULL,
	[PhotoPath] [nvarchar](255) NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmployeeTerritories] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeTerritories](
	[RegionID] [int] NOT NULL, -- NEW
	[EmployeeID] [int] NOT NULL,
	[TerritoryID] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_EmployeeTerritories] PRIMARY KEY NONCLUSTERED 
(
	[EmployeeID] ASC,
	[TerritoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Order Details] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order Details](
	[RegionID] [int] NOT NULL, -- NEW
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL CONSTRAINT [DF_Order_Details_UnitPrice]  DEFAULT ((0)),
	[Quantity] [smallint] NOT NULL CONSTRAINT [DF_Order_Details_Quantity]  DEFAULT ((1)),
	[Discount] [real] NOT NULL CONSTRAINT [DF_Order_Details_Discount]  DEFAULT ((0)),
 CONSTRAINT [PK_Order_Details] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[RegionID] [int] NOT NULL, -- NEW
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [nchar](5) NULL,
	[EmployeeID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[RequiredDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[ShipVia] [int] NULL,
	[Freight] [money] NULL CONSTRAINT [DF_Orders_Freight]  DEFAULT ((0)),
	[ShipName] [nvarchar](40) NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
	[ShipCountry] [nvarchar](15) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Region] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Region](
	[RegionID] [int] NOT NULL,
	[RegionDescription] [nchar](50) NOT NULL,
 CONSTRAINT [PK_Region] PRIMARY KEY NONCLUSTERED 
(
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Territories] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Territories](
	[TerritoryID] [nvarchar](20) NOT NULL,
	[TerritoryDescription] [nchar](50) NOT NULL,
	[RegionID] [int] NOT NULL,
 CONSTRAINT [PK_Territories] PRIMARY KEY NONCLUSTERED 
(
	[TerritoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

--------------------------------
-- LOAD DATA

set identity_insert NorthwindEasternDB.dbo.Categories on
insert into NorthwindEasternDB.dbo.Categories -- HasIdentity
(RegionID,CategoryID,CategoryName,Description,Picture)
select 1 RegionID,CategoryID,CategoryName,Description,Picture
from Northwind.dbo.Categories;
set identity_insert NorthwindEasternDB.dbo.Categories off

set identity_insert NorthwindWesternDB.dbo.Categories on
insert into NorthwindWesternDB.dbo.Categories -- HasIdentity
(RegionID,CategoryID,CategoryName,Description,Picture)
select 2 RegionID,CategoryID,CategoryName,Description,Picture
from Northwind.dbo.Categories;
set identity_insert NorthwindWesternDB.dbo.Categories off

set identity_insert NorthwindNorthernDB.dbo.Categories on
insert into NorthwindNorthernDB.dbo.Categories -- HasIdentity
(RegionID,CategoryID,CategoryName,Description,Picture)
select 3 RegionID,CategoryID,CategoryName,Description,Picture
from Northwind.dbo.Categories;
set identity_insert NorthwindNorthernDB.dbo.Categories off

set identity_insert NorthwindSouthernDB.dbo.Categories on
insert into NorthwindSouthernDB.dbo.Categories -- HasIdentity
(RegionID,CategoryID,CategoryName,Description,Picture)
select 4 RegionID,CategoryID,CategoryName,Description,Picture
from Northwind.dbo.Categories;
set identity_insert NorthwindSouthernDB.dbo.Categories off

insert into PdbCustomers
(CustomerID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax)
select CustomerID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax
from Northwind.dbo.Customers;

set identity_insert NorthwindEasternDB.dbo.Products on
insert into NorthwindEasternDB.dbo.Products -- HasIdentity
(RegionID,ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued)
select 1 RegionID,ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued
from Northwind.dbo.Products;
set identity_insert NorthwindEasternDB.dbo.Products off

set identity_insert NorthwindWesternDB.dbo.Products on
insert into NorthwindWesternDB.dbo.Products -- HasIdentity
(RegionID,ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued)
select 2 RegionID,ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued
from Northwind.dbo.Products;
set identity_insert NorthwindWesternDB.dbo.Products off

set identity_insert NorthwindNorthernDB.dbo.Products on
insert into NorthwindNorthernDB.dbo.Products -- HasIdentity
(RegionID,ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued)
select 3 RegionID,ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued
from Northwind.dbo.Products;
set identity_insert NorthwindNorthernDB.dbo.Products off

set identity_insert NorthwindSouthernDB.dbo.Products on
insert into NorthwindSouthernDB.dbo.Products -- HasIdentity
(RegionID,ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued)
select 4 RegionID,ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued
from Northwind.dbo.Products;
set identity_insert NorthwindSouthernDB.dbo.Products off

set identity_insert NorthwindEasternDB.dbo.Shippers on
insert into NorthwindEasternDB.dbo.Shippers -- HasIdentity
(RegionID,ShipperID,CompanyName,Phone)
select 1 RegionID,ShipperID,CompanyName,Phone
from Northwind.dbo.Shippers;
set identity_insert NorthwindEasternDB.dbo.Shippers off

set identity_insert NorthwindWesternDB.dbo.Shippers on
insert into NorthwindWesternDB.dbo.Shippers -- HasIdentity
(RegionID,ShipperID,CompanyName,Phone)
select 2 RegionID,ShipperID,CompanyName,Phone
from Northwind.dbo.Shippers;
set identity_insert NorthwindWesternDB.dbo.Shippers off

set identity_insert NorthwindNorthernDB.dbo.Shippers on
insert into NorthwindNorthernDB.dbo.Shippers -- HasIdentity
(RegionID,ShipperID,CompanyName,Phone)
select 3 RegionID,ShipperID,CompanyName,Phone
from Northwind.dbo.Shippers;
set identity_insert NorthwindNorthernDB.dbo.Shippers off

set identity_insert NorthwindSouthernDB.dbo.Shippers on
insert into NorthwindSouthernDB.dbo.Shippers -- HasIdentity
(RegionID,ShipperID,CompanyName,Phone)
select 4 RegionID,ShipperID,CompanyName,Phone
from Northwind.dbo.Shippers;
set identity_insert NorthwindSouthernDB.dbo.Shippers off

set identity_insert NorthwindEasternDB.dbo.Suppliers on
insert into NorthwindEasternDB.dbo.Suppliers -- HasIdentity
(RegionID,SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax,HomePage)
select 1 RegionID,SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax,HomePage
from Northwind.dbo.Suppliers;
set identity_insert NorthwindEasternDB.dbo.Suppliers off

set identity_insert NorthwindWesternDB.dbo.Suppliers on
insert into NorthwindWesternDB.dbo.Suppliers -- HasIdentity
(RegionID,SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax,HomePage)
select 2 RegionID,SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax,HomePage
from Northwind.dbo.Suppliers;
set identity_insert NorthwindWesternDB.dbo.Suppliers off

set identity_insert NorthwindNorthernDB.dbo.Suppliers on
insert into NorthwindNorthernDB.dbo.Suppliers -- HasIdentity
(RegionID,SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax,HomePage)
select 3 RegionID,SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax,HomePage
from Northwind.dbo.Suppliers;
set identity_insert NorthwindNorthernDB.dbo.Suppliers off

set identity_insert NorthwindSouthernDB.dbo.Suppliers on
insert into NorthwindSouthernDB.dbo.Suppliers -- HasIdentity
(RegionID,SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax,HomePage)
select 4 RegionID,SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax,HomePage
from Northwind.dbo.Suppliers;
set identity_insert NorthwindSouthernDB.dbo.Suppliers off

set identity_insert NorthwindEasternDB.dbo.Employees on
insert into NorthwindEasternDB.dbo.Employees -- HasIdentity
(RegionID,EmployeeID,LastName,FirstName,Title,TitleOfCourtesy,BirthDate,HireDate,Address,City,Region,PostalCode,Country,HomePhone,Extension,Photo,Notes,ReportsTo,PhotoPath)
select EmployeeTerritories.RegionID,Employees.EmployeeID,Employees.LastName,Employees.FirstName,Employees.Title,Employees.TitleOfCourtesy,Employees.BirthDate,Employees.HireDate,Employees.Address,Employees.City,Employees.Region,Employees.PostalCode,Employees.Country,Employees.HomePhone,Employees.Extension,Employees.Photo,Employees.Notes,Employees.ReportsTo,Employees.PhotoPath
from Northwind.dbo.Employees
join 	(select distinct EmployeeID,RegionID 
		from Northwind.dbo.EmployeeTerritories
		join Northwind.dbo.Territories on EmployeeTerritories.TerritoryID = Territories.TerritoryID) EmployeeTerritories on EmployeeTerritories.EmployeeID = Employees.EmployeeID
where EmployeeTerritories.RegionID = 1;
set identity_insert NorthwindEasternDB.dbo.Employees off
		
set identity_insert NorthwindWesternDB.dbo.Employees on
insert into NorthwindWesternDB.dbo.Employees -- HasIdentity
(RegionID,EmployeeID,LastName,FirstName,Title,TitleOfCourtesy,BirthDate,HireDate,Address,City,Region,PostalCode,Country,HomePhone,Extension,Photo,Notes,ReportsTo,PhotoPath)
select EmployeeTerritories.RegionID,Employees.EmployeeID,Employees.LastName,Employees.FirstName,Employees.Title,Employees.TitleOfCourtesy,Employees.BirthDate,Employees.HireDate,Employees.Address,Employees.City,Employees.Region,Employees.PostalCode,Employees.Country,Employees.HomePhone,Employees.Extension,Employees.Photo,Employees.Notes,Employees.ReportsTo,Employees.PhotoPath
from Northwind.dbo.Employees
join 	(select distinct EmployeeID,RegionID 
		from Northwind.dbo.EmployeeTerritories
		join Northwind.dbo.Territories on EmployeeTerritories.TerritoryID = Territories.TerritoryID) EmployeeTerritories on EmployeeTerritories.EmployeeID = Employees.EmployeeID
where EmployeeTerritories.RegionID = 2;
set identity_insert NorthwindWesternDB.dbo.Employees off

set identity_insert NorthwindNorthernDB.dbo.Employees on
insert into NorthwindNorthernDB.dbo.Employees -- HasIdentity
(RegionID,EmployeeID,LastName,FirstName,Title,TitleOfCourtesy,BirthDate,HireDate,Address,City,Region,PostalCode,Country,HomePhone,Extension,Photo,Notes,ReportsTo,PhotoPath)
select EmployeeTerritories.RegionID,Employees.EmployeeID,Employees.LastName,Employees.FirstName,Employees.Title,Employees.TitleOfCourtesy,Employees.BirthDate,Employees.HireDate,Employees.Address,Employees.City,Employees.Region,Employees.PostalCode,Employees.Country,Employees.HomePhone,Employees.Extension,Employees.Photo,Employees.Notes,Employees.ReportsTo,Employees.PhotoPath
from Northwind.dbo.Employees
join 	(select distinct EmployeeID,RegionID 
		from Northwind.dbo.EmployeeTerritories
		join Northwind.dbo.Territories on EmployeeTerritories.TerritoryID = Territories.TerritoryID) EmployeeTerritories on EmployeeTerritories.EmployeeID = Employees.EmployeeID
where EmployeeTerritories.RegionID = 3;
set identity_insert NorthwindNorthernDB.dbo.Employees off

set identity_insert NorthwindSouthernDB.dbo.Employees on
insert into NorthwindSouthernDB.dbo.Employees -- HasIdentity
(RegionID,EmployeeID,LastName,FirstName,Title,TitleOfCourtesy,BirthDate,HireDate,Address,City,Region,PostalCode,Country,HomePhone,Extension,Photo,Notes,ReportsTo,PhotoPath)
select EmployeeTerritories.RegionID,Employees.EmployeeID,Employees.LastName,Employees.FirstName,Employees.Title,Employees.TitleOfCourtesy,Employees.BirthDate,Employees.HireDate,Employees.Address,Employees.City,Employees.Region,Employees.PostalCode,Employees.Country,Employees.HomePhone,Employees.Extension,Employees.Photo,Employees.Notes,Employees.ReportsTo,Employees.PhotoPath
from Northwind.dbo.Employees
join 	(select distinct EmployeeID,RegionID 
		from Northwind.dbo.EmployeeTerritories
		join Northwind.dbo.Territories on EmployeeTerritories.TerritoryID = Territories.TerritoryID) EmployeeTerritories on EmployeeTerritories.EmployeeID = Employees.EmployeeID
where EmployeeTerritories.RegionID = 4;
set identity_insert NorthwindSouthernDB.dbo.Employees off

insert into PdbEmployeeTerritories
(RegionID,EmployeeID,TerritoryID)
select Territories.RegionID,EmployeeTerritories.EmployeeID,EmployeeTerritories.TerritoryID
from Northwind.dbo.EmployeeTerritories
join Northwind.dbo.Territories on EmployeeTerritories.TerritoryID = Territories.TerritoryID;

insert into [PdbOrder Details]
(RegionID,OrderID,ProductID,UnitPrice,Quantity,Discount)
select EmployeeTerritories.RegionID,[Order Details].OrderID,[Order Details].ProductID,[Order Details].UnitPrice,[Order Details].Quantity,[Order Details].Discount
from Northwind.dbo.[Order Details]
join Northwind.dbo.Orders on [Order Details].OrderID = Orders.OrderID
join 	(select distinct EmployeeID,RegionID 
		from Northwind.dbo.EmployeeTerritories
		join Northwind.dbo.Territories on EmployeeTerritories.TerritoryID = Territories.TerritoryID) EmployeeTerritories on EmployeeTerritories.EmployeeID = Orders.EmployeeID;

set identity_insert NorthwindEasternDB.dbo.Orders on
insert into NorthwindEasternDB.dbo.Orders -- HasIdentity
(RegionID,OrderID,CustomerID,EmployeeID,OrderDate,RequiredDate,ShippedDate,Orders.ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry)
select EmployeeTerritories.RegionID,Orders.OrderID,Orders.CustomerID,Orders.EmployeeID,Orders.OrderDate,Orders.RequiredDate,Orders.ShippedDate,Orders.ShipVia,Orders.Freight,Orders.ShipName,Orders.ShipAddress,Orders.ShipCity,Orders.ShipRegion,Orders.ShipPostalCode,Orders.ShipCountry
from Northwind.dbo.Orders
join 	(select distinct EmployeeID,RegionID 
		from Northwind.dbo.EmployeeTerritories
		join Northwind.dbo.Territories on EmployeeTerritories.TerritoryID = Territories.TerritoryID) EmployeeTerritories on EmployeeTerritories.EmployeeID = Orders.EmployeeID
where EmployeeTerritories.RegionID = 1;
set identity_insert NorthwindEasternDB.dbo.Orders off

set identity_insert NorthwindWesternDB.dbo.Orders on
insert into NorthwindWesternDB.dbo.Orders -- HasIdentity
(RegionID,OrderID,CustomerID,EmployeeID,OrderDate,RequiredDate,ShippedDate,Orders.ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry)
select EmployeeTerritories.RegionID,Orders.OrderID,Orders.CustomerID,Orders.EmployeeID,Orders.OrderDate,Orders.RequiredDate,Orders.ShippedDate,Orders.ShipVia,Orders.Freight,Orders.ShipName,Orders.ShipAddress,Orders.ShipCity,Orders.ShipRegion,Orders.ShipPostalCode,Orders.ShipCountry
from Northwind.dbo.Orders
join 	(select distinct EmployeeID,RegionID 
		from Northwind.dbo.EmployeeTerritories
		join Northwind.dbo.Territories on EmployeeTerritories.TerritoryID = Territories.TerritoryID) EmployeeTerritories on EmployeeTerritories.EmployeeID = Orders.EmployeeID
where EmployeeTerritories.RegionID = 2;
set identity_insert NorthwindWesternDB.dbo.Orders off

set identity_insert NorthwindNorthernDB.dbo.Orders on
insert into NorthwindNorthernDB.dbo.Orders -- HasIdentity
(RegionID,OrderID,CustomerID,EmployeeID,OrderDate,RequiredDate,ShippedDate,Orders.ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry)
select EmployeeTerritories.RegionID,Orders.OrderID,Orders.CustomerID,Orders.EmployeeID,Orders.OrderDate,Orders.RequiredDate,Orders.ShippedDate,Orders.ShipVia,Orders.Freight,Orders.ShipName,Orders.ShipAddress,Orders.ShipCity,Orders.ShipRegion,Orders.ShipPostalCode,Orders.ShipCountry
from Northwind.dbo.Orders
join 	(select distinct EmployeeID,RegionID 
		from Northwind.dbo.EmployeeTerritories
		join Northwind.dbo.Territories on EmployeeTerritories.TerritoryID = Territories.TerritoryID) EmployeeTerritories on EmployeeTerritories.EmployeeID = Orders.EmployeeID
where EmployeeTerritories.RegionID = 3;
set identity_insert NorthwindNorthernDB.dbo.Orders off

set identity_insert NorthwindSouthernDB.dbo.Orders on
insert into NorthwindSouthernDB.dbo.Orders -- HasIdentity
(RegionID,OrderID,CustomerID,EmployeeID,OrderDate,RequiredDate,ShippedDate,Orders.ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry)
select EmployeeTerritories.RegionID,Orders.OrderID,Orders.CustomerID,Orders.EmployeeID,Orders.OrderDate,Orders.RequiredDate,Orders.ShippedDate,Orders.ShipVia,Orders.Freight,Orders.ShipName,Orders.ShipAddress,Orders.ShipCity,Orders.ShipRegion,Orders.ShipPostalCode,Orders.ShipCountry
from Northwind.dbo.Orders
join 	(select distinct EmployeeID,RegionID 
		from Northwind.dbo.EmployeeTerritories
		join Northwind.dbo.Territories on EmployeeTerritories.TerritoryID = Territories.TerritoryID) EmployeeTerritories on EmployeeTerritories.EmployeeID = Orders.EmployeeID
where EmployeeTerritories.RegionID = 4;
set identity_insert NorthwindSouthernDB.dbo.Orders off

insert into PdbRegion
(RegionID,RegionDescription)
select RegionID,RegionDescription
from Northwind.dbo.Region;

insert into PdbTerritories
(TerritoryID,TerritoryDescription,RegionID)
select TerritoryID,TerritoryDescription,RegionID
from Northwind.dbo.Territories;

-- Updating Managers to employees between regions
select RegionID,EmployeeID into #PdbManagers from PdbEmployees;
update PdbEmployees
set ReportsTo = null
where ReportsTo is not null
and not exists (select top 1 1 
				from #PdbManagers PdbManagers
				where PdbEmployees.ReportsTo 	= PdbManagers.EmployeeID
				  and PdbEmployees.RegionID 	= PdbManagers.RegionID);
drop table #PdbManagers;

/****** Object:  Index [CategoryName] ******/
CREATE NONCLUSTERED INDEX [CategoryName] ON [dbo].[Categories]
(
	[CategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [City] ******/
CREATE NONCLUSTERED INDEX [City] ON [dbo].[Customers]
(
	[City] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CompanyName] ******/
CREATE NONCLUSTERED INDEX [CompanyName] ON [dbo].[Customers]
(
	[CompanyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PostalCode] ******/
CREATE NONCLUSTERED INDEX [PostalCode] ON [dbo].[Customers]
(
	[PostalCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Region] ******/
CREATE NONCLUSTERED INDEX [Region] ON [dbo].[Customers]
(
	[Region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [LastName] ******/
CREATE NONCLUSTERED INDEX [LastName] ON [dbo].[Employees]
(
	[LastName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PostalCode] ******/
CREATE NONCLUSTERED INDEX [PostalCode] ON [dbo].[Employees]
(
	[PostalCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [OrderID] ******/
CREATE NONCLUSTERED INDEX [OrderID] ON [dbo].[Order Details]
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [OrdersOrder_Details] ******/
CREATE NONCLUSTERED INDEX [OrdersOrder_Details] ON [dbo].[Order Details]
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ProductID] ******/
CREATE NONCLUSTERED INDEX [ProductID] ON [dbo].[Order Details]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ProductsOrder_Details] ******/
CREATE NONCLUSTERED INDEX [ProductsOrder_Details] ON [dbo].[Order Details]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CustomerID] ******/
CREATE NONCLUSTERED INDEX [CustomerID] ON [dbo].[Orders]
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CustomersOrders] ******/
CREATE NONCLUSTERED INDEX [CustomersOrders] ON [dbo].[Orders]
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [EmployeeID] ******/
CREATE NONCLUSTERED INDEX [EmployeeID] ON [dbo].[Orders]
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [EmployeesOrders] ******/
CREATE NONCLUSTERED INDEX [EmployeesOrders] ON [dbo].[Orders]
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [OrderDate] ******/
CREATE NONCLUSTERED INDEX [OrderDate] ON [dbo].[Orders]
(
	[OrderDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ShippedDate] ******/
CREATE NONCLUSTERED INDEX [ShippedDate] ON [dbo].[Orders]
(
	[ShippedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ShippersOrders] ******/
CREATE NONCLUSTERED INDEX [ShippersOrders] ON [dbo].[Orders]
(
	[ShipVia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [ShipPostalCode] ******/
CREATE NONCLUSTERED INDEX [ShipPostalCode] ON [dbo].[Orders]
(
	[ShipPostalCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [CategoriesProducts] ******/
CREATE NONCLUSTERED INDEX [CategoriesProducts] ON [dbo].[Products]
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [CategoryID] ******/
CREATE NONCLUSTERED INDEX [CategoryID] ON [dbo].[Products]
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [ProductName] ******/
CREATE NONCLUSTERED INDEX [ProductName] ON [dbo].[Products]
(
	[ProductName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [SupplierID] ******/
CREATE NONCLUSTERED INDEX [SupplierID] ON [dbo].[Products]
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [SuppliersProducts] ******/
CREATE NONCLUSTERED INDEX [SuppliersProducts] ON [dbo].[Products]
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CompanyName] ******/
CREATE NONCLUSTERED INDEX [CompanyName] ON [dbo].[Suppliers]
(
	[CompanyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PostalCode] ******/
CREATE NONCLUSTERED INDEX [PostalCode] ON [dbo].[Suppliers]
(
	[PostalCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [FK_Employees_Employees] FOREIGN KEY([ReportsTo])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Employees]
GO
ALTER TABLE [dbo].[EmployeeTerritories]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeTerritories_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[EmployeeTerritories] CHECK CONSTRAINT [FK_EmployeeTerritories_Employees]
GO
ALTER TABLE [dbo].[EmployeeTerritories]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeTerritories_Territories] FOREIGN KEY([TerritoryID])
REFERENCES [dbo].[Territories] ([TerritoryID])
GO
ALTER TABLE [dbo].[EmployeeTerritories] CHECK CONSTRAINT [FK_EmployeeTerritories_Territories]
GO
ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [FK_Order_Details_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [FK_Order_Details_Orders]
GO
ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [FK_Order_Details_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [FK_Order_Details_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [FK_Orders_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Employees]
GO
ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [FK_Orders_Shippers] FOREIGN KEY([ShipVia])
REFERENCES [dbo].[Shippers] ([ShipperID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Shippers]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Suppliers]
GO
ALTER TABLE [dbo].[Territories]  WITH CHECK ADD  CONSTRAINT [FK_Territories_Region] FOREIGN KEY([RegionID])
REFERENCES [dbo].[Region] ([RegionID])
GO
ALTER TABLE [dbo].[Territories] CHECK CONSTRAINT [FK_Territories_Region]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [CK_Birthdate] CHECK  (([BirthDate]<getdate()))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [CK_Birthdate]
GO
ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [CK_Discount] CHECK  (([Discount]>=(0) AND [Discount]<=(1)))
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [CK_Discount]
GO
ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [CK_Quantity] CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [CK_Quantity]
GO
ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [CK_UnitPrice] CHECK  (([UnitPrice]>=(0)))
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [CK_UnitPrice]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [CK_Products_UnitPrice] CHECK  (([UnitPrice]>=(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_Products_UnitPrice]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [CK_ReorderLevel] CHECK  (([ReorderLevel]>=(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_ReorderLevel]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [CK_UnitsInStock] CHECK  (([UnitsInStock]>=(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_UnitsInStock]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [CK_UnitsOnOrder] CHECK  (([UnitsOnOrder]>=(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_UnitsOnOrder]
GO


/****** Object:  View [dbo].[Product Sales for 1997] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Product Sales for 1997] AS
SELECT PdbCategories.CategoryName, PdbProducts.ProductName, 
Sum(CONVERT(money,("PdbOrder Details".UnitPrice*Quantity*(1-Discount)/100))*100) AS ProductSales
FROM (PdbCategories INNER JOIN PdbProducts ON PdbCategories.CategoryID = PdbProducts.CategoryID and PdbCategories.RegionID = PdbProducts.RegionID) 
	INNER JOIN (PdbOrders 
		INNER JOIN "PdbOrder Details" ON PdbOrders.OrderID = "PdbOrder Details".OrderID and PdbOrders.RegionID = "PdbOrder Details".RegionID) 
	ON PdbProducts.ProductID = "PdbOrder Details".ProductID AND PdbProducts.RegionID = "PdbOrder Details".RegionID
WHERE (((PdbOrders.ShippedDate) Between '19970101' And '19971231'))
GROUP BY PdbCategories.CategoryName, PdbProducts.ProductName

GO
/****** Object:  View [dbo].[Category Sales for 1997] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Category Sales for 1997] AS
SELECT "Product Sales for 1997".CategoryName, Sum("Product Sales for 1997".ProductSales) AS CategorySales
FROM "Product Sales for 1997"
GROUP BY "Product Sales for 1997".CategoryName

GO
/****** Object:  View [dbo].[Order Details Extended] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Order Details Extended] AS
SELECT "PdbOrder Details".RegionID, "PdbOrder Details".OrderID, "PdbOrder Details".ProductID, PdbProducts.ProductName, 
	"PdbOrder Details".UnitPrice, "PdbOrder Details".Quantity, "PdbOrder Details".Discount, 
	(CONVERT(money,("PdbOrder Details".UnitPrice*Quantity*(1-Discount)/100))*100) AS ExtendedPrice
FROM PdbProducts INNER JOIN "PdbOrder Details" ON PdbProducts.ProductID = "PdbOrder Details".ProductID AND PdbProducts.RegionID = "PdbOrder Details".RegionID
--ORDER BY "Order Details".OrderID

GO
/****** Object:  View [dbo].[Sales by Category] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Sales by Category] AS
SELECT PdbCategories.CategoryID, PdbCategories.CategoryName, PdbProducts.ProductName, 
	Sum("Order Details Extended".ExtendedPrice) AS ProductSales
FROM 	PdbCategories INNER JOIN 
		(PdbProducts INNER JOIN 
			(PdbOrders INNER JOIN "Order Details Extended" ON PdbOrders.OrderID = "Order Details Extended".OrderID AND PdbOrders.RegionID = "Order Details Extended".RegionID) 
		ON PdbProducts.ProductID = "Order Details Extended".ProductID AND PdbProducts.RegionID = "Order Details Extended".RegionID) 
	ON PdbCategories.CategoryID = PdbProducts.CategoryID AND PdbCategories.RegionID = PdbProducts.RegionID
WHERE PdbOrders.OrderDate BETWEEN '19970101' And '19971231'
GROUP BY PdbCategories.CategoryID, PdbCategories.CategoryName, PdbProducts.ProductName
--ORDER BY Products.ProductName

GO
/****** Object:  View [dbo].[Order Subtotals] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Order Subtotals] AS
SELECT "PdbOrder Details".OrderID, "PdbOrder Details".RegionID, Sum(CONVERT(money,("PdbOrder Details".UnitPrice*Quantity*(1-Discount)/100))*100) AS Subtotal
FROM "PdbOrder Details"
GROUP BY "PdbOrder Details".OrderID, "PdbOrder Details".RegionID

GO
/****** Object:  View [dbo].[Sales Totals by Amount] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Sales Totals by Amount] AS
SELECT "Order Subtotals".Subtotal AS SaleAmount, PdbOrders.OrderID, PdbCustomers.CompanyName, PdbOrders.ShippedDate
FROM 	PdbCustomers INNER JOIN 
		(PdbOrders INNER JOIN "Order Subtotals" ON PdbOrders.OrderID = "Order Subtotals".OrderID AND PdbOrders.RegionID = "Order Subtotals".RegionID) 
	ON PdbCustomers.CustomerID = PdbOrders.CustomerID AND PdbCustomers.RegionID = PdbOrders.RegionID
WHERE ("Order Subtotals".Subtotal >2500) AND (PdbOrders.ShippedDate BETWEEN '19970101' And '19971231')

GO
/****** Object:  View [dbo].[Summary of Sales by Quarter] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Summary of Sales by Quarter] AS
SELECT PdbOrders.ShippedDate, PdbOrders.OrderID, "Order Subtotals".Subtotal
FROM PdbOrders INNER JOIN "Order Subtotals" ON PdbOrders.OrderID = "Order Subtotals".OrderID AND PdbOrders.RegionID = "Order Subtotals".RegionID
WHERE PdbOrders.ShippedDate IS NOT NULL
--ORDER BY Orders.ShippedDate

GO
/****** Object:  View [dbo].[Summary of Sales by Year] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Summary of Sales by Year] AS
SELECT PdbOrders.ShippedDate, PdbOrders.OrderID, "Order Subtotals".Subtotal
FROM PdbOrders INNER JOIN "Order Subtotals" ON PdbOrders.OrderID = "Order Subtotals".OrderID AND PdbOrders.RegionID = "Order Subtotals".RegionID
WHERE PdbOrders.ShippedDate IS NOT NULL
--ORDER BY Orders.ShippedDate

GO
/****** Object:  View [dbo].[Alphabetical list of products] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Alphabetical list of products] AS
SELECT PdbProducts.*, PdbCategories.CategoryName
FROM PdbCategories INNER JOIN PdbProducts ON PdbCategories.CategoryID = PdbProducts.CategoryID AND PdbCategories.RegionID = PdbProducts.RegionID
WHERE (((PdbProducts.Discontinued)=0))

GO
/****** Object:  View [dbo].[Current Product List] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Current Product List] AS
SELECT Product_List.ProductID, Product_List.ProductName
FROM PdbProducts AS Product_List
WHERE (((Product_List.Discontinued)=0))
--ORDER BY Product_List.ProductName

GO
/****** Object:  View [dbo].[Customer and Suppliers by City] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Customer and Suppliers by City] AS
SELECT City, CompanyName, ContactName, 'Customers' AS Relationship 
FROM PdbCustomers
UNION SELECT City, CompanyName, ContactName, 'Suppliers'
FROM PdbSuppliers
--ORDER BY City, CompanyName

GO
/****** Object:  View [dbo].[Invoices] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Invoices] AS
SELECT PdbOrders.ShipName, PdbOrders.ShipAddress, PdbOrders.ShipCity, PdbOrders.ShipRegion, PdbOrders.ShipPostalCode, 
	PdbOrders.ShipCountry, PdbOrders.CustomerID, PdbCustomers.CompanyName AS CustomerName, PdbCustomers.Address, PdbCustomers.City, 
	PdbCustomers.Region, PdbCustomers.PostalCode, PdbCustomers.Country, 
	(FirstName + ' ' + LastName) AS Salesperson, 
	PdbOrders.OrderID, PdbOrders.OrderDate, PdbOrders.RequiredDate, PdbOrders.ShippedDate, PdbShippers.CompanyName As ShipperName, 
	"PdbOrder Details".ProductID, PdbProducts.ProductName, "PdbOrder Details".UnitPrice, "PdbOrder Details".Quantity, 
	"PdbOrder Details".Discount, 
	(CONVERT(money,("PdbOrder Details".UnitPrice*Quantity*(1-Discount)/100))*100) AS ExtendedPrice, PdbOrders.Freight
FROM 	PdbShippers INNER JOIN 
		(PdbProducts INNER JOIN 
			(
				(PdbEmployees INNER JOIN 
					(PdbCustomers INNER JOIN PdbOrders ON PdbCustomers.CustomerID = PdbOrders.CustomerID AND PdbCustomers.RegionID = PdbOrders.RegionID) 
				ON PdbEmployees.EmployeeID = PdbOrders.EmployeeID AND PdbEmployees.RegionID = PdbOrders.RegionID) 
			INNER JOIN "PdbOrder Details" ON PdbOrders.OrderID = "PdbOrder Details".OrderID AND PdbOrders.RegionID = "PdbOrder Details".RegionID) 
		ON PdbProducts.ProductID = "PdbOrder Details".ProductID AND PdbProducts.RegionID = "PdbOrder Details".ProductID) 
	ON PdbShippers.ShipperID = PdbOrders.ShipVia AND PdbShippers.RegionID = PdbOrders.RegionID

GO
/****** Object:  View [dbo].[Orders Qry] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[PdbOrders Qry] AS
SELECT PdbOrders.OrderID, PdbOrders.CustomerID, PdbOrders.EmployeeID, PdbOrders.OrderDate, PdbOrders.RequiredDate, 
	PdbOrders.ShippedDate, PdbOrders.ShipVia, PdbOrders.Freight, PdbOrders.ShipName, PdbOrders.ShipAddress, PdbOrders.ShipCity, 
	PdbOrders.ShipRegion, PdbOrders.ShipPostalCode, PdbOrders.ShipCountry, 
	PdbCustomers.CompanyName, PdbCustomers.Address, PdbCustomers.City, PdbCustomers.Region, PdbCustomers.PostalCode, PdbCustomers.Country
FROM PdbCustomers INNER JOIN PdbOrders ON PdbCustomers.CustomerID = PdbOrders.CustomerID AND PdbCustomers.RegionID = PdbOrders.RegionID

GO
/****** Object:  View [dbo].[Products Above Average Price] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Products Above Average Price] AS
SELECT PdbProducts.ProductName, PdbProducts.UnitPrice
FROM PdbProducts
WHERE PdbProducts.UnitPrice>(SELECT AVG(UnitPrice) From PdbProducts)
--ORDER BY Products.UnitPrice DESC

GO
/****** Object:  View [dbo].[Products by Category] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Products by Category] AS
SELECT PdbCategories.CategoryName, PdbProducts.ProductName, PdbProducts.QuantityPerUnit, PdbProducts.UnitsInStock, PdbProducts.Discontinued
FROM PdbCategories INNER JOIN PdbProducts ON PdbCategories.CategoryID = PdbProducts.CategoryID AND PdbCategories.RegionID = PdbProducts.RegionID
WHERE PdbProducts.Discontinued <> 1
--ORDER BY Categories.CategoryName, Products.ProductName

GO
/****** Object:  View [dbo].[Quarterly Orders] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Quarterly Orders] AS
SELECT DISTINCT PdbCustomers.CustomerID, PdbCustomers.CompanyName, PdbCustomers.City, PdbCustomers.Country
FROM PdbCustomers RIGHT JOIN PdbOrders ON PdbCustomers.CustomerID = PdbOrders.CustomerID AND PdbCustomers.RegionID = PdbOrders.RegionID
WHERE PdbOrders.OrderDate BETWEEN '19970101' And '19971231'

GO


/****** Object:  StoredProcedure [dbo].[CustOrderHist] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CustOrderHist] @CustomerID nchar(5)
AS
SELECT ProductName, Total=SUM(Quantity)
FROM PdbProducts P, [PdbOrder Details] OD, PdbOrders O, PdbCustomers C
WHERE C.CustomerID = @CustomerID
AND C.CustomerID = O.CustomerID AND O.OrderID = OD.OrderID AND OD.ProductID = P.ProductID
AND C.RegionID = O.RegionID and O.RegionID = OD.RegionID and OD.RegionID = P.RegionID -- NEW
GROUP BY ProductName

GO
/****** Object:  StoredProcedure [dbo].[CustOrdersDetail] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CustOrdersDetail] @OrderID int
AS
SELECT ProductName,
    UnitPrice=ROUND(Od.UnitPrice, 2),
    Quantity,
    Discount=CONVERT(int, Discount * 100), 
    ExtendedPrice=ROUND(CONVERT(money, Quantity * (1 - Discount) * Od.UnitPrice), 2)
FROM PdbProducts P, [PdbOrder Details] Od
WHERE Od.ProductID = P.ProductID and Od.OrderID = @OrderID
AND Od.RegionID = P.RegionID -- NEW
GO
/****** Object:  StoredProcedure [dbo].[CustOrdersOrders] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CustOrdersOrders] @CustomerID nchar(5)
AS
SELECT OrderID, 
	OrderDate,
	RequiredDate,
	ShippedDate
FROM PdbOrders
WHERE CustomerID = @CustomerID
ORDER BY OrderID

GO
/****** Object:  StoredProcedure [dbo].[SalesByCategory] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SalesByCategory]
    @CategoryName nvarchar(15), @OrdYear nvarchar(4) = '1998'
AS
IF @OrdYear != '1996' AND @OrdYear != '1997' AND @OrdYear != '1998' 
BEGIN
	SELECT @OrdYear = '1998'
END

SELECT ProductName,
	TotalPurchase=ROUND(SUM(CONVERT(decimal(14,2), OD.Quantity * (1-OD.Discount) * OD.UnitPrice)), 0)
FROM [PdbOrder Details] OD, PdbOrders O, PdbProducts P, PdbCategories C
WHERE OD.OrderID = O.OrderID 
	AND OD.ProductID = P.ProductID 
	AND P.CategoryID = C.CategoryID
	AND C.CategoryName = @CategoryName
	AND OD.RegionID = O.RegionID -- NEW
	AND OD.RegionID = P.RegionID -- NEW
	AND P.RegionID = C.RegionID -- NEW
	AND SUBSTRING(CONVERT(nvarchar(22), O.OrderDate, 111), 1, 4) = @OrdYear
GROUP BY ProductName
ORDER BY ProductName

GO
/****** Object:  StoredProcedure [dbo].[Ten Most Expensive Products] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Ten Most Expensive Products] @RegionID int AS  -- NEW
SET ROWCOUNT 10
SELECT PdbProducts.ProductName AS TenMostExpensiveProducts, PdbProducts.UnitPrice
FROM PdbProducts
where RegionId = @RegionID
ORDER BY PdbProducts.UnitPrice DESC

GO