SELECT
    p.PropertyType
    ,COUNT(*) AS NumberOfSales
FROM
    PricePaidSW12 p
GROUP BY p.PropertyType
ORDER BY NumberOfSales DESC;

-- number of sales by year
-- What was the total market value in £ Millions of all the sales each year?

SELECT
    YEAR(p.TransactionDate) AS TheYear
    ,COUNT(*) AS NumberOfSales
    , SUM(p.Price) /1000000.0 As MarketValueinMillions
FROM
    PricePaidSW12 p
GROUP BY YEAR(p.TransactionDate)
ORDER BY TheYear;

SELECT YEAR('2024-07-17') AS YearOfDate;

-- List all the sales in 2018 between £400,000 and £500,000 in Cambray Road (a street in SW12)
SELECT
    p.TransactionDate
    ,p.Price
    ,p.Street
    ,p.County
FROM
    PricePaidSW12 p
WHERE
    p.Street = 'Cambray Road'
    AND p.Price BETWEEN 400000 AND 500000
    AND p.TransactionDate BETWEEN '2018-01-01' AND '2018-12-31'
ORDER BY p.TransactionDate; 


-- Homework Part 1
-- Write a SQL query that lists the 25 latest sales in Ormeley Road with the following fields: TransactionDate, Price, PostCode, PAON

SELECT
    TOP 25
    p.TransactionDate
    ,p.Price
    ,p.PostCode
    ,p.PAON
    , p.PropertyType
FROM
    PricePaidSW12 AS p
WHERE Street = 'Ormeley Road'
ORDER BY TransactionDate DESC



-- Homework Part 2
-- There is a table named PropertyTypeLookup .  This has columns PropertyTypeCode  and PropertyTypeName.  The values in PropertyTypeCode  match those in the PropertyType column of The PricePaidSW12 table.   The values in PropertyTypeName are the full name of the property type e.g. Flat, Terraced

select * from PropertyTypeLookup;

-- Write a SQL query that joins on table  PropertyTypeLookup to include column PropertyTypeName in the result.

/*
this
is
a 
multi-line comment
that will not be executed
but is useful for documentation purposes
and can be used to explain the purpose of the query
or to provide additional context for the reader
*/

SELECT
    TOP 25
    p.TransactionDate
    ,p.Price
    ,p.PostCode
    ,p.PAON
    , p.PropertyType
    , CASE p.PropertyType  -- simple
        WHEN 'F' THEN 'Flat'
        WHEN 'T' THEN 'Terraced'
        ELSE 'Unknown'
    END AS PropertyTypeNameSimple
    , CASE -- Searched
        WHEN p.PropertyType IN ('D', 'S', 'T') THEN 'Freehold'
        ELSE 'leasohold'
    END AS PropertyDuration
FROM
    PricePaidSW12 AS p
WHERE Street = 'Ormeley Road'  -- a very nice street in Balham
ORDER BY TransactionDate DESC
