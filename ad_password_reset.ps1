# Import the Active Directory module
Import-Module ActiveDirectory -ErrorAction Stop

# Define a list of words to use in the password
$words = "apple", "banana", "cherry", "date", "elderberry", "fig", "grape", "honeydew", "iceplant", "jackfruit", "kiwi", "lemon", "mango", "nectarine", "orange", "pineapple", "quince", "raspberry", "strawberry", "tangerine", "victoria", "watermelon", "yellow", "zucchini", "ant", "bird", "car", "door", "egg", "flower", "guitar", "hat", "icecream", "juice", "kangaroo", "lamp", "monkey", "nest", "ocean", "pencil", "queen", "rainbow", "star", "tree", "umbrella", "violin", "window", "yogurt", "zebra", "alligator", "butterfly", "cloud", "dolphin", "elephant", "frog", "giraffe", "iguana", "jellyfish", "koala", "lion", "mouse", "octopus", "penguin", "quail", "rabbit", "snail", "tiger", "unicorn", "vulture", "wolf", "yak"

while ($true) {
    try {
        # Generate a random password
        $random = Get-Random -Minimum 10 -Maximum 99
        $word1 = Get-Random -InputObject $words
        $word2 = Get-Random -InputObject $words
        $newPassword = "$word1$random$word2".Substring(0,1).ToUpper()+ "$word1$random$word2".Substring(1)

        # Prompt for user information
        $searchOption = Read-Host "Search by Full Name(1) or Employee ID(2)?"

        if ($searchOption -eq "1") {
            $fullName = Read-Host "Enter full name"
            $user = Get-ADUser -Filter {Name -eq $fullName} -ResultSetSize $null
        } elseif ($searchOption -eq "2") {
            $employeeID = Read-Host "Enter employee ID"
            $user = Get-ADUser -Filter {EmployeeID -eq $employeeID} -Properties EmployeeID -ResultSetSize $null
        }

        if ($user -ne $null) {
            # Reset the password
            Set-ADAccountPassword -Identity $user -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$newPassword" -Force)
            Write-Host "Password has been reset for user $($user.Name)"
            Write-Host "The new password is: $newPassword"
        } else {
            Write-Host "User not found"
        }
    }
    catch {
        Write-Host "An error has occurred: $_"
    }

    $continue = Read-Host "Do you want to continue? (y/n)"
    if ($continue -eq "n") {
        break
    }
}
