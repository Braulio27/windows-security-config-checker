# Obtener la versión del sistema operativo
$osVersion = [System.Environment]::OSVersion
$version = $osVersion.Version
$versionString = "Versión del sistema operativo: $($version.ToString())"

# Mostrar la versión
Write-Output $versionString
