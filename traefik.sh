mkdir ./gitops

echo 'TRAEFIK_DOMAIN=traefik.localhost' > ./gitops/traefik.env
echo 'EMAIL=admin@localhost' >> ./gitops/traefik.env
echo 'HASHED_PASSWORD='$(openssl passwd -apr1 changeit | sed 's/\$/\\\$/g') >> ./gitops/traefik.env

docker compose --project-name traefik \
  --env-file ./gitops/traefik.env \
  -f overrides/compose.traefik.yaml up -d
  # -f overrides/compose.traefik-ssl.yaml up -d
