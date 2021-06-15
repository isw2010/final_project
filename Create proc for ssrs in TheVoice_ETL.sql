  Create proc sp_transaction
  @fromtime nvarchar(50)  = null
  as 
  begin
SELECT      distinct  FACT.FactUsage.CallId, FACT.FactUsage.Duration, FACT.FactUsage.BillableDuration, FACT.FactUsage.Amount, FACT.FactUsage.BillableAmount,  DIM.DimDate.DescYear[Year]
FROM            FACT.FactUsage INNER JOIN
                         DIM.DimDate ON FACT.FactUsage.KeyCallDate = DIM.DimDate.KeyDate
  
  where (@fromtime is null)
  or DescYear = @fromtime 
  end
sp_transaction 