-- Calcul de l'utilisation du disque
SELECT 
    t.NAME AS TableName,    
    p.rows,    
    CAST(ROUND(((SUM(a.used_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS TableUsedSpaceMB,
	CAST(ROUND(((SUM(a.used_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) * (SUM(c.nb_nvarcharchars) / (SUM(c.nb_nvarcharchars+c.nb_othercolschars))) AS NvarcharUsedSpaceMB,
	CAST(ROUND(((SUM(a.used_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) * (SUM(c.nb_nvarcharchars) / (SUM(c.nb_nvarcharchars+c.nb_othercolschars)))*0.4 AS SpaceMBToGain
FROM 
    sys.tables t
	JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
	JOIN sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
	JOIN sys.allocation_units a ON p.partition_id = a.container_id	
	JOIN (SELECT 
				c.object_id, 
				SUM(CASE WHEN t.name='nvarchar' THEN 1 ELSE 0 END) AS nb_nvarcharcols, 
				SUM(CASE WHEN t.name='nvarchar' THEN c.max_length ELSE 0 END) AS nb_nvarcharchars, 
				SUM(CASE WHEN t.name='nvarchar' THEN 0 ELSE 1 END) AS nb_othercols, 
				SUM(CASE WHEN t.name='nvarchar' THEN 0 ELSE c.max_length END) AS nb_othercolschars, 
				COUNT(*) AS nb_cols 
			FROM  
				sys.columns c
				JOIN sys.types t ON t.user_type_id = c.user_type_id
			GROUP BY
				c.object_id) c ON t.object_id = c.object_id
WHERE 
    t.NAME NOT LIKE 'dt%' 
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255 
GROUP BY 
    t.Name, p.Rows
ORDER BY 
    t.Name






