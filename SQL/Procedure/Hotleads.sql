CREATE OR ALTER     Procedure [dbo].[Hot_Leed]
As
begin

	Insert Into [dbo].[SalesSmyth_Hot_Leads_Table](ZoomInfo_Company_ID,Hot_Lead_ID,Hot_Lead_Type,Hot_Lead_Topic,
													Hot_Lead_Description,Hot_Lead_Date_Published,
													Hot_Lead_Date_Updated,Hot_Lead_Updated_Text,Hot_Lead_Url,
													Hot_Lead_Url_Text,SalesSmyth_Topic)
	Select Distinct [ZoomInfo Company ID],
					[Scoop ID],
					[Scoop Types],
					[Scoop Topics],
					[Scoop Description],
					Convert(Varchar,[Scoop Date Published],103),
					[Scoop Date Updated],
					[Scoops Updated Text],
					[Scoop Url],
					[Scoop Url Text],
					SUBSTRING(Topic_Name, 1, CHARINDEX('_', Topic_Name) - 1)
	From [dbo].[SalesSmyth_Hot_Leads_RAW] HR
	LEFT JOIN [dbo].[SalesSmyth_Hot_Leads_Table] SH ON HR.[Scoop ID] = SH.[Hot_Lead_ID]
    WHERE SH.[Hot_Lead_ID] IS NULL;

	UPDATE SH
	SET SH.Hot_Lead_Week_Published = DATEPART(week,SH.Hot_Lead_Date_Published),
		SH.Hot_Lead_Month_Published = DATENAME(Month,SH.Hot_Lead_Date_Published),
        SH.Hot_Lead_Category_= CASE WHEN DATEDIFF(DD,SH.Hot_Lead_Date_Published,GETdate())<30 THEN 'HOT' 
									When DATEDIFF(DD,SH.Hot_Lead_Date_Published,GETdate())<90 Then 'WARM'
									ELSE 'cool' END
	FROM [dbo].[SalesSmyth_Hot_Leads_Table] AS SH

	UPDATE SH
	SET SH.TPID=SC.Client_Account_Id,
		SH.Account_Name=SC.Account_Name
	FROM SalesSmyth_Hot_Leads_Table AS SH
	JOIN SalesSmyth_Company_Table AS SC
	ON SH.ZoomInfo_Company_ID=SC.ZoomInfo_Company_ID

	Exec  ZOOMINFO

	Delete from [dbo].[SalesSmyth_Hot_Leads_RAW] 
END

GO