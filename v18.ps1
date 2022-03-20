

$ITEM = [string]$args[0]
$ID = [string]$args[1]

$filelocation = "C:\Data\Zabbix\scripts\Job_Input_3.csv"

switch ($ITEM) 	{
				"DiscoverTasks" 	{
 									$empdata = Import-Csv $filelocation
									$apptasks_csv = $( $empdata | ? { $_.STATUS -like 'enabled' } ).TASK_SCHEDULER

									$apptask_total = (Get-ScheduledTask).TaskName

									[string[]]$apptasksok = $apptasks_csv | ?{$apptask_total -contains $_}
									
									$idx = 1
									$idxx = 1
									write-host "{"
									write-host " `"data`":[`n"
									
									foreach ($currentapptasks in $apptasksok)
										{
										if ($idx -lt $apptasksok.count)
											{										 
											$line= "{ `"{#APPTASKS}`" : `"" + $currentapptasks + "`" },"
											write-host $line
											}
										
										elseif ($idx -ge $apptasksok.count)
											{
											$line= "{ `"{#APPTASKS}`" : `"" + $currentapptasks + "`" }"
											write-host $line
											}
										$idx++;
										} 
									write-host
									write-host " ]"
									write-host "}"
									}										
				}
				
switch ($ITEM) 	{
				"DiscoverInvalidTasks" 	{
 									$empdata = Import-Csv $filelocation
									$apptasks_csv = $( $empdata | ? { $_.STATUS -like 'enabled' } ).TASK_SCHEDULER

									$apptask_total = (Get-ScheduledTask).TaskName

									[string[]]$apptask_notpresent = $apptasks_csv | ?{$apptask_total -notcontains $_}
									
									$idx = 1
									$idxx = 1
									write-host "{"
									write-host " `"data`":[`n"
									
									foreach ($invalidtasks in $apptask_notpresent)
										{
										if ($idxx -lt $apptask_notpresent.count)
											{										 
											$line= "{ `"{#INVALIDTASKS}`" : `"" + $invalidtasks + "`" },"
											write-host $line
											}
										
										elseif ($idxx -ge $apptask_notpresent.count)
											{
											$line= "{ `"{#INVALIDTASKS}`" : `"" + $invalidtasks + "`" }"
											write-host $line
											}
										$idxx++;
										}
									write-host
									write-host " ]"
									write-host "}"
									}										
				}

switch ($ITEM) 	{
				"DiscoverAllTasks" 	{
									$apptasks = Get-ScheduledTask | where {$_.state -like "Ready" -or "Running"}
									$apptasksok = $apptasks.TaskName

									$idx = 1
									write-host "{"
									write-host " `"data`":[`n"
									
									foreach ($currentapptasks in $apptasksok)
										{
										if ($idx -lt $apptasksok.count)
											{										 
											$line= "{ `"{#APPTASKS}`" : `"" + $currentapptasks + "`" },"
											write-host $line
											}
										
										elseif ($idx -ge $apptasksok.count)
											{
											$line= "{ `"{#APPTASKS}`" : `"" + $currentapptasks + "`" }"
											write-host $line
											}
										$idx++;
										} 
									write-host
									write-host " ]"
									write-host "}"
									}
				}

				
switch ($ITEM) 	{
				"TaskRunTime" 		{
									$empdata = Import-Csv $filelocation
									[string] $jobname = $ID		
									$jobavgruntime = $( $empdata | ? { $_.TASK_SCHEDULER -eq $jobname } ).AVG_RUNTIME_IN_MINS
									$sysDate = Get-Date
									$appDate = (Get-ScheduledTask | Where TaskName -eq $jobname | Where State -like "Running" | Get-ScheduledTaskInfo).LastRunTime
									
									If ($appDate)
										{										
										$duration = (($sysDate - $appDate).TotalSeconds)
										
										$jobavgruntime_2 = [int]$jobavgruntime * 60
										$jobavgruntime_3 = $jobavgruntime_2 + 300
										$duration_2 = [math]::Round($duration)
										
										If ($duration_2 -le $jobavgruntime_3)
											{
											echo $duration_2
											}
										
										else 
											{
											[int] 0
											}
										}
									
									else
										{
										[int] 1
										}										
									}
				}


switch ($ITEM) 	{
				"TaskLastResult" 	{				
									[string] $jobname = $ID
									$tasklastresult = (Get-ScheduledTask | Where TaskName -eq $jobname | Get-ScheduledTaskInfo).LastTaskResult
									echo $tasklastresult
									}
				}


switch ($ITEM) 	{
				"TaskLastRunTime" 	{
									[string] $jobname = $ID
									$tasklastruntime = (Get-ScheduledTask | Where TaskName -eq $jobname | Get-ScheduledTaskInfo).LastRunTime
									echo $tasklastruntime
									}
				}


switch ($ITEM) 	{
				"TaskNextRunTime" 	{
									[string] $jobname = $ID
									$tasknextruntime = (Get-ScheduledTask | Where TaskName -eq $jobname | Get-ScheduledTaskInfo).NextRunTime
									echo $tasknextruntime
									}
				}

switch ($ITEM) 	{
				"TaskState" 	{
									[string] $jobname = $ID
									$taskstate = (Get-ScheduledTask | Where TaskName -eq $jobname).State
									echo $taskstate
									Write-Output "The task $jobname is not found in System Task Scheduler."
									}
				}				

switch ($ITEM) 	{
				"JobStatusCompare" 	{
									$jobname = $ID
									$appstate = (Get-ScheduledTask | Where TaskName -eq $jobname).State

									if ($appstate)	
										{
										
										if ($appstate -like "Ready" -or "Running" -or "Disabled")
											{										
											
											if ($appstate -like "Ready")
												{
												$appstatenumericid = 1
												}		
											
											elseif ($appstate -like "Running")
												{
												$appstatenumericid = 3
												}
											
											elseif ($appstate -like "Disabled")
												{
												$appstatenumericid = 7
												}
												
											$serverName = 'LEAPTSTSQLIN01'
											$databaseName = 'lnpreprod'
											$UserName = 'zabixuser'
											$Password = 'Leap2018'
											$ServerConnection = "Data Source=$serverName; user id=$UserName; password=$Password;Initial Catalog=$databaseName;"

											$connection = New-Object System.Data.SqlClient.SqlConnection
											$connection.ConnectionString=$ServerConnection
											$connection.Open()
											$SqlQuery = $("select t_jsta from tttaad5001001 where t_cjob = '$($jobname)'")
											$command = $connection.CreateCommand()
											$command.CommandText = $SqlQuery

											$dt = New-Object System.Data.DataTable
											$da = New-Object System.Data.SqlClient.SqlDataAdapter $command
											$da.fill($dt) | out-null  
											
											foreach ($data in $dt) 
												{ 
												 $appstatesql = $data[0]
												}
												$connection.Close()
												
												if ($appstatenumericid -eq $appstatesql)
													{
													[int] 1
													}

												else 
													{
													[int] 0
													}	
												
											}
												
										else 
											{
											[int] 9
											}										
										}
									
									else 
										{
										[int] 10
										}

									}										
				}