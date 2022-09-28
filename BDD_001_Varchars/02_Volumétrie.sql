
--------------------------------- ETAPE 2 --------------------------------------------------
--
-- Insertion d'un million de lignes 
--

WITH lines AS (
    SELECT 
		1 AS line_num,
		CONVERT(varchar(255), NEWID()) AS random_string
    UNION ALL
    SELECT 
		line_num + 1 AS line_num,
		CONVERT(varchar(255), NEWID()) AS random_string 
	FROM 
		lines 
	WHERE 
		line_num + 1 <= 1000000
)
INSERT INTO 
	[dbo].[test_nvarchar] (label)
SELECT 
	random_string 
FROM 
	lines
OPTION (MAXRECURSION 0)


-- Calcul de l'utilisation du disque
SELECT 
    t.NAME AS TableName,    
    p.rows,    
    CAST(ROUND(((SUM(a.used_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS UsedSpaceMB
FROM 
    sys.tables t
	JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
	JOIN sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
	JOIN sys.allocation_units a ON p.partition_id = a.container_id	
WHERE 
    t.NAME NOT LIKE 'dt%' 
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255 
GROUP BY 
    t.Name, p.Rows
ORDER BY 
    t.Name

