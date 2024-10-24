
USE data_car;
SELECT * FROM insurance_data;

----------------------------------------------------------------------------------------------------------

/* df.shape */
/* How many rows the data set has? */

SELECT COUNT(*) AS number_of_rows FROM insurance_data

SELECT COUNT(*) AS number_of_cols FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'insurance_data';


----------------------------------------------------------------------------------------------------------

/* Data Info */
/* what are the schemas names and data types? */

EXEC sp_help 'insurance_data';



/* Data Cleaning : Na-Values : */
SELECT * FROM  insurance_data WHERE veh_value IS NULL; 

-- removing column : X_OBSTAT_
ALTER TABLE insurance_data DROP COLUMN X_OBSTAT;



-- numeric features stats:
SELECT  MIN(veh_value) AS Min_Sum_Insured ,MAX(veh_value) AS Max_Sum_Insured,AVG(veh_value) AS Average_Sum_Insured FROM insurance_data ;
SELECT  MIN(claimcst0) AS Min_claims,MAX(claimcst0) AS Max_claims,AVG(claimcst0)AS Average_Sum_claims FROM insurance_data ;
SELECT  MIN(exposure)  AS Min_exposure,MAX(exposure) AS Max_exposure,AVG(exposure)AS Average_Sum_exposure FROM insurance_data ;

SELECT COUNT(*) FROM insurance_data WHERE veh_value = 0;
SELECT COUNT(*) FROM insurance_data WHERE claimcst0 = 0;
SELECT COUNT(*) FROM insurance_data WHERE claimcst0 != 0;


-- CREATE NEW TABLE WITH THE VEH_VALUES = 0:
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='ZeroSumInsured')
BEGIN
    SELECT *
    INTO ZeroSumInsured
    FROM insurance_data
    WHERE veh_value = 0;
END;

-- CREATE NEW TABLE WITH THE VEH_VALUES != 0:
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='NonZeroSumInsured')
BEGIN
    SELECT *
    INTO NonZeroSumInsured
    FROM insurance_data
    WHERE veh_value != 0;
END;


-- CREATE NEW TABLE WITH THE claimcst0 = 0 "Null Claims":
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='NoClaims')
BEGIN
    SELECT *
    INTO NoClaims
    FROM NonZeroSumInsured
    WHERE claimcst0 = 0;
END;

-- CREATE NEW TABLE WITH THE claimcst0 != 0 "Positive Claims":
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='IncurredClaims')
BEGIN
    SELECT *
    INTO IncurredClaims
    FROM NonZeroSumInsured
    WHERE claimcst0 != 0;
END;



SELECT gender, MIN(veh_value) AS Min_Sum_Insured ,ROUND(MAX(veh_value),2) AS Max_Sum_Insured,ROUND(AVG(veh_value),2) AS Average_Sum_Insured,
ROUND(MIN(claimcst0),2) AS Min_claims,ROUND(MAX(claimcst0),2) AS Max_claims,ROUND(AVG(claimcst0),2) AS Average_claims,
MIN(exposure)  AS Min_exposure,MAX(exposure) AS Max_exposure,ROUND(AVG(exposure),2) AS Average_exposure
FROM NonZeroSumInsured GROUP BY gender ;

SELECT area, MIN(veh_value) AS Min_Sum_Insured ,ROUND(MAX(veh_value),2) AS Max_Sum_Insured,ROUND(AVG(veh_value),2) AS Average_Sum_Insured,
ROUND(MIN(claimcst0),2) AS Min_claims,ROUND(MAX(claimcst0),2) AS Max_claims,ROUND(AVG(claimcst0),2) AS Average_claims,
MIN(exposure)  AS Min_exposure,MAX(exposure) AS Max_exposure,ROUND(AVG(exposure),2) AS Average_exposure
FROM NonZeroSumInsured GROUP BY area ORDER BY area ;

SELECT veh_age, MIN(veh_value) AS Min_Sum_Insured ,ROUND(MAX(veh_value),2) AS Max_Sum_Insured,ROUND(AVG(veh_value),2) AS Average_Sum_Insured,
ROUND(MIN(claimcst0),2) AS Min_claims,ROUND(MAX(claimcst0),2) AS Max_claims,ROUND(AVG(claimcst0),2) AS Average_claims,
MIN(exposure)  AS Min_exposure,MAX(exposure) AS Max_exposure,ROUND(AVG(exposure),2) AS Average_exposure
FROM NonZeroSumInsured GROUP BY veh_age ORDER BY veh_age ;

