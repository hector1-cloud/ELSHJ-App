Nombre: Scripts de checksums automáticos
Ubicación: 17_Scripts/
Archivos:
- 21_00_SCRIPT_HASH.sh (bash)
- 22_00_SCRIPT_HASH.ps1 (PowerShell)

Qué hacen:
- Recorren todas las carpetas del paquete y generan 00_HASHLIST.txt con MD5 y SHA-256 por archivo.
- Excluyen el propio 00_HASHLIST.txt y los scripts para evitar loops.

Requisitos:
- macOS/Linux/Android (Termux): shasum o sha256sum; md5 o md5sum
- Windows: PowerShell 5+ (Get-FileHash disponible por defecto)

Uso rápido:
- Bash: chmod +x 17_Scripts/21_00_SCRIPT_HASH.sh && ./17_Scripts/21_00_SCRIPT_HASH.sh
- PowerShell: .\17_Scripts\22_00_SCRIPT_HASH.ps1

Consejo:
- Ejecuta el script después de cada exportación (PDF/EPUB/ZIP) y antes de compartir.