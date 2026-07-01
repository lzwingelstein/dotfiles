# ── Proxy Toggle ─────────────────────────────────────
PROXY_HOST="proxy.exaion.in"
PROXY_PORT="3128"
PROXY_URL="http://${PROXY_HOST}:${PROXY_PORT}"

_PROXY_STATE_FILE="${HOME}/.proxy_state"

proxy_on() {
  echo "on" > "${_PROXY_STATE_FILE}"
  export http_proxy="${PROXY_URL}"
  export https_proxy="${PROXY_URL}"
  export HTTP_PROXY="${PROXY_URL}"
  export HTTPS_PROXY="${PROXY_URL}"
  export no_proxy="localhost,10.0.0.0/8,192.168.0.0/16,91.239.56.0/24,163.114.159.0/24,95.175.153.0/24,162.251.207.0/24,172.16.0.0/22,exaion.io,exaion.tech,exaion.cloud,exacloud.exaion.fr,exaion.in"
  export NO_PROXY="${no_proxy}"
  echo "🟢 Proxy activé → ${PROXY_URL}"
}

proxy_off() {
  echo "off" > "${_PROXY_STATE_FILE}"
  unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY no_proxy NO_PROXY
  echo "🔴 Proxy désactivé"
}

proxy_sync() {
  if [[ -f "${_PROXY_STATE_FILE}" ]]; then
    local state
    state=$(cat "${_PROXY_STATE_FILE}")
    if [[ "${state}" == "on" && -z "${http_proxy}" ]]; then
      export http_proxy="${PROXY_URL}"
      export https_proxy="${PROXY_URL}"
      export HTTP_PROXY="${PROXY_URL}"
      export HTTPS_PROXY="${PROXY_URL}"
      export no_proxy="localhost,10.0.0.0/8,192.168.0.0/16,91.239.56.0/24,163.114.159.0/24,95.175.153.0/24,162.251.207.0/24,172.16.0.0/22,exaion.io,exaion.tech,exaion.cloud,exacloud.exaion.fr,exaion.in"
      export NO_PROXY="${no_proxy}"
    elif [[ "${state}" == "off" && -n "${http_proxy}" ]]; then
      unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY no_proxy NO_PROXY
    fi
  fi
}

proxy_toggle() {
  if [[ -z "${http_proxy}" ]]; then
    proxy_on
  else
    proxy_off
  fi
}

proxy_status() {
  if [[ -z "${http_proxy}" ]]; then
    echo "🔴 Proxy OFF"
  else
    echo "🟢 Proxy ON → ${http_proxy}"
  fi
}

proxy_on
