# Obtener el Service Tag (número de serie) del equipo
$serviceTag = wmic bios get serialnumber

# Generar contenido HTML
if ($serviceTag) {
    $htmlOutput = "<h2>Service Tag del Equipo</h2>`n<p><strong>Service Tag:</strong> $serviceTag</p>"
} else {
    $htmlOutput = "<h2>Service Tag del Equipo</h2>`n<p>No se pudo obtener el Service Tag del equipo.</p>"
}

# Devolver el resultado como HTML
Write-Output $htmlOutput
