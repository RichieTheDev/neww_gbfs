SELECT 
    provider_name, 
    date_trunc('day', timestamp) AS day,
    vehicle_count,
    LAG(vehicle_count, 1) OVER (PARTITION BY provider_name ORDER BY timestamp) AS previous_count,
    ((vehicle_count - LAG(vehicle_count, 1) OVER (PARTITION BY provider_name ORDER BY timestamp)) / LAG(vehicle_count, 1) OVER (PARTITION BY provider_name ORDER BY timestamp)) * 100 AS percentage_change
FROM 
    gbfs_data
ORDER BY 
    day;
