/*
Foundation Recap Exercise

Use the table PatientStay.  
This lists 44 patients admitted to London hospitals over 5 days between Feb 26th and March 2nd 2024
*/

SELECT
    *
FROM
    PatientStay ps
;

/*
1. List the patients -
a) in the Oxleas or PRUH hospitals and
b) admitted in February 2024
c) only the Surgery wards

2. Show the PatientId, AdmittedDate, DischargeDate, Hospital and Ward columns only, not all the columns.
3. Order results by AdmittedDate (latest first) then PatientID column (high to low)
4. Add a new column LengthOfStay which calculates the number of days that the patient stayed in hospital, inclusive of both admitted and discharge date.
*/

-- Write the SQL statement here

SELECT
    ps.PatientId
    , ps.AdmittedDate
    , ps.DischargeDate
    , ps.Hospital
    , ps.Ward
    , DATEDIFF(DAY, ps.AdmittedDate, ps.DischargeDate) AS LOS
FROM PatientStay ps
WHERE ps.Hospital IN ('oxleas', 'PRUH')
    and ps.AdmittedDate BETWEEN '2024-02-01' AND '2024-02-29'
    AND ps.Ward LIKE '%Surgery'
order by ps.AdmittedDate DESC, PS.PatientId DESC


/*
5. How many patients has each hospital admitted? 
6. How much is the total tarriff for each hospital?
7. List only those hospitals that have admitted over 10 patients
8. Order by the hospital with most admissions first
*/

-- Write the SQL statement here

select 
    ps.Hospital,  
    COUNT(*) AS NumberOfPatients
    , SUM(ps.Tariff) AS TotalTariff
from PatientStay ps
where ps.PatientId > 1
GROUP BY ps.Hospital
HAVING sum(ps.Tariff) < 80


