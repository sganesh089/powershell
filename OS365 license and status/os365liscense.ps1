import-module MSOnline
Connect-MSOLService

$users = import-csv "C:\Users\Ganesh.Shanmugam\Downloads\os365license.csv" -delimiter ","
foreach ($user in $users)
{
    $upn=$user.UserPrincipalName
    $usagelocation=$user.usagelocation 
    $SKU=$user.SKU
    Set-MsolUser -UserPrincipalName $upn -UsageLocation $usagelocation
    Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses $SKU
} 