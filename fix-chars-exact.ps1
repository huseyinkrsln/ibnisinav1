$rootDir = $PSScriptRoot

$files = Get-ChildItem -Path $rootDir -Filter *.html -Recurse

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Replace the exact corrupted strings seen in the user's screenshot
    $content = $content -replace "TÄ±bbi Birimler", "T&#305;bbi Birimler"
    $content = $content -replace "Online Ä°ÅŸlemler", "Online &#304;&#351;lemler"
    $content = $content -replace "Ä°letiÅŸim", "&#304;leti&#351;im"
    
    # Also fix the href links
    $content = $content -replace "tÄ±bbibirimler.html", "t&#305;bbibirimler.html"
    
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    Write-Host "Fixed chars in $($file.Name)"
}
