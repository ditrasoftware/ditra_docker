docker compose --project-name ditra-one exec backend \
  bench new-site ditra-one.localhost --no-mariadb-socket --mariadb-root-password changeit --install-app ditra --admin-password changeit