<# This script is a modified version of the instructions shown at 
https://www.sharepointdiary.com/2020/12/how-to-sign-powershell-script.html #>

param(
    # The path of the script to be signed
    [string]$scriptPath
)

# Check if $scriptPath has been provided
if (-not $scriptPath) {
    $scriptPath = Read-Host "Insert the path of the script to be signed"
}

# Check if file exists
if (-not (Test-Path $scriptPath)) {
    Write-Host "The file doesn't exist: ""$scriptPath""."
    exit 1
}

# Declare a variable $certificateThumbrint in this file 
. .\variables.ps1

# Get the Certificate from Cert Store
$CodeSignCert = Get-ChildItem -Path Cert:\CurrentUser\My | Where-Object {$_.Thumbprint -eq $certificateThumbprint}
 
# Sign the .ps1 file
Set-AuthenticodeSignature -FilePath $scriptPath -Certificate $CodeSignCert