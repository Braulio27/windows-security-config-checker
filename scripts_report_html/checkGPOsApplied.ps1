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

# Construir HTML
$htmlOutput = @()
$htmlOutput += '<section class="mb-6">'
$htmlOutput += '  <h2 class="font-semibold text-gray-700 mb-2">Directivas de Grupo Aplicadas al Equipo</h2>'
if ($gpoComputadora.Count -gt 0) {
    $htmlOutput += '  <ul class="list-disc list-inside text-gray-800">'
    foreach ($gpo in $gpoComputadora) {
        $htmlOutput += "    <li>$gpo</li>"
    }
    $htmlOutput += '  </ul>'
} else {
    $htmlOutput += '  <p class="text-gray-600">No se encontraron directivas aplicadas al equipo.</p>'
}
$htmlOutput += '</section>'

$htmlOutput += '<section class="mb-6">'
$htmlOutput += '  <h2 class="font-semibold text-gray-700 mb-2">Directivas de Grupo Aplicadas al Usuario</h2>'
if ($gpoUsuario.Count -gt 0) {
    $htmlOutput += '  <ul class="list-disc list-inside text-gray-800">'
    foreach ($gpo in $gpoUsuario) {
        $htmlOutput += "    <li>$gpo</li>"
    }
    $htmlOutput += '  </ul>'
} else {
    $htmlOutput += '  <p class="text-gray-600">No se encontraron directivas aplicadas al usuario.</p>'
}
$htmlOutput += '</section>'

# Devolver resultado HTML
Write-Output ($htmlOutput -join "`n")
