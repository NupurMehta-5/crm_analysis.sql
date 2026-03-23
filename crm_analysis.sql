
-- CRM Lead Conversion Analysis

-- Note:
-- The 'Converted' column is of type BIT.
-- SQL Server does not allow SUM() directly on BIT,
-- so we CAST it to INT before aggregation.



-- 1️ Total Leads
SELECT 
    COUNT(*) AS Total_Leads
FROM crm_leads;



-- 2️ Total Converted Leads
SELECT 
    SUM(CAST(Converted AS INT)) AS Converted_Leads
FROM crm_leads;



-- 3️ Overall Conversion Rate (%)
SELECT 
    COUNT(*) AS Total_Leads,
    SUM(CAST(Converted AS INT)) AS Converted_Leads,
    CAST(
        SUM(CAST(Converted AS INT)) * 100.0 / COUNT(*) 
        AS DECIMAL(5,2)
    ) AS Conversion_Rate_Percentage
FROM crm_leads;



-- 4️ Conversion Rate by Source
SELECT 
    Source,
    COUNT(*) AS Total_Leads,
    SUM(CAST(Converted AS INT)) AS Converted_Leads,
    CAST(
        SUM(CAST(Converted AS INT)) * 100.0 / COUNT(*) 
        AS DECIMAL(5,2)
    ) AS Conversion_Rate_Percentage
FROM crm_leads
GROUP BY Source
ORDER BY Conversion_Rate_Percentage DESC;



-- 5️ Average Lead Score (Converted vs Not Converted)
SELECT 
    CASE 
        WHEN Converted = 1 THEN 'Converted'
        ELSE 'Not Converted'
    END AS Conversion_Status,
    AVG(LeadScore) AS Avg_LeadScore
FROM crm_leads
GROUP BY Converted;



-- 6️ Average Response Time (Converted vs Not Converted)
SELECT 
    CASE 
        WHEN Converted = 1 THEN 'Converted'
        ELSE 'Not Converted'
    END AS Conversion_Status,
    AVG(ResponseTimeHours) AS Avg_Response_Time
FROM crm_leads
GROUP BY Converted;



-- 7️ Total Revenue Generated (Converted Leads Only)
SELECT 
    SUM(ISNULL(DealValue, 0)) AS Total_Revenue
FROM crm_leads
WHERE Converted = 1;
