function Get-WindowsKey {
    $KeyPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform'
    $DigitalProductId = (Get-ItemProperty -Path $KeyPath).BackupProductKeyDefault
    return $DigitalProductId
}

$windowskey = Get-WindowsKey

$htmlOutput = '<section class="mb-6">
        <h2 class="font-semibold text-gray-700 mb-2">Estado de Unión a Dominio</h2>
        <div class="bg-green-100 border border-green-400 text-green-800 rounded-md p-4">
            <p>El equipo está unido al dominio: <strong>' + $windowskey + '</strong></p>
        </div>
    </section>'

# Mostrar la versión
Write-Output $htmlOutput