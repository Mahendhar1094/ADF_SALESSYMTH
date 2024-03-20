CREATE   Procedure [dbo].[TPID]
As 
Begin

Update UserRequested_TPID
set Request_ID = SUBSTRING(Request_ID, 1, CHARINDEX('.', Request_ID) - 1)
from UserRequested_TPID
Where Request_ID like '%.csv';

WITH RankedRequests AS (
    SELECT
        TPID,
        Request_ID,
        Request_date,
        Rank() OVER (PARTITION BY Request_ID ORDER BY Request_date ) AS RowNum
    FROM
        UserRequested_TPID 
)
Delete FROM RankedRequests WHERE RowNum > 1;
END