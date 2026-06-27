helm-diff() {
  local local_file="${1:?Usage: helm-diff <local-file> <release-name> <namespace>}"
  local release="${2:?Usage: helm-diff <local-file> <release-name> <namespace>}"
  local namespace="${3:?Usage: helm-diff <local-file> <release-name> <namespace>}"
  
  diff -u <(yq '.spec.valuesContent' "$local_file") <(
    kubectl get helmcharts.helm.cattle.io -n "$namespace" "$release" -o yaml | yq 'del(.spec.failurePolicy) | .spec.valuesContent'
  )
}