SELECT agecat, MIN(veh_value) AS Min_Sum_Insured ,ROUND(MAX(veh_value),2) AS Max_Sum_Insured,ROUND(AVG(veh_value),2) AS Average_Sum_Insured,
ROUND(MIN(claimcst0),2) AS Min_claims,ROUND(MAX(claimcst0),2) AS Max_claims,ROUND(AVG(claimcst0),2) AS Average_claims,
MIN(exposure)  AS Min_exposure,MAX(exposure) AS Max_exposure,ROUND(AVG(exposure),2) AS Average_exposure
FROM NonZeroSumInsured GROUP BY agecat ORDER BY agecat ;

SELECT veh_body, MIN(veh_value) AS Min_Sum_Insured ,ROUND(MAX(veh_value),2) AS Max_Sum_Insured,ROUND(AVG(veh_value),2) AS Average_Sum_Insured,
ROUND(MIN(claimcst0),2) AS Min_claims,ROUND(MAX(claimcst0),2) AS Max_claims,ROUND(AVG(claimcst0),2) AS Average_claims,
MIN(exposure)  AS Min_exposure,MAX(exposure) AS Max_exposure,ROUND(AVG(exposure),2) AS Average_exposure
FROM NonZeroSumInsured GROUP BY veh_body ORDER BY veh_body ;


--------
SELECT COUNT(*) AS number_of_rows FROM IncurredClaims;
-- numeric features stats:
SELECT  MIN(veh_value) AS Min_Sum_Insured ,MAX(veh_value) AS Max_Sum_Insured,AVG(veh_value) AS Average_Sum_Insured FROM IncurredClaims ;
SELECT  MIN(claimcst0) AS Min_claims,MAX(claimcst0) AS Max_claims,AVG(claimcst0)AS Average_Sum_claims FROM IncurredClaims ;
SELECT  MIN(exposure)  AS Min_exposure,MAX(exposure) AS Max_exposure,AVG(exposure)AS Average_Sum_exposure FROM IncurredClaims ;

SELECT gender, ROUND(MIN(veh_value),2) AS Min_Sum_Insured ,ROUND(MAX(veh_value),2) AS Max_Sum_Insured,ROUND(AVG(veh_value),2) AS Average_Sum_Insured,
ROUND(MIN(claimcst0),2) AS Min_claims,ROUND(MAX(claimcst0),2) AS Max_claims,ROUND(AVG(claimcst0),2) AS Average_claims,
MIN(exposure)  AS Min_exposure,MAX(exposure) AS Max_exposure,ROUND(AVG(exposure),2) AS Average_exposure
FROM IncurredClaims GROUP BY gender ;

SELECT area, ROUND(MIN(veh_value),2) AS Min_Sum_Insured ,ROUND(MAX(veh_value),2) AS Max_Sum_Insured,ROUND(AVG(veh_value),2) AS Average_Sum_Insured,
ROUND(MIN(claimcst0),2) AS Min_claims,ROUND(MAX(claimcst0),2) AS Max_claims,ROUND(AVG(claimcst0),2) AS Average_claims,
MIN(exposure)  AS Min_exposure,MAX(exposure) AS Max_exposure,ROUND(AVG(exposure),2) AS Average_exposure
FROM IncurredClaims GROUP BY area ORDER BY area ;

SELECT veh_age, ROUND(MIN(veh_value),2) AS Min_Sum_Insured ,ROUND(MAX(veh_value),2) AS Max_Sum_Insured,ROUND(AVG(veh_value),2) AS Average_Sum_Insured,
ROUND(MIN(claimcst0),2) AS Min_claims,ROUND(MAX(claimcst0),2) AS Max_claims,ROUND(AVG(claimcst0),2) AS Average_claims,
MIN(exposure)  AS Min_exposure,MAX(exposure) AS Max_exposure,ROUND(AVG(exposure),2) AS Average_exposure
FROM IncurredClaims GROUP BY veh_age ORDER BY veh_age ;

