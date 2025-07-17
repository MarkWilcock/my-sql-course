-- standard select / where / order by
SELECT 
    ps.PatientId
    , ps.Hospital
    , PS.Ward
    , ps.AdmittedDate
    , ps.DischargeDate
    , DATEDIFF(DAY, ps.AdmittedDate, ps.DischargeDate) AS LengthOfStay
    , DATEADD(WEEK, 2, ps.AdmittedDate) AS ReminderDate
    , ps.Tariff 
FROM PatientStay ps
WHERE ps.Hospital IN ('Kingston', 'PRUH')
AND ps.Ward LIKE '%Surgery'
AND ps.AdmittedDate BETWEEN '2024-02-27' AND '2024-03-01'
AND ps.Tariff > 5
ORDER BY 
    ps.AdmittedDate DESC, 
    ps.PatientId DESC

-- group by and summarise
SELECT 
    ps.Hospital
    , ps.Ward
    ,COUNT(*) AS NumberOfPatients
    , SUM(ps.Tariff) AS TotalTariff
    , AVG(PS.Tariff) AS AverageTariff
FROM 
    PatientStay ps
GROUP BY 
    ps.Hospital
    , ps.Ward
ORDER BY 
    NumberOfPatients DESC

SELECT * FROM DimHospitalBad

-- Example of a JOIN
SELECT 
    ps.PatientId
    ,ps.AdmittedDate
    , ps.Hospital
    ,h.Hospital
    ,h.HospitalSize
FROM PatientStay ps LEFT JOIN DimHospitalBad h ON ps.Hospital = h.Hospital


SELECT
    ps.PatientId 
    ,ps.AdmittedDate
    ,h.Hospital 
    ,h.HospitalSize
FROM
    PatientStay ps
    LEFT JOIN DimHospitalBad h ON ps.Hospital = h.Hospital
