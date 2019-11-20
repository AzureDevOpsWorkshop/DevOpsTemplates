param (
    [Parameter(Mandatory = $true)]
    [string] $buildProjectFolder
)
$RevisionVersion = $env:Build_BuildId

$appjson = Join-Path $buildProjectFolder 'app.json'
$jsonfile = Get-Content $appjson -Encoding UTF8 | ConvertFrom-Json
$currentVersion = [Version]$jsonfile.version
$newversion = "$($currentVersion.Major).$($currentVersion.Minor).$($currentVersion.Build).$RevisionVersion"
$jsonfile.version = $newversion
$jsonfile | ConvertTo-Json | Set-Content -Path $appjson -Encoding UTF8
Write-Host "##vso[task.setvariable variable=AppVersion]$($currentVersion.Major).$($currentVersion.Minor).$($currentVersion.Build)"
