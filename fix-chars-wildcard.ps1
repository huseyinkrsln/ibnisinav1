$rootDir = $PSScriptRoot

$files = Get-ChildItem -Path $rootDir -Filter *.html -Recurse

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Replace using dots to match the corrupted 2-byte characters
    $content = $content -replace "T..bbi Birimler", "T&#305;bbi Birimler"
    $content = $content -replace "Online ..lemler", "Online &#304;&#351;lemler"
    $content = $content -replace "..leti..im", "&#304;leti&#351;im"
    $content = $content -replace "t..bbibirimler.html", "t&#305;bbibirimler.html"
    
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    Write-Host "Fixed chars in $($file.Name)"
}
