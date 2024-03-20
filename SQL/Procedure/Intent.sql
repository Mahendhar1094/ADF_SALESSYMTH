CREATE   PROCEDURE [dbo].[Intent]
AS
BEGIN
	
	MERGE INTO [dbo].[SalesSmyth_Intent_Table] AS target
    USING [dbo].SalesSmyth_Intent_RAW AS source
    ON (target.Intent_ID+target.ZoomInfo_Company_ID+target.Topic+target.Intent_Date= source.[Intent ID]+source.[Company ID]+source.Topic+source.[Date]) and source.Score >= target.Score
    WHEN MATCHED THEN
    UPDATE SET target.Buyer_Strength = Right(SUBSTRING(source.Topic_Name, 1, CHARINDEX('.', source.Topic_Name) - 1),1)
    WHEN NOT MATCHED THEN
       
   
    INSERT (ZoomInfo_Company_ID, Intent_ID, Intent_Date, Topic, Category, Score,Buyer_Strength,SalesSmyth_Topic)
    Values(
           [Company ID],
           [Intent ID],
           Convert(varchar,[Date],104),
           source.Topic,
           source.Category,
           source.Score,
           Right(SUBSTRING(Topic_Name, 1, CHARINDEX('.', Topic_Name) - 1),1),
		   SUBSTRING(Topic_Name, 1, CHARINDEX('_', Topic_Name) - 1));
   
    -- Update [SalesSmyth_Intent_Table] with calculated values
    UPDATE SI
    SET SI.Intent_Week = DATEPART(week, SI.Intent_Date),
        SI.Intent_Month = DATENAME(Month, SI.Intent_Date)
    FROM [dbo].[SalesSmyth_Intent_Table] AS SI
			
	
	UPDATE SI
    SET SI.Client_Account_ID=SC.Client_Account_Id
    FROM [dbo].[SalesSmyth_Intent_Table] AS SI
	JOIN [dbo].[SalesSmyth_Company_Table] SC
	ON SI.ZoomInfo_Company_ID=SC.ZoomInfo_Company_ID

	UPDATE SI
    SET SI.[Date]= Cast(SI.Intent_Date as Date)
    FROM [dbo].[SalesSmyth_Intent_Table] AS SI

	UPDATE SI
    SET SI.[Decision Stage]= CASE WHEN SI.Score<=70 THEN 'Purchase Intent'
								  WHEN SI.Score>70 and SI.Score<=80 THEN 'Evaluation'
								  WHEN SI.Score>80 and SI.Score<=90 THEN 'Consideration'
								  ELSE 'Early Awareness' END
    FROM [dbo].[SalesSmyth_Intent_Table] AS SI

	UPDATE SI
	SET SI.Match_Tpid=UT.TPID
	FROM [dbo].[SalesSmyth_Intent_Table] AS SI
	JOIN [dbo].[UserRequested_TPID] as UT
	on SI.Client_Account_ID=UT.TPID

	
Insert Into Sales_Symth_Intent_Pivot([ZoomInfo_Company_ID],[Client_Account_ID],[Date] )
Select Distinct [ZoomInfo_Company_ID] ,
[Client_Account_ID] ,
[Date]  from [SalesSmyth_Intent_Table] AM
Where AM.Client_Account_Id+'_'+CONVERT(VARCHAR ,AM.[Date])  not in
(Select AI.Client_Account_Id+'_'+CONVERT(VARCHAR ,AI.[Date]) from [dbo].[Sales_Symth_Intent_Pivot] AI)

UPDATE AI
SET AI.[Intent Topic of Interest Salesforce]=  AM.[Buyer_Strength]
From Sales_Symth_Intent_Pivot AI
JOIN [SalesSmyth_Intent_Table] AM
on AM.Client_Account_Id+'_'+CONVERT(VARCHAR ,AM.[Date])=AI.Client_Account_Id+'_'+CONVERT(VARCHAR ,AI.[Date])
where AM.Topic='Salesforce'

UPDATE AI
SET AI.[Intent Topic of Interest Salesforce Sales Cloud]= AM.[Buyer_Strength]
From Sales_Symth_Intent_Pivot AI
JOIN [SalesSmyth_Intent_Table] AM
on AM.Client_Account_Id+'_'+CONVERT(VARCHAR ,AM.[Date])=AI.Client_Account_Id+'_'+CONVERT(VARCHAR ,AI.[Date])
where AM.Topic='Salesforce Sales Cloud'

UPDATE AI
SET AI.[Intent Topic of Interest Microsoft Dynamics CRM]= AM.[Buyer_Strength]
From Sales_Symth_Intent_Pivot AI
JOIN [SalesSmyth_Intent_Table] AM
on AM.Client_Account_Id+'_'+CONVERT(VARCHAR ,AM.[Date])=AI.Client_Account_Id+'_'+CONVERT(VARCHAR ,AI.[Date])
where AM.Topic='Microsoft Dynamics CRM'

UPDATE AI
SET AI.[Intent Topic of Interest Salesforce Consulting]= AM.[Buyer_Strength]
From Sales_Symth_Intent_Pivot AI
JOIN [SalesSmyth_Intent_Table] AM
on AM.Client_Account_Id+'_'+CONVERT(VARCHAR ,AM.[Date])=AI.Client_Account_Id+'_'+CONVERT(VARCHAR ,AI.[Date])
where AM.Topic='Salesforce Consulting'

UPDATE AI
SET AI.[Intent Topic of Interest Salesforce Marketing Cloud]= AM.[Buyer_Strength]
From Sales_Symth_Intent_Pivot AI
JOIN [SalesSmyth_Intent_Table] AM
on AM.Client_Account_Id+'_'+CONVERT(VARCHAR ,AM.[Date])=AI.Client_Account_Id+'_'+CONVERT(VARCHAR ,AI.[Date])
where AM.Topic='Salesforce Marketing Cloud'

UPDATE AI
SET AI.[Intent Topic of Interest Salesforce Einstein]= AM.[Buyer_Strength]
From Sales_Symth_Intent_Pivot AI
JOIN [SalesSmyth_Intent_Table] AM
on AM.Client_Account_Id+'_'+CONVERT(VARCHAR ,AM.[Date])=AI.Client_Account_Id+'_'+CONVERT(VARCHAR ,AI.[Date])
where AM.Topic='Salesforce Einstein'


UPDATE AI
SET AI.[Avg.Buyer_Strenght] = AM.AvgBuyerStrength
FROM Sales_Symth_Intent_Pivot AI
JOIN (
    SELECT 
        Client_Account_Id + '_' + CONVERT(VARCHAR, [Date]) AS Client_Date,
        AVG(Convert(INT,Buyer_Strength)) AS AvgBuyerStrength
    FROM [SalesSmyth_Intent_Table]
    GROUP BY Client_Account_Id, [Date]
) AM ON AI.Client_Account_Id + '_' + CONVERT(VARCHAR, AI.[Date]) = AM.Client_Date;

UPDATE AI
SET AI.[Avg.Intent Score] = AM.AvgIntentscore
FROM Sales_Symth_Intent_Pivot AI
JOIN (
    SELECT 
        Client_Account_Id + '_' + CONVERT(VARCHAR, [Date]) AS Client_Date,
        AVG(Convert(INT,Score)) AS AvgIntentscore
    FROM [SalesSmyth_Intent_Table]
    GROUP BY Client_Account_Id, [Date]
) AM ON AI.Client_Account_Id + '_' + CONVERT(VARCHAR, AI.[Date]) = AM.Client_Date;

   Exec  ZOOMINFO 

  Delete from [dbo].SalesSmyth_Intent_RAW  


END; 
GO

