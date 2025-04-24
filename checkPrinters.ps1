# Obtiene la lista de impresoras configuradas en el equipo
$printers = Get-Printer | Select-Object Name, DriverName, PrinterStatus

# Genera el contenido HTML
if ($printers) {
    $htmlOutput = '<div class="card border-primary mb-3">
        <div class="card-header bg-primary text-white">Impresoras Configuradas</div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead class="table-dark">
                        <tr>
                            <th>Nombre de la Impresora</th>
                            <th>Controlador</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>'

    foreach ($printer in $printers) {
        $name = $printer.Name
        $driver = $printer.DriverName
        $status = $printer.PrinterStatus
        
        # Traducción de los estados más comunes
        switch ($status) {
            0 { $status = "Desconocido" }
            1 { $status = "Otros" }
            2 { $status = "Listo" }
            3 { $status = "Imprimiendo" }
            4 { $status = "En pausa" }
            5 { $status = "Sin papel" }
            6 { $status = "Sin t&#243;ner" }
            7 { $status = "No disponible" }
            8 { $status = "Eliminando" }
            9 { $status = "Error" }
            10 { $status = "Inicializando" }
            11 { $status = "Apagado" }
            12 { $status = "Offline" }
            default { $status = "Estado desconocido" }
        }
        
        $htmlOutput += "<tr><td>$name</td><td>$driver</td><td>$status</td></tr>"
    }
    
    $htmlOutput += '</tbody>
                </table>
            </div>
        </div>
    </div>'
} else {
    $htmlOutput = '<div class="alert alert-warning" role="alert">
        <h4 class="alert-heading">Impresoras Configuradas</h4>
        <p>No se encontraron impresoras configuradas en el equipo.</p>
    </div>'
}

# Devuelve el resultado como HTML
Write-Output $htmlOutput
