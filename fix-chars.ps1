$rootDir = $PSScriptRoot

$files = Get-ChildItem -Path $rootDir -Filter *.html -Recurse

foreach ($file in $files) {
    # Read with UTF8
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Replace the mangled words in the mobile menu
    $content = $content -replace "T.bbi Birimler", "T&#305;bbi Birimler"
    $content = $content -replace "Online .Ylemler", "Online &#304;&#351;lemler"
    $content = $content -replace ".leti.Yim", "&#304;leti&#351;im"
    $content = $content -replace "t.bbibirimler.html", "t&#305;bbibirimler.html"
    
    # Write back
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    Write-Host "Fixed $($file.Name)"
}
