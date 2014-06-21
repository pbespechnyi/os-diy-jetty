#!/bin/sh

cd ${OPENSHIFT_DATA_DIR}jetty

if [ -L webapps ]; then
  rm webapps
else
  rm -rf webapps
fi

ln -s ${OPENSHIFT_REPO_DIR}deployments webapps

CMD="java -Xms384m -Xmx412m -jar start.jar -Djetty.host=$OPENSHIFT_DIY_IP -Djetty.port=$OPENSHIFT_DIY_PORT"

nohup $CMD > $OPENSHIFT_LOG_DIR/server.log 2>&1 &

echo $! > jetty.pid