SELECT agecat, ROUND(MIN(veh_value),2) AS Min_Sum_Insured ,ROUND(MAX(veh_value),2) AS Max_Sum_Insured,ROUND(AVG(veh_value),2) AS Average_Sum_Insured,
ROUND(MIN(claimcst0),2) AS Min_claims,ROUND(MAX(claimcst0),2) AS Max_claims,ROUND(AVG(claimcst0),2) AS Average_claims,
MIN(exposure)  AS Min_exposure,MAX(exposure) AS Max_exposure,ROUND(AVG(exposure),2) AS Average_exposure
FROM IncurredClaims GROUP BY agecat ORDER BY agecat ;

SELECT veh_body, ROUND(MIN(veh_value),2) AS Min_Sum_Insured ,ROUND(MAX(veh_value),2) AS Max_Sum_Insured,ROUND(AVG(veh_value),2) AS Average_Sum_Insured,
ROUND(MIN(claimcst0),2) AS Min_claims,ROUND(MAX(claimcst0),2) AS Max_claims,ROUND(AVG(claimcst0),2) AS Average_claims,
MIN(exposure)  AS Min_exposure,MAX(exposure) AS Max_exposure,ROUND(AVG(exposure),2) AS Average_exposure
FROM IncurredClaims GROUP BY veh_body ORDER BY veh_body ;

--------------------------------------

SELECT 
gender,
ROUND(SUM(claimcst0),0) AS Total_Claims_Cost,
ROUND(SUM(numclaims),0)AS Total_Number_Claims,
ROUND(SUM(exposure),0)AS Total_Exposures,
ROUND(SUM(numclaims)/SUM(exposure),3) AS claims_Frequency,
ROUND(SUM(claimcst0)/SUM(numclaims),0) AS claims_Severity,
ROUND(SUM(claimcst0)/SUM(exposure),0) AS pure_premium
FROM NonZeroSumInsured GROUP BY gender ORDER BY gender ;

SELECT 
area,
ROUND(SUM(claimcst0),0) AS Total_Claims_Cost,
ROUND(SUM(numclaims),0)AS Total_Number_Claims,
ROUND(SUM(exposure),0)AS Total_Exposures,
ROUND(SUM(numclaims)/SUM(exposure),3) AS claims_Frequency,
ROUND(SUM(claimcst0)/SUM(numclaims),0) AS claims_Severity,
ROUND(SUM(claimcst0)/SUM(exposure),0) AS pure_premium
FROM NonZeroSumInsured GROUP BY area ORDER BY area;


SELECT 
agecat,
ROUND(SUM(claimcst0),0) AS Total_Claims_Cost,
ROUND(SUM(numclaims),0)AS Total_Number_Claims,
ROUND(SUM(exposure),0)AS Total_Exposures,
ROUND(SUM(numclaims)/SUM(exposure),3) AS claims_Frequency,
ROUND(SUM(claimcst0)/SUM(numclaims),0) AS claims_Severity,
ROUND(SUM(claimcst0)/SUM(exposure),0) AS pure_premium
FROM NonZeroSumInsured GROUP BY agecat ORDER BY agecat ;

SELECT 
veh_age,
ROUND(SUM(claimcst0),0) AS Total_Claims_Cost,
ROUND(SUM(numclaims),0)AS Total_Number_Claims,
ROUND(SUM(exposure),0)AS Total_Exposures,
ROUND(SUM(numclaims)/SUM(exposure),3) AS claims_Frequency,
ROUND(SUM(claimcst0)/SUM(numclaims),0) AS claims_Severity,
ROUND(SUM(claimcst0)/SUM(exposure),0) AS pure_premium
FROM NonZeroSumInsured GROUP BY veh_age ORDER BY veh_age;

SELECT 
veh_body,
ROUND(SUM(claimcst0),0) AS Total_Claims_Cost,
ROUND(SUM(numclaims),0)AS Total_Number_Claims,
ROUND(SUM(exposure),0)AS Total_Exposures,
ROUND(SUM(numclaims)/SUM(exposure),3) AS claims_Frequency,
ROUND(SUM(claimcst0)/SUM(numclaims),0) AS claims_Severity,
ROUND(SUM(claimcst0)/SUM(exposure),0) AS pure_premium
FROM NonZeroSumInsured GROUP BY veh_body ORDER BY veh_body;

SELECT 
gender,
agecat,
veh_age,
veh_body,
area,
ROUND(SUM(claimcst0) OVER(PARTITION BY area),0) AS total_claims_cost,
ROUND(SUM(numclaims) OVER(PARTITION BY area),0) AS total_claims_number,
ROUND(SUM(exposure) OVER(PARTITION BY area),0) AS total_exposures_number
FROM IncurredClaims

