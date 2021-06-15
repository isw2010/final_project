select CALL_NO as Callid,cust_id,CALL_TYPE,OriginCountry,DestinationCountry,cell_origin,CALL_DATETIME
,case when OriginCountry ='972' then substring(calling_no,5,2) else 1 end as OriginOperator
,case when DestinationCountry ='972' then substring(DES_NO,5,2) else 1 end as DestinationOperator
,[TYPE],DURATION,(DURATION - [numberoffreeminutes]) as BilablleDuration
,RATED_AMNT as Amount,([discountpct]*RATED_AMNT) as BilablleAmount
from
(select call_no,calling_no,DES_NO,cust_id,CALL_TYPE,cell_origin,CALL_DATETIME,DURATION,RATED_AMNT
	, substring(calling_no,2,3)as OriginCountry
	, substring(DES_NO,2,3)as DestinationCountry
	from STG.USAGE_MAIN left join STG.XXCOUNTRYPRE
    on substring(calling_no,2,3) like COUNTRY_PRE and substring(DES_NO,2,3) like COUNTRY_PRE ) as ss
	join (select PHONE_NO,[TYPE],numberoffreeminutes,discountpct 
	from stg.customer_lines) as sss on PHONE_NO = calling_no