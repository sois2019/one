#!/bin/bash
HOSTNAME=${1:-localhost}
openssl req -newkey rsa:2048 -nodes -keyout $HOSTNAME.key -x509 -days 3650 -out $HOSTNAME.crt
echo "apiVersion: v1
kind: Secret
metadata:
  name: $HOSTNAME.tls
  namespace: default
type: kubernetes.io/tls
data:
  tls.crt: `cat $HOSTNAME.crt | base64 -w0`
  tls.key: `cat $HOSTNAME.key | base64 -w0`
" > $HOSTNAME.yaml
