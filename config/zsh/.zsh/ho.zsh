# ho: host commands proposed by sandboxed agents, read from each worktree's
# .host/proposed.jsonl by ho-core. `ho` lists them, `ho <label>` puts one in
# the prompt to read, edit and run yourself, `ho clear` marks them all as
# seen. Nothing is ever executed from here.
ho() {
  case ${1:-list} in
    list | clear) ho-core "${1:-list}" ;;
    *)
      local cmd
      cmd=$(ho-core get "$1") || return 1
      print -z -- "$cmd"
      ;;
  esac
}
