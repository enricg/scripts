#!/bin/bash
# ---------------------------------------------
# Nom del fitxer: descarrega_pdfs_ctan.sh
# Descripció: descarrega els pdf's nous de la pàgina de CTAN
# Autor: Enric Giner
# Data: 04-06-2025
# Versió: 1.0.0
# Llicència: MIT
# Etiquetes: CTAN, LaTex, manuals,
# ---------------------------------------------

# Configuració
MIRROR="rsync://ctan.tetaneutral.net/ctan/"
DEST_TMP="~/Baixades/ctan-all-pdfs/"
DEST_PDFS="~/Documents/LaTeX/CTAN/"

notify-send "==> Sincronitzant PDFs des de CTAN..."
rsync -av --include='*.pdf' --include='*/' --exclude='*' "$MIRROR" "$DEST_TMP"

notify-send "==> Creant carpeta de destinació per als PDFs si no existeix..."
mkdir -p $DEST_PDFS

notify-send "==> Movent tots els PDFs a $DEST_PDFS..."
find $DEST_TMP -type f -name '*.pdf' -exec mv -n {} $DEST_PDFS \;

# notify-send "==> Eliminant carpetes buides dins $DEST_TMP..."
# find $DEST_TMP -type d -empty -delete

notify-send "==> Eliminant carpeta temporal $DEST_TMP..."
rm -rd ~/Baixades/ctan-all-pdfs

notify-send "==> FET. Els PDFs nous són a $DEST_PDFS"
