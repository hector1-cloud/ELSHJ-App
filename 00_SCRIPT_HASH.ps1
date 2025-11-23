# El Lenguaje Secreto de Héctor Jazziel — Script de checksums (PowerShell)
# Uso:
#   1) Abre PowerShell en la carpeta ELSHJ_Master
#   2) Ejecuta: .\17_Scripts\22_00_SCRIPT_HASH.ps1
#   3) Si la ejecución está restringida: Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$ErrorActionPreference = 'Stop'

# Raíz y salida
$Root   = Split-Path -Parent $MyInvocation.MyCommand.Path
$Out    = Join-Path (Split-Path $Root -Parent) '00_HASHLIST.txt'

# Recolectar archivos (excluir el HASHLIST y los scripts)
$AllFiles = Get-ChildItem -LiteralPath (Split-Path $Root -Parent) -Recurse -File |
    Where-Object {
        $_.FullName -notmatch '00_HASHLIST\.txt$' -and
        $_.FullName -notmatch '21_00_SCRIPT_HASH\.sh$' -and
        $_.FullName -notmatch '22_00_SCRIPT_HASH\.ps1$'
    } | Sort-Object FullName

# Encabezado
$header = @"
## HASHLIST consolidado (generado automáticamente)
# Formato: RUTA | MD5=<valor> | SHA256=<valor>
# Fecha: $(Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
"@

# Función hash
function Get-HashHex([string]$Path, [string]$Alg) {
    return (Get-FileHash -Algorithm $Alg -LiteralPath $Path).Hash.ToLower()
}

# Construcción de líneas
$lines = New-Object System.Collections.Generic.List[string]
$lines.Add($header)

$rootFolder = Split-Path $Out -Parent
foreach ($f in $AllFiles) {
    $md5 = Get-HashHex $f.FullName 'MD5'
    $sha = Get-HashHex $f.FullName 'SHA256'
    # Ruta relativa desde la raíz del paquete
    $rel = Resolve-Path -LiteralPath $f.FullName | ForEach-Object {
        $_.Path.Replace("$rootFolder\", "")
    }
    $lines.Add("$rel | MD5=$md5 | SHA256=$sha")
}

# Guardar
$lines | Set-Content -LiteralPath $Out -NoNewline:$false -Encoding UTF8
Write-Host "OK: 00_HASHLIST.txt actualizado. Total líneas:" $lines.Count