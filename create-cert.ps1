<# This script is a modified version of the instructions shown at 
https://www.sharepointdiary.com/2020/12/how-to-sign-powershell-script.html #>

param(
    # The name in the CN field of the certificate
    [string]$certificateName,

    # The relative path inside the Documents folder where the certificate will be saved
    [string]$relativePathInsideDocuments
)


# Check if $certificateName has benn provided
if (-not $certificateName) {
    $certificateName = Read-Host "Insert the name that will be displayed in the CN field"
}

if($certificateName.Length -lt 1) {
    Write-Host "The name cannot be empty."
    exit 1
}

 
#Create a Self-Signed SSL certificate
$Certificate = New-SelfSignedCertificate -CertStoreLocation Cert:\CurrentUser\My -Subject "CN=$certificateName" -KeySpec Signature -Type CodeSigningCert
 
#Export the Certificate to "Documents" Folder in your computer
$CertificatePath = [Environment]::GetFolderPath("MyDocuments")+"\$relativePathInsideDocuments\$certificateName.cer"
Export-Certificate -Cert $Certificate -FilePath $CertificatePath
 
#Add Certificate to the "Trusted Root Store"
Get-Item $CertificatePath | Import-Certificate -CertStoreLocation "Cert:\LocalMachine\Root"
  
Write-host "Certificate Thumbprint:" $Certificate.Thumbprint