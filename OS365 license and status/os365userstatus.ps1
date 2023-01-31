import-module MSOnline
Connect-MSOLService

$users = import-csv "C:\Users\Ganesh.Shanmugam\Downloads\os365license.csv" -delimiter ","
foreach ($user in $users)
{
    $upn=$user.UserPrincipalName
    $usagelocation=$user.usagelocation 
    $SKU=$user.SKU
    Get-MsolUser -UserPrincipalName $upn | select-object DisplayName,IsLicensed
    #Get-MsolUser -All| select-object DisplayName,IsLicensed
    
} 

