SELECT TOP (20)
    schemas.name AS [schema],
    tables.name AS [table],
    indexes.name AS [index],
    index_stats.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS index_stats
INNER JOIN sys.tables AS tables ON tables.object_id = index_stats.object_id
INNER JOIN sys.schemas AS schemas ON tables.schema_id = schemas.schema_id
INNER JOIN sys.indexes AS indexes ON indexes.object_id = index_stats.object_id
    AND index_stats.index_id = indexes.index_id
WHERE index_stats.database_id = DB_ID()
    AND indexes.name IS NOT NULL
    AND index_stats.avg_fragmentation_in_percent > 0
ORDER BY index_stats.avg_fragmentation_in_percent DESC
