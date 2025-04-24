# Obtiene el nombre del dominio al que el equipo está unido
$domainInfo = (Get-WmiObject -Class Win32_ComputerSystem).Domain
$workgroupInfo = (Get-WmiObject -Class Win32_ComputerSystem).Workgroup

# Verifica si el equipo está unido a un dominio
if ($domainInfo -and $domainInfo -ne $env:COMPUTERNAME) {
    $htmlOutput = '<section class="mb-6">
        <h2 class="font-semibold text-gray-700 mb-2">Estado de Uni&#243;n a Dominio</h2>
        <div class="bg-green-100 border border-green-400 text-green-800 rounded-md p-4">
            <p>El equipo est&#225; unido al dominio: <strong>' + $domainInfo + '</strong></p>
        </div>
    </section>'
} else {
    $htmlOutput = '<section class="mb-6">
        <h2 class="font-semibold text-gray-700 mb-2">Estado de Uni&#243;n a Dominio</h2>
        <div class="bg-yellow-100 border border-yellow-400 text-yellow-800 rounded-md p-4">
            <p>El equipo no est&#225; unido a ningún dominio. Está en el grupo de trabajo: <strong>' + $workgroupInfo + '</strong></p>
        </div>
    </section>'
}

# Devuelve el resultado como HTML
Write-Output $htmlOutput
