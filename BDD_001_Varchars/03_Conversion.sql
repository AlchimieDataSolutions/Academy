
--------------------------------- ETAPE 3 --------------------------------------------------
--
-- Test de conversion de nvarchar en varchar
--

SELECT 
	* 
FROM 
	[dbo].[test_nvarchar]
WHERE
	[label] <> CONVERT(varchar(50), [label])

-- Conversion 
--ALTER TABLE [dbo].[test_nvarchar] ALTER COLUMN [label] NVARCHAR(50)
ALTER TABLE [dbo].[test_nvarchar] ALTER COLUMN [label] VARCHAR(50)

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

-- Rebuild de la table
ALTER TABLE [dbo].[test_nvarchar] REBUILD
