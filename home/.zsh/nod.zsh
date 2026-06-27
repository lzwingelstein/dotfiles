nod() {
  if [[ $# -eq 0 ]]; then
    _journal_read_section "DISTRACTIONS"
  else
    local date_str
    date_str=$(date +"%H:%M")
    _journal_add_section "DISTRACTIONS" "[$date_str] $*"
    echo "Distraction ajoutée : [$date_str] $*"
  fi
}
