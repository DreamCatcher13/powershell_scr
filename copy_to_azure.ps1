# create an array of file paths
$myNotebooks = @(
    'C:\Users\user\Docs\notebook1\Main_first.one'
    'C:\Users\user\Docs\notebook2\Main_python.one'
    'C:\Users\user\Docs\notebook3\Main_golang.one'
)

$container = 'https://url_of_my_storage.blob.core.windows.net/my_container'

$date = (Get-Date).AddDays(-1) #yesterday

# check last modified time
foreach ($notebook in $myNotebooks) {
    if ((Get-Item $notebook).LastWriteTime -gt $date ) {
        $name = ($notebook -split '\\')[-1]
        Write-Host "Copying $name to azure`n###################################"
        azcopy copy $notebook $container
    }
}
