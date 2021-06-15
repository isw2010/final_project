declare @starttime datetime
declare @endtime datetime
	select @starttime = min( CONVERT(VARCHAR(5),ANSWER_TIME,108) ),
           @endtime =  max(CONVERT(VARCHAR(5),ANSWER_TIME,108)) 
	from [TheVoice].[dbo].[USAGE_MAIN]
	while  @starttime <= @endtime
	begin insert into [DIM].[DimTime] (
		[KeyTime]
      ,[FullTime]
      ,[CodeHour]
      ,[DescHour]
      ,[KeyMinute]
      ,[CodeMinute]
      ,[DescMinute]
	  )
SELECT CONVERT(INT, REPLACE( CONVERT(VARCHAR(6), @starttime, 108), ':', '' ) ) AS KeyTime
,FORMAT( @starttime, 'HH:mm', 'en-US' ) as FullTime
,cast(CONVERT(VARCHAR(20),FORMAT( @starttime, 'HH', 'en-us' ),108) as int) as CodeHour
,cast(CONVERT(VARCHAR(20),FORMAT( @starttime, 'HH', 'en-us' ),108) as nVARCHAR) as DescHour
,CONVERT(INT, REPLACE( CONVERT(VARCHAR(6), @starttime, 108), ':', '' ) ) AS KeyMinute
,cast(CONVERT(VARCHAR(20),FORMAT( @starttime, 'mm', 'en-us' ),108) as int) as CodeMinute
,cast(CONVERT(VARCHAR(20),FORMAT( @starttime, 'mm', 'en-us' ),108) as nvarchar) as DescMinute
set @starttime = dateadd(MINUTE, 1, @starttime)
end