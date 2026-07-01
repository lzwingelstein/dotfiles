note() {
  if [[ $# -eq 0 ]]; then
    _journal_read_section "NOTES"
  else
    _journal_add_section "NOTES" "$*"
    echo "Note ajoutée : $*"
  fi
}
