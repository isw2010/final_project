use master

IF EXISTS ( select * from sys.databases where name='TheVoice_ETL' ) 
begin

	alter database [TheVoice_ETL] set single_user with rollback immediate
	Drop DataBase TheVoice_ETL
	
end
Create DataBase TheVoice_ETL
Go
	Use TheVoice_ETL
GO
--------------------Create Schema
Create Schema MRR;
GO
Create Schema STG;
GO
Create Schema DIM;
GO
 Create Schema FACT;
GO
 Create Schema Integration;
GO
--------------------End Create Schema
CREATE TABLE [MRR].[call_type](
	[call_type_code] [nvarchar](100) NULL,
	[call_type_desc] [nvarchar](100) NULL,
	[priceperminuter] [decimal](10, 2) NULL,
	[call_type] [nvarchar](50) NULL,
	[SysStartTime] [datetime2](7) NULL,
	[SysEndTime] [datetime2](7) NULL
) ON [PRIMARY]

CREATE TABLE [MRR].[countries](
	[COUNTRY_CODE] [varchar](100) NULL,
	[DESC] [varchar](100) NULL,
	[REGION] [varchar](100) NULL,
	[AREA] [varchar](100) NULL,
	[insert_date] [datetime] NULL,
	[update_date] [datetime] NULL,
	[SysStartTime] [datetime2](7) NULL,
	[SysEndTime] [datetime2](7) NULL
) ON [PRIMARY]

CREATE TABLE [MRR].[customer](
	[customer_id] [int] NOT NULL,
	[CUST_NUMBER] [varchar](20) NOT NULL,
	[cust_name] [varchar](100) NULL,
	[address] [varchar](100) NULL,
	[insert_date] [datetime] NULL,
	[update_date] [datetime] NULL,
	[SysStartTime] [datetime2](7) NULL,
	[SysEndTime] [datetime2](7) NULL
)

CREATE TABLE [MRR].[CUSTOMER_INVOICE](
	[INVOICE_NUM] [int] NULL,
	[PHONE_NO] [varchar](20) NULL,
	[INVOICE_TYPE] [varchar](10) NULL,
	[INVOICE_DATE] [datetime] NULL,
	[INVOICE_IND] [tinyint] NULL,
	[INVOICE_DESC] [varchar](100) NULL,
	[INVOICE_CURRNCY] [varchar](10) NULL,
	[INVOICE_AMOUNT] [decimal](10, 4) NULL,
	[insert_date] [datetime] NULL,
	[update_date] [datetime] NULL,
	[SysStartTime] [datetime2](7) NULL,
	[SysEndTime] [datetime2](7) NULL
)

CREATE TABLE [MRR].[customer_lines](
	[PHONE_NO] [varchar](20) NULL,
	[createdate] [datetime] NULL,
	[enddate] [datetime] NULL,
	[status] [varchar](4) NULL,
	[TYPE] [varchar](10) NULL,
	[DESC] [varchar](100) NULL,
	[insert_date] [datetime] NULL,
	[update_date] [datetime] NULL,
	[discountpct] [int] NULL,
	[numberoffreeminutes] [int] NULL,
	[SysStartTime] [datetime2](7) NULL,
	[SysEndTime] [datetime2](7) NULL
)

CREATE TABLE [MRR].[OPFILEOPP](
	[OPCCC] [nvarchar](100) NULL,
	[OPDDD] [nvarchar](100) NULL,
	[prepre] [nvarchar](100) NULL,
	[SysStartTime] [datetime2](7) NULL,
	[SysEndTime] [datetime2](7) NULL
)

CREATE TABLE [MRR].[Package_Catalog](
	[PACKAGE_NUM] [int] NOT NULL,
	[createdate] [datetime] NULL,
	[enddate] [datetime] NULL,
	[status] [varchar](4) NULL,
	[pack_type] [varchar](10) NULL,
	[pack_desc] [varchar](100) NULL,
	[insert_date] [datetime] NULL,
	[update_date] [datetime] NULL
)

