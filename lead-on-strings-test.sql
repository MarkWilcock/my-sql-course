CREATE TABLE #Employees (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50)
);

INSERT INTO #Employees VALUES
(1, 'Alice', 'HR'),
(2, 'Bob', 'Finance'),
(3, 'Charlie', 'Finance'),
(4, 'Diana', 'HR');

-- Use LEAD on a VARCHAR column
SELECT
    EmployeeName,
    EmployeeID,
    Department,
    LEAD(EmployeeName, 1, 'No Next') OVER (PARTITION BY Department ORDER BY EmployeeID) AS NextEmployee
FROM #Employees;
