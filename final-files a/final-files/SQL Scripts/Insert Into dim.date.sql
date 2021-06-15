declare @startdate datetime
declare @enddate datetime
	select @startdate = min(CALL_DATETIME),
           @enddate = DATEADD(dd, 100, max(CALL_DATETIME)) 
	from [TheVoice].[dbo].[USAGE_MAIN]
	while  @startdate <= @enddate
	begin insert into DIM.DimDate (
       [KeyDate]
      ,[FullDate]
      ,[KeyYear]
      ,[CodeYear]
      ,[DescYear]
      ,[KeyMonth]
      ,[CodeMonth]
      ,[DescMonth]
      ,[CodeDayInWeek]
      ,[DescDayInWeek]
	  )
	  select cast(CONVERT(varchar(20),@startdate,112) as INT)
	  , @startdate, year(@startdate)
	  , year(@startdate)
	  , DateName(year,@startdate)
	  , cast(CONVERT(varchar(6), @startdate,112) as INT)
	  , month(@startdate)
	  , DATENAME(month, @startdate)
	  , datepart(dw,@startdate)
	  , datename(dw,@startdate)
	  set @startdate = dateadd(dd, 1, @startdate)
	  end