## Use case

These scripts make easy creating a new certificate and use it to sign a PowerShell script, so that it can be executed on any PC by default, without having to lower the ExecutionPolicy security model.

## Usage

### Create a new certificate

``.\create-cert.ps1 $certName [$relativePathInsideDocuments]``

``$certName`` will be both the generated .cer file and the value of the CN field showed when trying to execute a script signed with that certificate.  
``$relativePathInsideDocuments`` is the relative position inside the user's Documents folder where the .cer file will be saved.


### Sign a script
In order to sign the script you have to create a file named *variables.ps1* in the same folder of *sign-script.ps1*. This file must contain the following variable: 

``$certificateThumbrint = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"``  
where you have to substitute the Xs for the certificate thumbrint that will be printed when you create the certificate.  

After that, simply run:  
``.\sign-script.ps1 $scriptPath``  

``$scriptPath`` is the path of the script to be signed.


