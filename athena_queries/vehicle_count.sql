SELECT provider, date, SUM(vehicle_count) as total_vehicles
FROM gbfs_db.gbfs_data_table
GROUP BY provider, date
ORDER BY date DESC;
