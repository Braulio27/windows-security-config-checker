# Obtener la versión del sistema operativo
$osVersion = [System.Environment]::OSVersion
$version = $osVersion.Version
$versionString = $version.ToString()

$htmlOutput = '<section class="mb-6">
        <h2 class="font-semibold text-gray-700 mb-2">Versi&#243;n del sistema operativo</h2>
        <div class="bg-green-100 border border-green-400 text-green-800 rounded-md p-4">
            <p>Versi&#243;n de Windows: <strong>' + $versionString + '</strong></p>
        </div>
    </section>'

# Mostrar la versión
Write-Output $htmlOutput
