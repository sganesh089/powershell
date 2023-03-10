#Import Active Directory module
Import-Module ActiveDirectory
 
# Open file dialog
# Load Windows Forms
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
 
# Create and show open file dialog
$dialog = New-Object System.Windows.Forms.OpenFileDialog
$dialog.InitialDirectory = "C:\Users\kytecadmin\Downloads"
$dialog.Filter = "CSV (*.csv)| *.csv" 
$dialog.ShowDialog() | Out-Null

# Get file path
$CSVFile = $dialog.FileName

# Import file into variable
# Lets make sure the file path was valid
# If the file path is not valid, then exit the script
if ([System.IO.File]::Exists($CSVFile)) {
    Write-Host "Importing CSV..."
    $CSV = Import-Csv -LiteralPath "$CSVFile"
} else {
    Write-Host "File path specified was not valid"
    Exit
}

# Format their username
    #$Username = "$($user.'First Name'[0])$($user.'Last Name')"
    #$Username = $Username.Replace(" ", "")

foreach($user in $CSV) {

    #Remove-ADUser -Identity "$($Username)" -Confirm:$false ` 
    Remove-ADUser -Identity "$($user.'First Name'[0])$($user.'Last Name')" -Confirm:$false `

                   
                }