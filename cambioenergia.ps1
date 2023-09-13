# Definir el umbral de carga para cambiar los planes de energía
$umbralCarga = 30

# Definir los nombres de los planes de energía
$planAltoRendimiento = "9935e61f-1661-40c5-ae2f-8495027d5d5d"
$planEconomizador = "a1841308-3541-4fab-bc81-f71556f20b4a"

#Agregar un mensaje de salida para indicar que el script está en ejecución
Write-Host "Script en ejecución. Presiona Ctrl+C para detenerlo."

# Variable para realizar un seguimiento del estado actual del plan de energía
$planActual = ""

# Bucle infinito para monitorear la carga del sistema continuamente
while ($true) {
    # Obtener la carga actual del sistema
    $loadPercentage = (Get-WmiObject -Class Win32_Processor).LoadPercentage

    # Agregar un mensaje de salida para mostrar la carga actual del sistema
    #Write-Host "Carga actual del sistema: $loadPercentage%"

    # Comprobar si la carga supera o está por debajo del umbral
    if ($loadPercentage -ge $umbralCarga -and $planActual -ne $planAltoRendimiento) {
        # Cambiar al plan de energía "Alto Rendimiento" solo si no está actualmente en ese plan
        #Write-Host "Cambiando al plan de energía: $planAltoRendimiento"
        powercfg.exe /s "$planAltoRendimiento"
        $planActual = $planAltoRendimiento
    } elseif ($loadPercentage -lt $umbralCarga -and $planActual -ne $planEconomizador) {
        # Cambiar al plan de energía "Economizador" solo si no está actualmente en ese plan
        #Write-Host "Cambiando al plan de energía: $planEconomizador"
        powercfg.exe /s "$planEconomizador"
        $planActual = $planEconomizador
    }

    # Esperar un período antes de volver a verificar la carga del sistema (por ejemplo, cada 5 segundos)
    Start-Sleep -Seconds 5
}