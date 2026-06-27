noo() {
  if [[ $# -eq 0 ]]; then
    _journal_read_section "OBJECTIFS"
  else
    _journal_add_section "OBJECTIFS" "$*"
    echo "Objectif ajouté : $*"
  fi
}
