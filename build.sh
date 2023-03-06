export APPS_JSON_BASE64=$(base64 -w 0 ./apps.json)

echo $APPS_JSON_BASE64 | base64 -d

docker build --no-cache --progress plain \
  --build-arg=FRAPPE_PATH=https://github.com/frappe/frappe \
  --build-arg=FRAPPE_BRANCH=version-14 \
  --build-arg=PYTHON_VERSION=3.10.5 \
  --build-arg=NODE_VERSION=16.18.0 \
  --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64 \
  --tag=ghcr.io/ditrasoftware/ditra/ditra:1.0.0 \
  --file=images/custom/Containerfile .