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
ORDER BY 
    ps.AdmittedDate DESC, 
    ps.PatientId DESC