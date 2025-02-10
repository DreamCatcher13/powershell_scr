param ([string]$Scenario)

if ( -not $Scenario) {
    Write-Host "You need to specify your scenario: reply or confirm"
    exit 1
}

$folder = "C:\Users\user\Docs\project1"

$dirContent = (Get-ChildItem -Path $folder | Select-Object -ExpandProperty Name)

if ($Scenario -eq 'reply') {
    try {
        $ntl = ($dirContent | Select-String  -Pattern "Nettle_INC.*").ToString()
        $exp = ($dirContent | Select-String  -Pattern "Exp.*_validated.*").ToString() 
    }
    catch {
        throw
    }
    $reply = "Hello,
We have uploaded the following files to the database:

- $ntl
- $exp"
    Write-Host $reply
} elseif ($Scenario -eq 'confirm') {
    $exp = ($dirContent | Select-String  -Pattern "Exp.*_validated.*").ToString() 
    $confirm = "Hello,
Are you sure you want to upload only $exp?"
    Write-Host $confirm
} else {
    Write-Host "Scenario $($Scenario) doesn't exist"
}
