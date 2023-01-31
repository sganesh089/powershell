$csv   = import-csv -Path "C:\Users\Ganesh.Shanmugam\Downloads\email test.csv"
$creds = (Get-Credential)

foreach ($row in $csv) {
    $ID          = $row.ID  
    $Password    = $row.Password 
    #$attachment  = "C:\Users\Ganesh.Shanmugam\Downloads\How to access new Titanium Remote Desktop.docx"
    $mailproperties = @{
        from        = "ganesh.shanmugam@kytec.com.au"
        to          = $row.Email
        cc          = "registrar@isn.edu.au", "ganesh.shanmugam@kytec.com.au" 
        subject     = "ISN password reset instructions"
        #attachment  = $attachment
        smtpserver  = "smtp.office365.com" 
        port        = 587
        usessl      = $true
        body       = "  Hi,

                        Below are the steps to reset the password after first login:
 
                        Id: $ID
                        Password: $Password

                       
                        Change your Microsoft 365 for business password to keep your account secure.

                        1. Sign in to office.com/signin with your work or school account.

                        2. Go to Settings > Password.

                        3. Enter your old password.

                        4. Create a new password and confirm it.

                        5. Select Submit to finish and change your password.

                         
                        If you have any issues please contact Kytec via call 1300 282 257 or Email: kytecprod@service-now.com.

                 
                        "
        credential = $creds
    }
    send-mailmessage @mailproperties
}