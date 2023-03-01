mkdir ./gitops

echo "ROUTER=ditra-one-example" > ./gitops/ditra-one-example.env
echo "SITES=\`ditra-one.localhost\`" >> ./gitops/ditra-one-example.env
echo "BASE_SITE=ditra-one.localhost" >> ./gitops/ditra-one-example.env
echo "BENCH_NETWORK=ditra-one" >> ./gitops/ditra-one-example.env

docker compose --project-name ditra-one-example \
  --env-file ./gitops/ditra-one-example.env \
  -f overrides/compose.custom-domain.yaml config > ./gitops/ditra-one-example.yaml
  # -f overrides/compose.custom-domain-ssl.yaml config > ~/gitops/custom-one-example.yaml