SELECT 
area,
claimcst0,
Veh_value,
RANK() OVER(ORDER BY Veh_value DESC) AS RankByVehValue,
RANK() OVER(ORDER BY claimcst0 DESC) AS RankByClaimsCost
FROM IncurredClaims 

SELECT 
gender,
claimcst0,
Veh_value,
RANK() OVER(ORDER BY Veh_value DESC) AS RankByVehValue,
RANK() OVER(ORDER BY claimcst0 DESC) AS RankByClaimsCost
FROM IncurredClaims 

SELECT 
agecat,
claimcst0,
Veh_value,
RANK() OVER(ORDER BY Veh_value DESC) AS RankByVehValue,
RANK() OVER(ORDER BY claimcst0 DESC) AS RankByClaimsCost
FROM IncurredClaims 

SELECT 
veh_age,
claimcst0,
Veh_value,
RANK() OVER(ORDER BY Veh_value DESC) AS RankByVehValue,
RANK() OVER(ORDER BY claimcst0 DESC) AS RankByClaimsCost
FROM IncurredClaims 

SELECT 
veh_body,
claimcst0,
Veh_value,
RANK() OVER(ORDER BY Veh_value DESC) AS RankByVehValue, 
RANK() OVER(ORDER BY claimcst0 DESC) AS RankByClaimsCost
FROM IncurredClaims 
-- Rank allow duplication (two ranks or more have the same rank)


SELECT *,
ROW_NUMBER() OVER(ORDER BY claimcst0 DESC) AS ClaimsCost_Rank_Number
FROM IncurredClaims
-- ROW_NUMBER doesnot allow duplication in rank
-- DENSE_RANK RANK based on density

SELECT *,
RANK() OVER(ORDER BY claimcst0 DESC) AS RankByClaimsCost,
ROW_NUMBER() OVER(ORDER BY claimcst0 DESC) AS ClaimsCost_Rank_Number,
DENSE_RANK() OVER(ORDER BY claimcst0 DESC) AS ClaimsCost_DENSE_RANK
FROM IncurredClaims

-------------------------------------
SELECT 
gender,
SUM(claimcst0),
RANK() OVER(ORDER BY SUM(claimcst0) DESC) AS RankByClaimsCost,
ROW_NUMBER() OVER(ORDER BY SUM(claimcst0) DESC) AS ClaimsCost_Rank_Number,
DENSE_RANK() OVER(ORDER BY SUM(claimcst0) DESC) AS ClaimsCost_DENSE_RANK,
ROUND(CUME_DIST() OVER(ORDER BY SUM(claimcst0) DESC),2) AS ClaimsCost_CUME_DIST,
ROUND(PERCENT_RANK() OVER(ORDER BY SUM(claimcst0) DESC),2) AS ClaimsCost_PERCENT_RANK,
NTILE(2) OVER(ORDER BY SUM(claimcst0) DESC) AS ClaimsCost_NTILE
FROM IncurredClaims
GROUP BY gender

