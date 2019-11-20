param(
    [Parameter(Mandatory = $true)]
    [string] $ContainerName,
    [Parameter(Mandatory = $true)]
    [ValidateSet('NAV', 'BC')]
    [string] $ServerInstace = "NAV",
    [Parameter(Mandatory = $true)]
    [string] $user,
    [Parameter(Mandatory = $true)]
    [string] $WebServiceAccessKey,
    [string] $ContainerPort = "7049",
    [Parameter(Mandatory = $true)]
    [string] $ArtifactName
)

$AppPath = Get-ChildItem -Path "$env:System_ArtifactsDirectory\$env:Release_PrimaryArtifactSourceAlias\$artifactname" -Filter '*.app'

$APIUrl = 'dev/apps'
$Uri = "$($ContainerName):$($ContainerPort)/$ServerInstace/$APIUrl"

$fileBytes = [System.IO.File]::ReadAllBytes($AppPath.FullName)
$fileEnc = [System.Text.Encoding]::GetEncoding('iso-8859-1').GetString($fileBytes)
$boundary = [System.Guid]::NewGuid().ToString() 
$LF = "`r`n"

$Headers = @{
    Authorization = 'Basic' + " " + $([System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("$($user):$($WebServiceAccessKey)")))
}

$bodyLines = ( 
    "--$boundary",
    "Content-Disposition: form-data; name=`"`"; filename=`"$AppPath`"",
    "Content-Type: application/octet-stream$LF",
    $fileEnc,
    "--$boundary--$LF" 
) -join $LF

$Result = ''
$Result = Invoke-RestMethod -Uri $Uri -Method Post -ContentType "multipart/form-data; boundary=`"$boundary`"" -Headers $Headers -Body $bodyLines
#$Result