CREATE TABLE [MRR].[USAGE_MAIN](
	[CALL_NO] [int] IDENTITY(1,1) NOT NULL,
	[ANSWER_TIME] [datetime] NOT NULL,
	[SEIZED_TIME] [datetime] NOT NULL,
	[DISCONNECT_TIME] [datetime] NOT NULL,
	[CALL_DATETIME] [datetime] NULL,
	[CALLING_NO] [varchar](18) NULL,
	[CALLED_NO] [varchar](18) NULL,
	[DES_NO] [varchar](25) NULL,
	[DURATION] [int] NULL,
	[CUST_ID] [int] NULL,
	[CALL_TYPE] [varchar](20) NULL,
	[PROD_TYPE] [varchar](20) NULL,
	[RATED_AMNT] [int] NULL,
	[RATED_CURR_CODE] [varchar](10) NULL,
	[CELL] [int] NULL,
	[CELL_ORIGIN] [int] NULL,
	[HIGH_LOW_RATE] [int] NULL,
	[insert_DATE] [datetime] NULL,
	[update_date] [datetime] NULL,
)

CREATE TABLE [MRR].[XXCOUNTRYPRE](
	[COUNTRY_CODE] [varchar](100) NOT NULL,
	[COUNTRY_PRE] [varchar](3) NULL,

)

----------------------------------END MRR

CREATE TABLE [STG].[call_type](
	KeyCallType int identity (1,1),
	call_type_code nvarchar(100) not NULL,
	call_type_desc nvarchar(100) NULL,
	priceperminuter decimal(10, 2) NULL,
	call_type nvarchar(50) NULL
	Primary Key (KeyCallType)
)

Create table STG.XXCOUNTRYPRE(
	COUNTRY_PRE varchar(3) NULL,
	COUNTRY_CODE varchar(100) NOT NULL
)

Create table STG.countries(
	COUNTRY_CODE varchar(100) NULL,
	REGION varchar(100) NULL,
	AREA varchar(100) NULL
)

Create table STG.Package_Catalog(
	PACKAGE_NUM int NOT NULL,
	pack_desc varchar(100) NULL,
	createdate datetime NULL,
	enddate datetime NULL,
	[status] varchar(4) NULL,
	[pack_type] [varchar](10) NULL,
)

Create table STG.OPFILEOPP(
	OPCCC nvarchar(100) NULL,
	OPDDD nvarchar(100) NULL,
	prepre nvarchar(100) NULL
)

Create table STG.customer_lines(
	PHONE_NO varchar(20) NULL,
	[DESC] varchar(100) NULL,
	[discountpct] float NULL,
	[TYPE] [varchar](10) NULL,
	[numberoffreeminutes] [int] NULL
)

Create table STG.customer(
	customer_id int NOT NULL,
	CUST_NUMBER varchar(20) NOT NULL,
	cust_name varchar(100) NULL,
	address varchar(100) NULL
)

CREATE TABLE stg.USAGE_MAIN(
	CALL_NO int NOT NULL,
	ANSWER_TIME datetime NOT NULL,
	SEIZED_TIME datetime NOT NULL,
	CALL_DATETIME datetime NULL,
	CALLING_NO nvarchar(18) NULL,
	DES_NO nvarchar(25) NULL,
	DURATION int NULL,
	CUST_ID int NULL,
	CALL_TYPE nvarchar (20) NULL,
	PROD_TYPE nvarchar(20) NULL,
	RATED_AMNT int NULL,
	CELL_ORIGIN int NULL,
	Primary Key (CALL_NO)
)

----------------------------------END STG

Create table Dim.DimCallTypes
(
	SKeyCallType int identity (100,1),
	KeyCallType int,
	DescCallTypeCode nvarchar(100),
	DescCallType nvarchar(100),
	DescFullCallType nvarchar(200),
	DescCallTypePriceCategory nvarchar(100),
	DescCallTypeCategory nvarchar(100),
	IsCurrent nvarchar(100),
	StartTime Datetime,
	Endtime Datetime
	Primary Key (SKeyCallType)
)

	Create table Dim.DimCountries
(
	[SKeyCountry] [int] IDENTITY(100,1) NOT NULL,
	[KeyCountry] [int] NULL,
	[DescCountry] [nvarchar](100) NULL,
	[DescRegion] [nvarchar](100) NULL,
	[DescArea] [nvarchar](100) NULL
	Primary Key (SKeyCountry)
)

	Create table Dim.DimPackageCatalog
(
	SKeyPackage int identity (100,1),
	KeyPackage int,
	DescPackage nvarchar(120),
	DatePackageCreation date,
	DatePackageEnd date,
	DescPackageStatus nvarchar(100),
	CodePackageActivitiesDays int,
	IsCurrent nvarchar(100),
	StartTime Datetime,
	Endtime Datetime
	Primary Key (SKeyPackage)
)

	Create table Dim.DimOperators
