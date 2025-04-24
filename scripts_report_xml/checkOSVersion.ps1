# Obtener la versión del sistema operativo
$osVersion = [System.Environment]::OSVersion
$version = $osVersion.Version

# Generar contenido XML
$xmlOutput += "<SistemaOperativo>`n"
$xmlOutput += "  <Version>$($version.ToString())</Version>`n"
$xmlOutput += "</SistemaOperativo>"

# Mostrar la versión como XML
Write-Output $xmlOutput
