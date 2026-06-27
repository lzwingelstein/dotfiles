_journal_add_section() {
  local file="$HOME/work/notes/journal.md"
  local section="$1"
  local content="$2"
  local today
  today=$(date +%Y-%m-%d)
  
  # Créer le jour s'il n'existe pas
  if ! grep -q "^## $today" "$file" 2>/dev/null; then
    {
      echo ""
      echo "## $today"
      echo ""
      echo "### $section"
      echo ""
      echo "- $content"
    } >> "$file"
    return 0
  fi
  
  # Ajouter dans la section existante
  local tmpfile
  tmpfile=$(mktemp)
  awk -v today="## $today" -v section="### $section" -v content="- $content" '
    $0 == today { found=1 }
    /^## [0-9]{4}-[0-9]{2}-[0-9]{2}/ && found && $0 != today { exit }
    found && $0 == section && !done { print; print content; done=1; next }
    { print }
  ' "$file" > "$tmpfile"
  
  # Si la section n'existait pas, l'ajouter après la date
  if ! grep -q "### $section" "$tmpfile" 2>/dev/null; then
    awk -v today="## $today" -v section="### $section" -v content="- $content" '
      $0 == today { print; print ""; print section; print ""; print content; next }
      { print }
    ' "$file" > "$tmpfile"
  fi
  
  mv "$tmpfile" "$file"
}

_journal_read_section() {
  local file="$HOME/work/notes/journal.md"
  local section="$1"
  local today
  today=$(date +%Y-%m-%d)
  
  if [[ -f "$file" ]]; then
    awk -v today="## $today" -v section="### $section" '
      $0 == today { found=1; next }
      /^## [0-9]{4}-[0-9]{2}-[0-9]{2}/ && found { exit }
      found && $0 == section { in_s=1; next }
      in_s && /^### / { exit }
      in_s && /^- / { print }
    ' "$file"
  fi
}
