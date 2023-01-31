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

foreach($user in $CSV) {
 
    # Password
    $SecurePassword = ConvertTo-SecureString "$($user.'Password')" -AsPlainText -Force
 
    # Format their username
    $Username = "$($user.'First Name'[0])$($user.'Last Name')"
    $Username = $Username.Replace("-", "").Replace(" ", "").Replace("'", "")

    #Email address
    $EmailAddress = "$($user.'First Name'[0])$($user.'Last Name')@isn.edu.au" 
    $EmailAddress = $EmailAddress.Replace("-", "").Replace(" ", "").Replace("'", "")

    #Last name
    #$Lastname = "$($user.'Last Name')"
    #$Lastname = $Lastname.Replace('[^a-zA-Z0-9, ]','')

     
    
    # Create new user
    New-ADUser -Name "$($user.'First Name') $($user.'Last Name')" `
                -GivenName $user.'First Name' `
                -Surname $user.'Last Name' `
                -UserPrincipalName $EmailAddress `
                -SamAccountName $Username `
                -EmailAddress $EmailAddress `
                -Path "$($user.'Organizational Unit')" `
                -ChangePasswordAtLogon $false `
                -AccountPassword $SecurePassword `
                -Enabled $([System.Convert]::ToBoolean($user.Enabled))
 
    # Write to host that we created a new user
    Write-Host "Created $Username / $($user.'EmailAddress')"
 
    # If groups is not null... then iterate over groups (if any were specified) and add user to groups
    if ($User.'AddToGroups(csv)' -ne "") {
        $User.'AddToGroups(csv)'.Split(",") | ForEach {
            Add-ADGroupMember -Identity $_ -Members "$($Username)"
            Write-Host "Added $Username to $_ group" # Log to console
        }
    }
 
    # Write to host that we created the user
    Write-Host "Created user $Username with groups $($User.'AddToGroups(csv)')"
}
 
Read-Host -Prompt "Script complete... Press enter to exit."