Param(
    [Parameter(Mandatory = $true)]
    [string] $buildProjectFolder,
    [Parameter(Mandatory = $true)]
    [string] $buildOutputFolder

)
$username = $env:DOCKERUSER
$password = ConvertTo-SecureString -String $env:DOCKERPASS -AsPlainText -Force 
$credential = New-Object PSCredential -ArgumentList $username, $password

Compile-AppInNavContainer `
    -containerName $env:CONTAINERNAME `
    -credential $credential `
    -appProjectFolder $buildProjectFolder `
    -appOutputFolder $buildOutputFolder | Out-Null
