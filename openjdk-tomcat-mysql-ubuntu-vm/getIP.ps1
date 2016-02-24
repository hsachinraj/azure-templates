$servicename=$args[0]
$vmname=$args[1]
Write-Verbose -Verbose "Service name = $servicename"
Write-Verbose -Verbose "VM name = $vmname"
	
$vmIpAddress = (Get-AzureVm -ServiceName $servicename -Name $vmname  | get-AzureEndpoint -Name HTTP | select-object vip).vip
$vmHTTPPort = (Get-AzureVm -ServiceName $servicename -Name $vmname  | get-AzureEndpoint -Name HTTP | select-object port).port
Write-Verbose -Verbose "Ip address=$vmIpAddress"
	Write-Verbose -Verbose "HTTP POrt=$vmHTTPPort"
Write-Verbose -Verbose "##vso[task.setvariable variable=ipaddr;]$vmIpAddress" 
Write-Verbose -Verbose "##vso[task.setvariable variable=httpport;]$vmHTTPPort" 