SELECT 
gender,
AVG(claimcst0),
RANK() OVER(ORDER BY AVG(claimcst0) DESC) AS RankByAVGClaimsCost,
ROW_NUMBER() OVER(ORDER BY AVG(claimcst0) DESC) AS AVGClaimsCost_Rank_Number,
DENSE_RANK() OVER(ORDER BY AVG(claimcst0) DESC) AS AVGClaimsCost_DENSE_RANK,
ROUND(CUME_DIST() OVER(ORDER BY AVG(claimcst0) DESC),2) AS AVGClaimsCost_CUME_DIST,
ROUND(PERCENT_RANK() OVER(ORDER BY AVG(claimcst0) DESC),2) AS AVGClaimsCost_PERCENT_RANK,
NTILE(2) OVER(ORDER BY AVG(claimcst0) DESC) AS AVGClaimsCost_NTILE
FROM IncurredClaims
GROUP BY gender
-----------------------------------
SELECT 
area,
AVG(claimcst0),
RANK() OVER(ORDER BY AVG(claimcst0) DESC) AS RankByAVGClaimsCost,
ROW_NUMBER() OVER(ORDER BY AVG(claimcst0) DESC) AS AVGClaimsCost_Rank_Number,
DENSE_RANK() OVER(ORDER BY AVG(claimcst0) DESC) AS AVGClaimsCost_DENSE_RANK,
ROUND(CUME_DIST() OVER(ORDER BY AVG(claimcst0) DESC),2) AS AVGClaimsCost_CUME_DIST,
ROUND(PERCENT_RANK() OVER(ORDER BY AVG(claimcst0) DESC),2) AS AVGClaimsCost_PERCENT_RANK,
NTILE(2) OVER(ORDER BY AVG(claimcst0) DESC) AS AVGClaimsCost_NTILE
FROM IncurredClaims
GROUP BY area
-----------------------------------
SELECT 
veh_age,
AVG(claimcst0),
RANK() OVER(ORDER BY AVG(claimcst0) DESC) AS RankByAVGClaimsCost,
ROW_NUMBER() OVER(ORDER BY AVG(claimcst0) DESC) AS AVGClaimsCost_Rank_Number,
DENSE_RANK() OVER(ORDER BY AVG(claimcst0) DESC) AS AVGClaimsCost_DENSE_RANK,
ROUND(CUME_DIST() OVER(ORDER BY AVG(claimcst0) DESC),2) AS AVGClaimsCost_CUME_DIST,
ROUND(PERCENT_RANK() OVER(ORDER BY AVG(claimcst0) DESC),2) AS AVGClaimsCost_PERCENT_RANK,
NTILE(2) OVER(ORDER BY AVG(claimcst0) DESC) AS AVGClaimsCost_NTILE
FROM IncurredClaims
GROUP BY veh_age
--------------------------------
SELECT 
agecat,
AVG(claimcst0),
RANK() OVER(ORDER BY AVG(claimcst0) DESC) AS RankByAVGClaimsCost,
ROW_NUMBER() OVER(ORDER BY AVG(claimcst0) DESC) AS AVGClaimsCost_Rank_Number,
DENSE_RANK() OVER(ORDER BY AVG(claimcst0) DESC) AS AVGClaimsCost_DENSE_RANK,
ROUND(CUME_DIST() OVER(ORDER BY AVG(claimcst0) DESC),2) AS AVGClaimsCost_CUME_DIST,
ROUND(PERCENT_RANK() OVER(ORDER BY AVG(claimcst0) DESC),2) AS AVGClaimsCost_PERCENT_RANK,
NTILE(2) OVER(ORDER BY AVG(claimcst0) DESC) AS AVGClaimsCost_NTILE
FROM IncurredClaims
GROUP BY agecat
----------------------------------
SELECT 
veh_body,
AVG(claimcst0),
RANK() OVER(ORDER BY AVG(claimcst0) DESC) AS RankByAVGClaimsCost,
ROW_NUMBER() OVER(ORDER BY AVG(claimcst0) DESC) AS AVGClaimsCost_Rank_Number,
DENSE_RANK() OVER(ORDER BY AVG(claimcst0) DESC) AS AVGClaimsCost_DENSE_RANK,
ROUND(CUME_DIST() OVER(ORDER BY AVG(claimcst0) DESC),2) AS AVGClaimsCost_CUME_DIST,
ROUND(PERCENT_RANK() OVER(ORDER BY AVG(claimcst0) DESC),2) AS AVGClaimsCost_PERCENT_RANK,
NTILE(2) OVER(ORDER BY AVG(claimcst0) DESC) AS AVGClaimsCost_NTILE
FROM IncurredClaims
GROUP BY veh_body


---------------------
SELECT 
gender,
ROUND(claimcst0,2),
ROUND(AVG(claimcst0) OVER(ORDER BY claimcst0 DESC),2) AS AverageAllClaims,
ROUND(AVG(claimcst0) OVER(PARTITION BY gender),2) AS AverageGenderClaims,
ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(ORDER BY claimcst0 DESC),2) AS DivationFromAverageAllClaims,
ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(PARTITION BY gender),2) AS DivationFromAverageGenderClaims
FROM IncurredClaims
ORDER BY DivationFromAverageAllClaims ASC,DivationFromAverageGenderClaims ASC
---------------------------------------------------
SELECT 
area,
ROUND(claimcst0,2),
ROUND(AVG(claimcst0) OVER(ORDER BY claimcst0 DESC),2) AS AverageAllClaims,
ROUND(AVG(claimcst0) OVER(PARTITION BY area),2) AS AverageAreaClaims,
ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(ORDER BY claimcst0 DESC),2) AS DivationFromAverageAllClaims,
ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(PARTITION BY area),2) AS DivationFromAverageAreaClaims
FROM IncurredClaims
ORDER BY DivationFromAverageAllClaims ASC,DivationFromAverageAreaClaims ASC

