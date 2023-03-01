mkdir ./gitops

echo "DB_PASSWORD=changeit" > ./gitops/mariadb.env
docker compose --project-name mariadb --env-file ./gitops/mariadb.env -f overrides/compose.mariadb-shared.yaml up -d

cp example.env ./gitops/ditra-one.env
sed -i 's/DB_PASSWORD=123/DB_PASSWORD=changeit/g' ./gitops/ditra-one.env
sed -i 's/DB_HOST=/DB_HOST=mariadb-database/g' ./gitops/ditra-one.env
sed -i 's/DB_PORT=/DB_PORT=3306/g' ./gitops/ditra-one.env
echo 'ROUTER=ditra-one' >> ./gitops/ditra-one.env
# echo "SITES=\`one.example.com\`,\`two.example.com\`" >> ~/gitops/erpnext-one.env
echo "SITES=\`ditra-one.localhost\`,\`ditra-two.localhost\`" >> ./gitops/ditra-one.env
echo "BENCH_NETWORK=ditra-one" >> ./gitops/ditra-one.env

docker compose --project-name ditra-one \
  --env-file ./gitops/ditra-one.env \
  -f compose.yaml \
  -f overrides/compose.redis.yaml \
  -f overrides/compose.multi-bench.yaml config > ./gitops/ditra-one.yaml
  # -f overrides/compose.multi-bench-ssl.yaml config > ~/gitops/erpnext-one.yaml

docker compose --project-name ditra-one -f ./gitops/ditra-one.yaml up -d
