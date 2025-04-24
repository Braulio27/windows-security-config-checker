# Obtener GPOs aplicadas al equipo
$gpoComputadora = @()
$gpresultComp = gpresult /SCOPE COMPUTER /R
$capturando = $false

foreach ($line in $gpresultComp) {
    if ($line -match "^\s*Objetos de directiva de grupo aplicados") {
        $capturando = $true
        continue
    }
    if ($capturando -and $line.Trim() -eq "") {
        break
    }
    if ($capturando -and $line -match "^\s{4,}(.+)$") {
        $gpoComputadora += $matches[1].Trim()
    }
}

# Obtener GPOs aplicadas al usuario
$gpoUsuario = @()
$gpresultUser = gpresult /SCOPE USER /R
$capturando = $false

foreach ($line in $gpresultUser) {
    if ($line -match "^\s*Objetos de directiva de grupo aplicados") {
        $capturando = $true
        continue
    }
    if ($capturando -and $line.Trim() -eq "") {
        break
    }
    if ($capturando -and $line -match "^\s{4,}(.+)$") {
        $gpoUsuario += $matches[1].Trim()
    }
}

# Mostrar los resultados
Write-Host "`nGPOs aplicadas al EQUIPO:"
$gpoComputadora | ForEach-Object { Write-Host "- $_" }

Write-Host "`nGPOs aplicadas al USUARIO:"
$gpoUsuario | ForEach-Object { Write-Host "- $_" }
