/*
 * Tally Tables Exercise

 * The temporary table, #PatientAdmission, has values for dates between the 1st and 8th January inclusive
 * But not all dates are present
 */

DROP TABLE IF EXISTS #PatientAdmission;
CREATE TABLE #PatientAdmission (AdmittedDate DATE, NumAdmissions INT);
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-01', 5)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-02', 6)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-03', 4)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-05', 2)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-08', 2)
SELECT * FROM #PatientAdmission

/*
 * Exercise: create a resultset that has a row for all dates in that period 
 * of 8 days with NumAdmissions set to 0 for missing dates. 
 You may wish to use the SQL statements below to set the start and end dates
 */

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
SELECT @StartDate = DATEFROMPARTS(2024, 1, 1);
SELECT @EndDate = DATEFROMPARTS(2024, 1, 8);

SELECT
    DATEADD(DAY, N-1, @StartDate) AS AdmittedDate
FROM
    Tally
WHERE N <= @NumDays
ORDER BY N;


/*
 * Exercise: list the dates that have no patient admissions
*/

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
SELECT @StartDate = DATEFROMPARTS(2024, 1, 1);
SELECT @EndDate = DATEFROMPARTS(2024, 1, 8);
DECLARE @NumDays INT = DATEDIFF(DAY, @StartDate, @EndDate) + 1;

DROP TABLE IF EXISTS #Dates;

SELECT
    DATEADD(DAY, N-1, @StartDate) AS AdmittedDate
into #Dates
FROM
    Tally
WHERE N <= @NumDays
ORDER BY N;

select * from #Dates

SELECT
    *
FROM
    #Dates d
WHERE d.AdmittedDate NOT IN 
    (SELECT p.AdmittedDate FROM  #PatientAdmission p)

-- NOT EXISTS is a better way to do this

SELECT
    *
FROM
    #Dates d
WHERE NOT EXISTS 
    (SELECT * FROM  #PatientAdmission p WHERE p.AdmittedDate = d.AdmittedDate)


-- LEFT JOIN
SELECT
    *
FROM
    #Dates d left join #PatientAdmission p
    ON d.AdmittedDate = p.AdmittedDate
WHERE p.AdmittedDate IS NULL

-- LEFT JOIN, but with ISNULL to replace NULLs with 0
SELECT
    d.AdmittedDate
    , ISNULL(p.NumAdmissions, 0) AS NumAdmissions   
FROM
    #Dates d left join #PatientAdmission p
    ON d.AdmittedDate = p.AdmittedDate

-- except

    SELECT
        AdmittedDate
    FROM
        #Dates
EXCEPT
    SELECT
        AdmittedDate
    FROM
        #PatientAdmission
