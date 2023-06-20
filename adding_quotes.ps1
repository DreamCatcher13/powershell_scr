param ($file)

if ( ! $file) {
    Write-Host "You must specify at least one file to process"
    exit 1
}

$data = Get-Content $file
$rowsToReplace = @()

# first row
$result = @()
$data[0].Split(",") | ForEach-Object {
    $result += ($_ -replace $_, '"$_"')
}
$rowsToReplace += ($result -join ",") + ","

# second row
$result = @()
$data[1].Split(",") | Select-Object -SkipLast 1 | ForEach-Object {
    if ($_ -eq "RR Amnt") {
        $_ = "DD Amnt"
    }
    $result += ($_ -replace $_, '"$_"')
}
$rowsToReplace += ($result -join ",")

ForEach ($i in (0,1)) {
    $data[$i] = $rowsToReplace[$i]
}

$outputFile = $file -Replace ".csv","_new.csv"
Set-Content $outputFile -Value $data
