daily() {
  if [[ $# -eq 0 ]]; then
    _journal_read_section "DAILY"
  else
    _journal_add_section "DAILY" "$*"
    echo "Note daily ajoutée : $*"
  fi
}
