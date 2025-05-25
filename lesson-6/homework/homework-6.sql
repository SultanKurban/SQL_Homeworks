1.
SELECT 
	CASE WHEN col1<col2 THEN col1 ELSE col2 END AS col1,
	CASE WHEN col1<col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl

GROUP BY
	CASE WHEN col1<col2 THEN col1 ELSE col2 END,
	CASE WHEN col1<col2 THEN col2 ELSE col1 END

2.
SELECT * FROM TestMultipleZero
WHERE A=1 or B=1 or C=1 or D=1;

3.
SELECT * FROM section1
WHERE id % 2 <> 0

4.
SELECT min(id)
FROM section1

5.
SELECT max(id)
FROM section1

6.
SELECT name FROM section1
WHERE name like ('b%')

7.
SELECT Code FROM ProductCodes
WHERE Code like ('%[_]%')



