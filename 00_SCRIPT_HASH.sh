#!/usr/bin/env bash
# El Lenguaje Secreto de Héctor Jazziel — Script de checksums (bash)
# Uso:
#   1) Coloca este archivo en la raíz del paquete: ELSHJ_Master/
#   2) Dale permisos: chmod +x 21_00_SCRIPT_HASH.sh
#   3) Ejecuta: ./21_00_SCRIPT_HASH.sh
# Requisitos: bash + (shasum o sha256sum) + (md5 o md5sum)

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUT_FILE="$ROOT_DIR/00_HASHLIST.txt"

# Detectores de comandos hash
has_cmd() { command -v "$1" >/dev/null 2>&1; }

# Preferencias de herramientas
if has_cmd sha256sum; then
  SHA256_CMD='sha256sum'
  SHA256_FMT='{print $1}'
elif has_cmd shasum; then
  SHA256_CMD='shasum -a 256'
  SHA256_FMT='{print $1}'
else
  echo "Error: no se encontró sha256sum ni shasum." >&2
  exit 1
fi

if has_cmd md5sum; then
  MD5_CMD='md5sum'
  MD5_FMT='{print $1}'
elif has_cmd md5; then
  MD5_CMD='md5'
  MD5_FMT='{print $NF}'
else
  echo "Error: no se encontró md5sum ni md5." >&2
  exit 1
fi

# Encabezado del HASHLIST
HEADER="## HASHLIST consolidado (generado automáticamente)
# Formato: RUTA | MD5=<valor> | SHA256=<valor>
# Fecha: $(date -u +'%Y-%m-%dT%H:%M:%SZ')
"

# Recolecta archivos (excluye el propio HASHLIST y scripts)
mapfile -t FILES < <(cd "$ROOT_DIR" && \
  find . -type f \
    ! -path './00_HASHLIST.txt' \
    ! -path './17_Scripts/21_00_SCRIPT_HASH.sh' \
    ! -path './17_Scripts/22_00_SCRIPT_HASH.ps1' \
    -print | sort)

TMP_FILE="$(mktemp)"
echo "$HEADER" > "$TMP_FILE"

for f in "${FILES[@]}"; do
  # Limpia prefijo "./"
  REL="${f#./}"
  # Calcula hashes
  MD5_VAL="$(
    cd "$ROOT_DIR" && eval "$MD5_CMD \"$REL\"" | awk "$MD5_FMT"
  )"
  SHA_VAL="$(
    cd "$ROOT_DIR" && eval "$SHA256_CMD \"$REL\"" | awk "$SHA256_FMT"
  )"
  printf "%s | MD5=%s | SHA256=%s\n" "$REL" "$MD5_VAL" "$SHA_VAL" >> "$TMP_FILE"
done

mv "$TMP_FILE" "$OUT_FILE"

echo "OK: 00_HASHLIST.txt actualizado con $(wc -l < "$OUT_FILE") líneas."