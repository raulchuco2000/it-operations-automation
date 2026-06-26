<#
.SYNOPSIS
    Realiza un chequeo de salud básico de los servidores Windows.
.DESCRIPTION
    Consulta una lista de servidores para verificar el espacio en disco (C:) 
    y reporta aquellos que tienen menos del 15% de espacio libre. Útil para prevención de incidentes.
#>

$Servers = @("SRV-DC01", "SRV-FILE02", "SRV-APP03") # Reemplazar con Get-ADComputer en prod
$UmbralEspacio = 15 # Porcentaje

Write-Host "Iniciando auditoría de servidores..." -ForegroundColor Yellow

foreach ($Server in $Servers) {
    if (Test-Connection -ComputerName $Server -Count 1 -Quiet) {
        $Disco = Get-WmiObject Win32_LogicalDisk -ComputerName $Server -Filter "DeviceID='C:'"
        $EspacioLibrePorcentaje = [math]::Round(($Disco.FreeSpace / $Disco.Size) * 100, 2)

        if ($EspacioLibrePorcentaje -lt $UmbralEspacio) {
            Write-Host "⚠️ ALERTA: $Server tiene solo $EspacioLibrePorcentaje% de espacio libre en C:" -ForegroundColor Red
        } else {
            Write-Host "✅ $Server en estado óptimo ($EspacioLibrePorcentaje% libre)" -ForegroundColor Green
        }
    } else {
        Write-Host "❌ $Server no responde al ping." -ForegroundColor DarkGray
    }
}
