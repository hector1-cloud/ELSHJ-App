#!/usr/bin/env bash
# Script para agregar los hashes del ZIP final al 00_HASHLIST.txt
# Uso:
#   1) Ejecuta primero 21_00_SCRIPT_HASH.sh para actualizar archivos internos.
#   2) Crea el ZIP: zip -r ELSHJ_Master_v1.0.zip ELSHJ_Master/
#   3) Ejecuta: ./17_Scripts/24_00_SCRIPT_HASH_ZIP.sh
#   4) Revisa 00_HASHLIST.txt: encontrarás línea adicional con los hashes del ZIP.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && cd .. && pwd)"
HASHLIST="$ROOT_DIR/00_HASHLIST.txt"
ZIPNAME="ELSHJ_Master_v1.0.zip"

# Detectamos comandos
has_cmd() { command -v "$1" >/dev/null 2>&1; }

# Seleccionar sha256sum/shasum
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

# Seleccionar md5sum/md5
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

# Verificar ZIP existe
ZIP_PATH="$ROOT_DIR/$ZIPNAME"
if [[ ! -f "$ZIP_PATH" ]]; then
  echo "Error: no se encontró el ZIP ($ZIP_PATH). Crea el ZIP antes de ejecutar este script." >&2
  exit 1
fi

# Calcular hashes del ZIP
MD5_ZIP="$($MD5_CMD "$ZIP_PATH" | awk "$MD5_FMT")"
SHA_ZIP="$($SHA256_CMD "$ZIP_PATH" | awk "$SHA256_FMT")"

# Generar línea y anexar
LINE="$ZIPNAME | MD5=$MD5_ZIP | SHA256=$SHA_ZIP"
echo "" >> "$HASHLIST"
echo "$LINE" >> "$HASHLIST"

echo "OK: Hashes del ZIP agregado a 00_HASHLIST.txt"