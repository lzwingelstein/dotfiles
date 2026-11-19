# Postgres 18 resets the socket when a TLS session ends, which kills
# kubectl port-forward; the tunnel already encrypts the traffic.
alias sqlit='PGSSLMODE=disable sqlit'
