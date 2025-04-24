# Obtener las unidades de red conectadas
$networkDrives = Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 4 }

# Generar contenido HTML
if ($networkDrives) {
    $htmlOutput = '<div class="card border-info mb-3">
        <div class="card-header bg-info text-white">Unidades de Red Conectadas</div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead class="table-dark">
                        <tr>
                            <th>Letra de Unidad</th>
                            <th>Ruta de Red</th>
                            <th>Espacio Total (GB)</th>
                            <th>Espacio Libre (GB)</th>
                        </tr>
                    </thead>
                    <tbody>'

    foreach ($drive in $networkDrives) {
        $letter = $drive.DeviceID
        $networkPath = $drive.ProviderName
        $totalSpace = [math]::Round($drive.Size / 1GB, 2)
        $freeSpace = [math]::Round($drive.FreeSpace / 1GB, 2)

        $htmlOutput += "<tr><td>$letter</td><td>$networkPath</td><td>$totalSpace</td><td>$freeSpace</td></tr>"
    }

    $htmlOutput += '</tbody>
                </table>
            </div>
        </div>
    </div>'
} else {
    $htmlOutput = '<div class="alert alert-warning" role="alert">
        <h4 class="alert-heading">Unidades de Red Conectadas</h4>
        <p>No se encontraron unidades de red conectadas en el equipo.</p>
    </div>'
}

# Devolver el resultado como HTML
Write-Output $htmlOutput
