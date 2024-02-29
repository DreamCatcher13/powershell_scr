# variables
$name = "notebooks-$(Get-Date -Format dd-MM-yyyy).zip"
$container = "https://url_of_my_storage.blob.core.windows.net/my_container"
$deleted = @()
$archive = "C:\Users\user\Docs\Archive"
$myNotebooks = @{
    Path = "C:\Users\user\Docs\notebooks\*"
    DestinationPath = "C:\Users\user\Docs\Archive\$name"
}

Write-Host "`nDeleting more than 30 days old zips`n###################################"
$old = (Get-ChildItem -Path $archive | Where-Object { $_.CreationTime -lt (Get-Date).AddDays(-30)})
$old | ForEach-Object {
    $deleted += $_.Name
    Remove-Item $_ 
}
Write-Host "Deleted: $deleted"

Write-Host "`nArchiving $name`n###################################"
Compress-Archive @myNotebooks
Write-Host "Archived" 

Write-Host "`nCopying $name to Azure`n###################################"
azcopy copy $myNotebooks.DestinationPath $container
Write-Host "Copied"

# write log
$content=(Get-Date -Format "dddd, MMMM dd, yyyy") + ":`n`t-- copied files: $name`n`t-- deleted files: $deleted"
Add-Content -Path "C:\Users\user\Docs\AZcopy.log" -Value $content

# one day I will add try {} block
