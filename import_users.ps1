#Store the data from Users.csv in the $Users variable
$Users = Import-csv C:\lista_usera.csv

#Loop through each row containing user details in the CSV file
foreach ($User in $Users)
{
	#Read user data from each field in each row and assign the data to a variable as below

	
	$Firstname = $User.firstname
	$Lastname = $User.lastname
	$Password = $User.password
	$Username = $User.username
	$OU = $User.OU
	$Mail = $User.mail
	$Number = $User.number
	$SecurityGroup = $User.securitygroup

	#Check to see if the user already exists in AD
	if (Get-ADUser -F {SamAccountName -eq $Username})
	{
		#If user does exist, give a warning
		Write-Warning "A user account with username $Username already exist."
	}
	else
	{
		#User does not exist then create the new user account

        #Account will be created in the OU provided by the $OU variable read from the CSV file
		New-ADUser `
	-SamAccountName $Username `
	-UserPrincipalName "$Username@vladimir.putin" `
	-Name "$Firstname $Lastname" `
	-GivenName $Firstname `
	-Surname $Lastname `
	-Enabled $True `
	-DisplayName "$Lastname, $Firstname" `
	-Path $OU ``
	-OfficePhone $Number `
	-EmailAddress $Mail `
	-AccountPassword (convertto-securestring $Password -AsPlainText -Force)

	}
}
