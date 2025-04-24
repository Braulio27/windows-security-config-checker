# Obtener el Service Tag (número de serie) del equipo
$serviceTag = (Get-WmiObject -Class Win32_BIOS).SerialNumber

# Generar contenido XML
if ($serviceTag) {
    $xmlOutput += "<ServiceTagDelEquipo>`n"
    $xmlOutput += "  <ServiceTag>$serviceTag</ServiceTag>`n"
    $xmlOutput += "</ServiceTagDelEquipo>"
} else {
    $xmlOutput += "<ServiceTagDelEquipo>`n"
    $xmlOutput += "  <Mensaje>No se pudo obtener el Service Tag del equipo.</Mensaje>`n"
    $xmlOutput += "</ServiceTagDelEquipo>"
}

# Devolver el resultado como XML
Write-Output $xmlOutput
