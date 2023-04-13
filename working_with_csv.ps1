param ($file)

if ( ! $file) {
    Write-Host "You must specify at least one file to process"
    exit 1
}

$file | ForEach-Object -Process { 
    $data=Import-Csv $_
    Get-Date
    Write-Host ""
    Write-Host "Data for $_" 
    $rows=$data | Measure-Object | Select-Object @{n='RowsNumber';e={($_.Count)}}
    $approved=$data | Measure-Object "Column1" -Sum | Select-Object @{n='Column1';e={($_.Sum)}}
    $requested=$data | Measure-Object "Column2" -Sum | Select-Object @{n='Column2';e={($_.Sum)}}
    Write-Host "Rows Number: $($rows.RowsNumber) `nColumn1: $($approved.Column1) `nColumn2: $($requested.Column2)"
    Write-Host ""
    Write-Host "First line from $_"
    $data | Select-Object -First 1
}
 
