CREATE TABLE [dbo].[SalesSmyth_Company_Table](
	[Client_Account_Id] [varchar](max) NOT NULL,
	[SalesSmyth_Company_ID] [varchar](max) NOT NULL,
	[SalesSmyth_Client_ID] [varchar](max) NULL,
	[ZoomInfo_Company_ID] [varchar](max) NULL,
	[Company_Name] [varchar](max) NULL,
	[Website] [varchar](max) NULL,
	[Founded_Year] [varchar](max) NULL,
	[Company_HQ_Phone] [varchar](max) NULL,
	[Fax] [varchar](max) NULL,
	[Ticker] [varchar](max) NULL,
	[Revenue_(in_000s_USD)] [varchar](max) NULL,
	[Revenue_Range_(in_USD)] [varchar](max) NULL,
	[Employees] [varchar](max) NULL,
	[Employee_Range] [varchar](max) NULL,
	[SIC_Code_1] [varchar](max) NULL,
	[SIC_Code_2] [varchar](max) NULL,
	[SIC_Codes] [varchar](max) NULL,
	[NAICS_Code_1] [varchar](max) NULL,
	[NAICS_Code_2] [varchar](max) NULL,
	[NAICS_Codes] [varchar](max) NULL,
	[Primary_Industry] [varchar](max) NULL,
	[Primary_Sub_Industry] [varchar](max) NULL,
	[All_Industries] [varchar](max) NULL,
	[All_Sub_Industries] [varchar](max) NULL,
	[Industry_Hierarchical_Category] [varchar](max) NULL,
	[Secondary_Industry_Hierarchical_Category] [varchar](max) NULL,
	[Alexa_Rank] [varchar](max) NULL,
	[ZoomInfo_Company_Profile_URL] [varchar](max) NULL,
	[LinkedIn_Company_Profile_URL] [varchar](max) NULL,
	[Facebook_Company_Profile_URL] [varchar](max) NULL,
	[Twitter_Company_Profile_URL] [varchar](max) NULL,
	[Ownership_Type] [varchar](max) NULL,
	[Business_Model] [varchar](max) NULL,
	[Certified_Active_Company] [varchar](max) NULL,
	[Certification_Date] [varchar](max) NULL,
	[Total_Funding_Amount_(in_000s_USD)] [varchar](max) NULL,
	[Recent_Funding_Amount_(in_000s_USD)] [varchar](max) NULL,
	[Recent_Funding_Round] [varchar](max) NULL,
	[Recent_Funding_Date] [varchar](max) NULL,
	[Recent_Investors] [varchar](max) NULL,
	[All_Investors] [varchar](max) NULL,
	[Company_Street_Address] [varchar](max) NULL,
	[Company_City] [varchar](max) NULL,
	[Company_State] [varchar](max) NULL,
	[Company_Zip_Code] [varchar](max) NULL,
	[Company_Country] [varchar](max) NULL,
	[Full_Address] [varchar](max) NULL,
	[Number_of_Locations] [varchar](max) NULL,
	[Company_Is_Acquired] [varchar](max) NULL,
	[Company_ID_(Ultimate_Parent)] [varchar](max) NULL,
	[Entity_Name_(Ultimate_Parent)] [varchar](max) NULL,
	[Company_ID_(Immediate_Parent)] [varchar](max) NULL,
	[Entity_Name_(Immediate_Parent)] [varchar](max) NULL,
	[Relationship_(Immediate_Parent)] [varchar](max) NULL,
	[Query_Name] [varchar](max) NULL,
	[Existing SFDC Product Line CRM] [varchar](max) NULL,
	[Existing SFDC Product Line Marketing Cloud] [varchar](max) NULL,
	[Existing SFDC Product Line Service Cloud] [varchar](max) NULL,
	[Existing SFDC Product Line Experience Cloud] [varchar](max) NULL,
	[Existing SFDC Product Line Industry  Cloud] [varchar](max) NULL,
	[Existing MSFT Product Line Dynamics] [varchar](max) NULL,
	[Existing_Product_Refresh_Date] [varchar](max) NULL,
	[Fortune_100_Flag] [varchar](max) NULL,
	[Fortune_500_Flag] [varchar](max) NULL,
	[Fortune_1000_Flag] [varchar](max) NULL,
	[SalesSmyth_Region] [varchar](max) NULL,
	[SalesSmyth_Segment] [varchar](max) NULL,
	[SalesSmyth_Sales_Unit] [varchar](max) NULL,
	[HQ_DS_FLag] [varchar](max) NULL,
	[Account_Name] [varchar](max) NULL,
	[Region] [varchar](max) NULL,
	[Subregion] [varchar](max) NULL,
	[Country] [varchar](max) NULL,
	[Segment] [varchar](max) NULL,
	[Subsegment] [varchar](max) NULL,
	[Sales_Unit] [varchar](max) NULL,
	[Sales_Team_Unit] [varchar](max) NULL,
	[Industry] [varchar](max) NULL,
	[Vertical] [varchar](max) NULL,
	[Match_Status] [varchar](max) NULL
)