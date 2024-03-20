Create    Procedure  [dbo].[SalesSymth_data]
as
Begin
    
Insert into [dbo].[SalesSmyth_Company_Table](Client_Account_Id,SalesSmyth_Client_ID,SalesSmyth_Company_ID,HQ_DS_Flag,Account_Name,Segment,SubSegment,
Region,SubRegion,Country,Sales_Team_Unit,Sales_Unit,Industry,Vertical)
select  Distinct     Client_Account_Id
					,SalesSmyth_Client_ID
					,ROW_NUMBER() OVER (ORDER BY Client_Account_Id)+52000
					,[HQ_DS Flag]
					,Account_Name
					,Segment
					,SubSegment
					,Region
					,SubRegion
					,Country
					,Sales_Team_Unit
					,Sales_Unit
					,Industry
					,Vertical
from [dbo].[SalesSmyth_Client_Accounts_Table_RAW] AM
Where AM.Client_Account_Id not in(Select Client_Account_Id from [dbo].[SalesSmyth_Company_Table])

END
GO