(
	SKeyOperator int identity (100,1),
	KeyOperator int,
	DescOperator nvarchar(50),
	DescKeyPrefix nvarchar(100),
	IsCurrent nvarchar(100),
	StartTime Datetime,
	Endtime Datetime
	Primary Key (SKeyOperator)
)

	Create table Dim.DimCustomers
(
	SKeyCustomer int identity (100,1),
	KeyCustomer	int,
	DescCustomerLineOperator nvarchar(50),
	DescCustomerLineCountry nvarchar(100),
	DescCustomerName nvarchar(100),
	DescCustomerAddress nvarchar(100),
	DescCusomterPackage nvarchar(100),
	IsCurrent nvarchar(100),
	StartTime Datetime,
	Endtime Datetime
	Primary Key (SKeyCustomer)
)

	Create table Dim.DimCallOriginType
(
	SKeyCallOriginType int identity (100,1),
	KeyCallOriginType int,
	DescCallOriginType nvarchar(100),
	IsCurrent nvarchar(100),
	StartTime Datetime,
	Endtime Datetime
	Primary Key (SKeyCallOriginType)
)

	Create table Fact.FactUsage
(
	CallId int,
	SKeyCustomer int,
	SKeyCallType int,
	SKeyOriginCountry int,
	SKeyDestinationCountry int,
	SKeyOriginOperator int,
	SKeyDestinationOperator int,
	SKeyPackage int,
	SKeyCallOriginType int,
	KeyCallDate int,
	KeyCallTime int,
	Duration int,
	BillableDuration int,
	Amount float,
	BillableAmount float
	Primary Key (CallId)
)

create table dim.DimDate(
	 KeyDate int not NULL identity(1,1)
	,FullDate date
	,KeyYear int
	,CodeYear int
	,DescYear nvarchar(50)
	,KeyMonth int
	,CodeMonth int
	,DescMonth nvarchar(50)
	,CodeDayInWeek int
	,DescDayInWeek nvarchar(50)
	Primary Key (KeyDate)
)

Create table Dim.DimTime(
KeyTime	int,
FullTime time(0),
CodeHour int,
DescHour nvarchar(50),
KeyMinute int,
CodeMinute int,
DescMinute nvarchar(50)
Primary Key (KeyTime)
)

alter table fact.factusage 
ADD  CONSTRAINT FK_SKeyCallOriginType
	 FOREIGN KEY ([SKeyCallOriginType]) REFERENCES [DIM].[DimCallOriginType]([SKeyCallOriginType]),
	 CONSTRAINT FK_SKeyCallType
	 FOREIGN KEY ([SKeyCallType]) REFERENCES [DIM].[DimCallTypes]([SKeyCallType]),
	 CONSTRAINT FK_SKeyOriginCountry
	 FOREIGN KEY (SKeyOriginCountry) REFERENCES [DIM].[DimCountries]([SKeyCountry]),
	 CONSTRAINT FK_SKeyDestinationCountry
	 FOREIGN KEY ([SKeyDestinationCountry]) REFERENCES [DIM].[DimCountries]([SKeyCountry]),
	 CONSTRAINT FK_SKeyCustomer
	 FOREIGN KEY ([SKeyCustomer]) REFERENCES [DIM].[DimCustomers]([SKeyCustomer]),
	 CONSTRAINT FK_SKeyOriginOperator
	 FOREIGN KEY ([SKeyOriginOperator]) REFERENCES [DIM].[DimOperators]([SKeyOperator]),
	 CONSTRAINT FK_SKeyDestinationOperator
	 FOREIGN KEY ([SKeyDestinationOperator]) REFERENCES [DIM].[DimOperators]([SKeyOperator]),
	 CONSTRAINT FK_SKeyPackage
	 FOREIGN KEY ([SKeyPackage]) REFERENCES [DIM].[DimPackageCatalog]([SKeyPackage]),
	 CONSTRAINT FK_KeyCallDate
	 FOREIGN KEY ([KeyCallDate]) REFERENCES [DIM].[DimDate]([KeyDate]),
	 CONSTRAINT FK_KeyCallTime
	 FOREIGN KEY ([KeyCallTime]) REFERENCES [DIM].[DimTime]([KeyTime])


----------------------------------END DIM

create table Integration.lineage(
[lineage key] int not null identity,
[Data Load Started] Datetime2(7) not null,
[Table Name] [sysname] not null,
[Computer Name] [sysname] not null,
[User Name] [sysname] not null,
[Package Name] [sysname] not null
 CONSTRAINT [PK_Integration_Lineage] PRIMARY KEY CLUSTERED 
(
	[Lineage Key] ASC
))