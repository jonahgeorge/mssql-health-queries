SELECT TOP (120)
  DATEADD(ms, ([timestamp] - ms_ticks), GETDATE())  AS [ts],
  CONVERT(xml, record).value(
    '(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]',
    'int'
  ) AS [ProcessUtilization]
FROM sys.dm_os_ring_buffers
CROSS JOIN sys.dm_os_sys_info
WHERE ring_buffer_type = 'RING_BUFFER_SCHEDULER_MONITOR'
ORDER BY [ts] DESC
