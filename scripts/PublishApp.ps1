Param(
    [Parameter(Mandatory = $false)]
    [string] $buildArtifactFolder
)


$appFile = Get-ChildItem -Path $buildArtifactFolder -Filter "*.app" 
Write-Host "Publishing Application $appFile"
Publish-BCContainerApp -containerName $env:CONTAINERNAME -appFile $appFile.FullName -skipVerification -sync -install
