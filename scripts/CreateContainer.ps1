$username = $env:DOCKERUSER
$password = ConvertTo-SecureString -String $env:DOCKERPASS -AsPlainText -Force 
$credential = New-Object PSCredential -ArgumentList $username, $password
$licenseFile = $env:LICENSE_SECUREFILEPATH

$segments = "$PSScriptRoot".Split('\')
$rootFolder = "$($segments[0])\$($segments[1])"
$additionalParameters = @("--volume ""$($rootFolder):C:\agent""")

New-NavContainer `
    -containerName d365bc-14 `
    -accept_eula `
    -accept_outdated `
    -alwaysPull `
    -auth NavUserPassword `
    -Credential $credential `
    -imageName mcr.microsoft.com/businesscentral/sandbox:14.5.35970.37061 `
    -licenseFile $licenseFile `
    -memoryLimit 4G `
    -shortcuts Desktop `
    -useBestContainerOS `
    -updateHosts `
    -doNotExportObjectsToText `
    -doNotCheckHealth `
    -EnableTaskScheduler:$false `
    -additionalParameters $additionalParameters
