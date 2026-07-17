$rootDir = $PSScriptRoot

$menuHtml = @"
<!-- Mobile Menu Start -->
<div id="mobile-menu-overlay">
    <button id="mobile-menu-close" style="align-self: flex-end; background: none; border: none; font-size: 24px; cursor: pointer; padding: 10px;">&times;</button>
    <a href="INDEX_PATH">Anasayfa</a>
    <a href="SAYFALAR_PATHtıbbibirimler.html">Tıbbi Birimler</a>
    <a href="SAYFALAR_PATHhekimlerimiz.html">Hekimlerimiz</a>
    <a href="SAYFALAR_PATHonlineislemler.html">Online İşlemler</a>
    <a href="SAYFALAR_PATHiletisim.html">İletişim</a>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var navActions = document.querySelector('nav .flex.items-center.gap-stack-md');
        if (navActions && !document.getElementById('mobile-menu-btn')) {
            var btn = document.createElement('button');
            btn.id = 'mobile-menu-btn';
            btn.innerHTML = '<span class="material-symbols-outlined">menu</span>';
            navActions.appendChild(btn);
            
            btn.addEventListener('click', function() {
                document.getElementById('mobile-menu-overlay').classList.add('active');
            });
        }
        
        var closeBtn = document.getElementById('mobile-menu-close');
        if (closeBtn) {
            closeBtn.addEventListener('click', function() {
                document.getElementById('mobile-menu-overlay').classList.remove('active');
            });
        }
    });
</script>
<!-- Mobile Menu End -->
</body>
"@

$files = Get-ChildItem -Path $rootDir -Filter *.html -Recurse

foreach ($file in $files) {
    # Read with UTF8 explicitly
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    $cssPath = "mobile-fix.css"
    $indexPath = "index.html"
    $sayfalarPath = "sayfalar/"
    
    if ($file.DirectoryName -like "*sayfalar*") {
        $cssPath = "../mobile-fix.css"
        $indexPath = "../index.html"
        $sayfalarPath = ""
    }
    
    if ($content -notmatch "mobile-fix\.css") {
        $content = $content -replace "</head>", "<link rel=`"stylesheet`" href=`"$cssPath`">`n</head>"
    }
    
    if ($content -notmatch "mobile-menu-overlay") {
        $fileMenuHtml = $menuHtml -replace "INDEX_PATH", $indexPath -replace "SAYFALAR_PATH", $sayfalarPath
        $content = $content -replace "</body>", $fileMenuHtml
    }
    
    # Write with UTF8 explicitly
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    Write-Host "Updated $($file.Name)"
}
