USE [TheVoice]
GO

/****** Object:  StoredProcedure [dbo].[insert_usage_main]    Script Date: 06/04/2021 11:21:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[insert_usage_main]    Script Date: 15/03/2021 00:17:00 ******/

CREATE OR ALTER   PROCEDURE [dbo].[insert_usage_main]   
  
AS 
DECLARE @last_date datetime	
set @last_date = (select max(CALL_DATETIME) from USAGE_MAIN )

DECLARE @date datetime	= @last_date

declare @number_call_per_day int

	while @date < dateAdd(YEAR,1,@last_date)
	begin
	set @number_call_per_day = 20  

	declare @ENDDAY datetime = DATEADD(DAY, 1, @DATE)
	declare @SEIZED_TIME  datetime = @date
	while @number_call_per_day > 0 
		begin
		DECLARE @Seconds INT = DATEDIFF(SECOND , @SEIZED_TIME, @ENDDAY)
		DECLARE @RANDSECOND INT=  RAND()*(@Seconds/@number_call_per_day -1) 
		declare @randAnswer int = rand ()* (35 -1)
		SET @SEIZED_TIME =  DATEADD (SECOND, @RANDSECOND,  @SEIZED_TIME)		
		declare @answer_time datetime = dateadd (second ,@randAnswer,@SEIZED_TIME)
		declare @custid int = (select top 1 customer_id from [dbo].[customer] order by NEWID())
		declare @randDisconnect int = rand()* (1000)
		declare @DISCONNECT_TIME datetime = dateadd (second ,@randDisconnect,@answer_time)
		declare @DURATION int =( DATEDIFF(MINUTE, @answer_time , @DISCONNECT_TIME))
		declare @CALLING_NO varchar(20) = (select CUST_NUMBER from [dbo].[customer] where customer_id = @custid)
		--call type
		 declare  @priceperminuter decimal (10,2),
		 @call_type varchar (10),
		 @call_type_desc varchar (20)		 
		select  top 1 @call_type = call_type_code ,@call_type_desc = call_type_desc,
		@priceperminuter = priceperminuter
		FROM [TheVoice].[dbo].[call_type]
		order by NEWID ()

		 declare @RATED_AMNT int = @priceperminuter * @DURATION
		 declare @called_NO varchar (18) = (select top 1 CALLED_NO from [dbo].[USAGE_MAIN]
		  where CUST_ID  != @custid order by NEWID ())
		 declare @DES_NO varchar (25) = @called_NO 
		 declare @cell int  if  @called_NO like '+121%' set  @cell =0 else set @cell = 1
		 declare @cell_origin int  if  @CALLING_NO like '+121%' set  @cell_origin =0 else set @cell_origin = 1
		 
		 --declare @rated_curr_code varchar(10) = (select INVOICE_CURRNCY from CUSTOMER_INVOICE
			--where PHONE_NO = @CALLING_NO)
		--high_low_rate
		declare @high_low_rate int;
		declare @hour_call int = DATEPART(Hour, @SEIZED_TIME)
		if @hour_call > 11 AND @hour_call < 18
		  set @high_low_rate = 1 
		 else set @high_low_rate = 0 
		--insert
		INSERT INTO dbo.USAGE_MAIN (CALL_DATETIME,SEIZED_TIME,ANSWER_TIME,
		DISCONNECT_TIME,CUST_ID,CALLING_NO,DURATION,call_type,PROD_TYPE,RATED_AMNT,
		CALLED_NO,DES_NO,cell,CELL_ORIGIN, RATED_CURR_CODE,insert_DATE, update_date, HIGH_LOW_RATE)
		VALUES (@date,@SEIZED_TIME,@answer_time,@answer_time,@custid,
		@CALLING_NO,@DURATION,@call_type,@call_type_desc,@RATED_AMNT,@called_NO,@DES_NO,@cell,
		@cell_origin,'SHEKEL', GETDATE(), GetDate(),@high_low_rate)

		set @number_call_per_day = @number_call_per_day - 1
	
		end 
		set @date =  DATEADD(DAY, 1,@date) 
	end
GO

--exec [dbo].[insert_usage_main]
