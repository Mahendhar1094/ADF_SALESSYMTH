CREATE Procedure [dbo].[Zoominfo]
As
begin

Update SS
SET SS.Website=SI.Website,
	SS.Founded_Year=SI.[Founded Year],
	SS.Company_HQ_Phone= SI.[Company HQ Phone],
	SS.[Revenue_(in_000s_USD)]=SI.[Revenue (in 000s USD)],
	SS.Employees=SI.[Employees],
	SS.Primary_Industry=SI.[Primary Industry],	
	SS.Primary_Sub_Industry=SI.[Primary Sub-Industry],
	SS.All_Industries=SI.[All Industries],
	SS.All_Sub_Industries=SI.[All Sub-Industries],
	SS.Industry_Hierarchical_Category=SI.[Industry Hierarchical Category],
	SS.Secondary_Industry_Hierarchical_Category=SI.[Secondary Industry Hierarchical Category],
	SS.Alexa_Rank=SI.[Alexa Rank],
	SS.LinkedIn_Company_Profile_URL=SI.[LinkedIn Company Profile URL],
	SS.Facebook_Company_Profile_URL=SI.[Facebook Company Profile URL],
	SS.Twitter_Company_Profile_URL=SI.[Twitter Company Profile URL],
	SS.Certified_Active_Company=SI.[Certified Active Company],
	SS.Certification_Date=SI.[Certification Date],
	SS.[Total_Funding_Amount_(in_000s_USD)]=SI.[Total Funding Amount (in 000s USD)],
	SS.[Recent_Funding_Amount_(in_000s_USD)]=SI.[Recent Funding Amount (in 000s USD)],
	SS.Recent_Funding_Round=SI.[Recent Funding Round],
	SS.Recent_Funding_Date=SI.[Recent Funding Date],
	SS.Recent_Investors=SI.[Recent Investors],
	SS.All_Investors=SI.[All Investors],
	SS.Company_Street_Address=SI.[Company Street Address],
	SS.Company_City=SI.[Company City],
	SS.Company_State=SI.[Company State],
	SS.Company_Country=SI.[Company Country],
	SS.Company_Zip_Code=SI.[Company Zip Code],
	SS.Full_Address=SI.[Full Address],
	SS.Number_of_Locations=SI.[Number of Locations]
				
From [dbo].[ZoomInfo_Data_RAW] SI
Join [dbo].[SalesSmyth_Company_Table] SS
On  SS.Client_Account_Id= SI.[TPID]

UPDATE SS
SET SS.ZoomInfo_Company_ID = ZD.[ZoomInfo Company ID],
    SS.Company_Name = ZD.[Company Name],
    SS.ZoomInfo_Company_Profile_URL = ZD.[ZoomInfo Company Profile URL],
	SS.Company_Country= ZD.[Company Country],
	SS.Existing_Product_Refresh_Date= CONVERT(Date,GETdate(),104)

FROM [dbo].[SalesSmyth_Company_Table] AS SS
JOIN ZoomInfo_Data_RAW AS ZD ON ZD.TPID = SS.Client_Account_Id;

UPDATE SS
SET SS.Match_Status = Case when SS.ZoomInfo_Company_ID IS NOT NULL THEN 'MATCH' ELSE 'NOT MATCHED' END
FROM [dbo].[SalesSmyth_Company_Table] AS SS


UPDATE SS
SET SS.SalesSmyth_Region = SR.Region
FROM [dbo].[SalesSmyth_Company_Table] AS SS
Join [SalesSmyth Region] SR
on SS.Company_Country=SR.Country

UPDATE SS
SET SS.Fortune_100_Flag = 'TRUE'
FROM [dbo].[SalesSmyth_Company_Table] AS SS
Join SalesSmyth_FOrtune_Companies_Raw SF
on SS.ZoomInfo_Company_ID=SF.[ZoomInfo Company ID]
where SF.fortune = 'Fortune_100.csv'

UPDATE SS
SET SS.Fortune_500_Flag = 'TRUE'
FROM [dbo].[SalesSmyth_Company_Table] AS SS
Join SalesSmyth_FOrtune_Companies_Raw SF
on SS.ZoomInfo_Company_ID=SF.[ZoomInfo Company ID]
where SF.fortune = 'Fortune_500.csv'

UPDATE SS
SET SS.Fortune_1000_Flag = 'TRUE'
FROM [dbo].[SalesSmyth_Company_Table] AS SS
Join SalesSmyth_FOrtune_Companies_Raw SF
on SS.ZoomInfo_Company_ID=SF.[ZoomInfo Company ID]
where SF.fortune = 'Fortune_1000.csv'

UPDATE SS
SET SS.[Existing SFDC Product Line Service Cloud] = 'TRUE',
	SS.Existing_Product_Refresh_Date= CONVERT(Date,GETdate(),104)
FROM [dbo].[SalesSmyth_Company_Table] AS SS
Join SalesSmyth_Products_Data_Raw SP
on SS.ZoomInfo_Company_ID=SP.[ZoomInfo Company ID]
where SP.Product_Type = 'COMPANY_Service.csv'

UPDATE SS
SET SS.[Existing SFDC Product Line Marketing Cloud] = 'TRUE',
	SS.Existing_Product_Refresh_Date= CONVERT(Date,GETdate(),104)
FROM [dbo].[SalesSmyth_Company_Table] AS SS
Join SalesSmyth_Products_Data_Raw SP
on SS.ZoomInfo_Company_ID=SP.[ZoomInfo Company ID]
where SP.Product_Type = 'COMPANY_Marketing.csv'

UPDATE SS
SET SS.[Existing SFDC Product Line Experience Cloud] = 'TRUE',
	SS.Existing_Product_Refresh_Date= CONVERT(Date,GETdate(),104)
FROM [dbo].[SalesSmyth_Company_Table] AS SS
Join SalesSmyth_Products_Data_Raw SP
on SS.ZoomInfo_Company_ID=SP.[ZoomInfo Company ID]
where SP.Product_Type = 'COMPANY_Experience.csv'

UPDATE SS
SET SS.[Existing SFDC Product Line Industry  Cloud] = 'TRUE',
	SS.Existing_Product_Refresh_Date= CONVERT(Date,GETdate(),104)
FROM [dbo].[SalesSmyth_Company_Table] AS SS
Join SalesSmyth_Products_Data_Raw SP
on SS.ZoomInfo_Company_ID=SP.[ZoomInfo Company ID]
where SP.Product_Type = 'COMPANY_Cloud.csv'

UPDATE SS
SET SS.[Existing SFDC Product Line CRM] = 'TRUE',
	SS.Existing_Product_Refresh_Date= CONVERT(Date,GETdate(),104)
FROM [dbo].[SalesSmyth_Company_Table] AS SS
Join SalesSmyth_Products_Data_Raw SP
on SS.ZoomInfo_Company_ID=SP.[ZoomInfo Company ID]
where SP.Product_Type = 'COMPANY_CRM.csv'

end
GO