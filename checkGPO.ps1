# Obtiene las GPO aplicadas al equipo desde el dominio
$gpoResult = gpresult /r /scope computer | Select-String "Nombre de GPO" | ForEach-Object { $_.Line }

# Verifica si se encontraron GPO aplicadas
if ($gpoResult) {
    $htmlOutput = "<h2>Politicas de Grupo Aplicadas</h2>`n<ul>"
    foreach ($gpo in $gpoResult) {
        # Extrae el nombre de la GPO eliminando el texto inicial
        $gpoName = $gpo -replace "Nombre de GPO:\s+", ""
        $htmlOutput += "<li>$gpoName</li>"
    }
    $htmlOutput += "</ul>"
} else {
    $htmlOutput = "<h2>Políticas de Grupo Aplicadas</h2>`n<p>No se encontraron GPO aplicadas al equipo.</p>"
}

# Devuelve el resultado como HTML
Write-Output $htmlOutput
