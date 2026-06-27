add-appimage() {
  if [[ $# -lt 2 ]]; then
    echo "Usage: add-appimage <nom> <path/to/app.AppImage> [path/to/icon.png]"
    return 1
  fi

  local NAME=$1
  local EXEC=$(realpath $2)
  local ICON=$3
  local APP_LOWER=$(echo $NAME | tr '[:upper:]' '[:lower:]')
  local DESKTOP_FILE=~/.local/share/applications/${APP_LOWER}.desktop
  local EXTRACT_DIR=/tmp/appimage-extract-$$

  if [[ ! -f "$EXEC" ]]; then
    echo "❌ Fichier introuvable : $EXEC"
    return 1
  fi

  chmod u+x "$EXEC"

  # Extraire l'icône automatiquement si non fournie
  if [[ -z "$ICON" ]]; then
    echo "🔍 Extraction des icônes depuis l'AppImage..."

    # Extraire uniquement les icônes
    "$EXEC" --appimage-extract '*.png' --appimage-extract '*.svg' 2>/dev/null
    mv squashfs-root "$EXTRACT_DIR" 2>/dev/null

    # Copier toutes les tailles dans la hiérarchie hicolor
    local found=0
    find "$EXTRACT_DIR" -path "*/icons/hicolor/*" -name "*.png" | while read icon_path; do
      local SIZE=$(echo "$icon_path" | grep -oP '\d+x\d+')
      if [[ -n "$SIZE" ]]; then
        mkdir -p ~/.local/share/icons/hicolor/$SIZE/apps/
        cp "$icon_path" ~/.local/share/icons/hicolor/$SIZE/apps/${APP_LOWER}.png
        echo "  ✓ Icône $SIZE copiée"
        found=1
      fi
    done

    # Fallback : prendre la plus grande icône disponible si pas de hicolor
    if [[ $found -eq 0 ]]; then
      local BEST_ICON=$(find "$EXTRACT_DIR" -maxdepth 2 \( -name "*.png" -o -name "*.svg" \) \
        ! -path "*/usr/*" \
        -printf '%s %p\n' 2>/dev/null | sort -rn | head -1 | awk '{print $2}')

      if [[ -n "$BEST_ICON" ]]; then
        mkdir -p ~/.local/share/icons/hicolor/256x256/apps/
        cp "$BEST_ICON" ~/.local/share/icons/hicolor/256x256/apps/${APP_LOWER}.png
        echo "  ✓ Icône fallback copiée"
      else
        echo "  ⚠️  Aucune icône trouvée, icône générique utilisée"
      fi
    fi

    # Mettre à jour le cache d'icônes
    gtk-update-icon-cache ~/.local/share/icons/hicolor/ 2>/dev/null

    # GNOME résout automatiquement la bonne taille via le nom
    ICON="$APP_LOWER"

    rm -rf "$EXTRACT_DIR"

  fi

  # Créer le fichier .desktop
  cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=$NAME
Exec=$EXEC
Icon=$ICON
Terminal=false
Type=Application
Categories=Utility;
MimeType=x-scheme-handler/${APP_LOWER};
EOF

  update-desktop-database ~/.local/share/applications
  gtk-update-icon-cache ~/.local/share/icons/hicolor/ 2>/dev/null

  echo ""
  echo "✓ $NAME ajouté au menu GNOME"
  echo "  → Desktop : $DESKTOP_FILE"
  echo "  → Icône   : $ICON"
}

alias appimg='add-appimage'