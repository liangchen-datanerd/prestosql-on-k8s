#!/bin/bash

set -e

REPONAME=chenlianguu
PRESTOVER=332

docker build --build-arg PRESTO_VER=$PRESTOVER -t prestosql .

# Tag and push to the public docker repository.
docker tag prestosql $REPONAME/prestosql
docker push $REPONAME/prestosql

# Update configMap in Kubernetes
kubectl create configmap presto-cfg --dry-run --from-file=config.properties.coordinator --from-file=config.properties.worker --from-file=node.properties.template --from-file=hive.properties.template -o yaml | kubectl apply -f -