---------------------------------------------------
SELECT 
veh_age,
ROUND(claimcst0,2),
ROUND(AVG(claimcst0) OVER(ORDER BY claimcst0 DESC),2) AS AverageAllClaims,
ROUND(AVG(claimcst0) OVER(PARTITION BY veh_age),2) AS Averageveh_ageClaims,
ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(ORDER BY claimcst0 DESC),2) AS DivationFromAverageAllClaims,
ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(PARTITION BY veh_age),2) AS DivationFromAverageveh_ageClaims
FROM IncurredClaims
ORDER BY DivationFromAverageAllClaims ASC,DivationFromAverageveh_ageClaims ASC

---------------------------------------------------
SELECT 
agecat,
ROUND(claimcst0,2),
ROUND(AVG(claimcst0) OVER(ORDER BY claimcst0 DESC),2) AS AverageAllClaims,
ROUND(AVG(claimcst0) OVER(PARTITION BY agecat),2) AS AverageAgecatClaims,
ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(ORDER BY claimcst0 DESC),2) AS DivationFromAverageAllClaims,
ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(PARTITION BY agecat),2) AS DivationFromAverageAgecatClaims
FROM IncurredClaims
ORDER BY DivationFromAverageAllClaims ASC,DivationFromAverageAgecatClaims ASC

---------------------------------------------------
SELECT 
veh_body,
ROUND(claimcst0,2),
ROUND(AVG(claimcst0) OVER(ORDER BY claimcst0 DESC),2) AS AverageAllClaims,
ROUND(AVG(claimcst0) OVER(PARTITION BY veh_body),2) AS Averageveh_bodyClaims,
ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(ORDER BY claimcst0 DESC),2) AS DivationFromAverageAllClaims,
ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(PARTITION BY veh_body),2) AS DivationFromAverageveh_bodyClaims
FROM IncurredClaims
ORDER BY DivationFromAverageAllClaims ASC,DivationFromAverageveh_bodyClaims ASC
----------------------------------
----------------------------------
SELECT 
  veh_body,
  ROUND(claimcst0,2) AS ClaimCost,
  ROUND(AVG(claimcst0) OVER(ORDER BY claimcst0 DESC),2) AS AverageAllClaims,
  ROUND(AVG(claimcst0) OVER(PARTITION BY veh_body),2) AS Averageveh_bodyClaims,
  ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(ORDER BY claimcst0 DESC),2) AS DivationFromAverageAllClaims,
  ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(PARTITION BY veh_body),2) AS DivationFromAverageveh_bodyClaims,
  CASE
    WHEN ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(PARTITION BY veh_body),2) > 0 THEN 'More Than Averageveh_bodyClaims'
    WHEN ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(PARTITION BY veh_body),2) < 0 THEN 'Less Than Averageveh_bodyClaims'
    ELSE 'On Averageveh_bodyClaims'
  End AS veh_body_CAT
  FROM IncurredClaims
  ORDER BY DivationFromAverageAllClaims ASC,DivationFromAverageveh_bodyClaims ASC





SELECT
veh_body_CAT,
SUM(ClaimCost) AS TT
FROM(
 SELECT 
  veh_body,
  ROUND(claimcst0,2) AS ClaimCost,
  ROUND(AVG(claimcst0) OVER(ORDER BY claimcst0 DESC),2) AS AverageAllClaims,
  ROUND(AVG(claimcst0) OVER(PARTITION BY veh_body),2) AS Averageveh_bodyClaims,
  ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(ORDER BY claimcst0 DESC),2) AS DivationFromAverageAllClaims,
  ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(PARTITION BY veh_body),2) AS DivationFromAverageveh_bodyClaims,
  CASE
    WHEN ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(PARTITION BY veh_body),2) > 0 THEN 'More Than Averageveh_bodyClaims'
    WHEN ROUND(claimcst0,2)-ROUND(AVG(claimcst0) OVER(PARTITION BY veh_body),2) < 0 THEN 'Less Than Averageveh_bodyClaims'
    ELSE 'On Averageveh_bodyClaims'
  End AS veh_body_CAT
  FROM IncurredClaims)t
GROUP BY veh_body_CAT













