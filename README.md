# Quay Disconnected Repo for OpenShift 4.x

## Instructions

* Run the **./disconnected-sync.sh** script to update the offline registry
* Build the offline cluster with the Disconnected settings and certs 

**Example:**

```
additionalTrustBundle: |
  -----BEGIN CERTIFICATE-----
  -----END CERTIFICATE-----
imageContentSources:
- mirrors:
  - registry.ocp4.gsslab.brq.redhat.com:443/openshift/ocp4.4.3-x86_64
  source: quay.io/openshift-release-dev/ocp-release
- mirrors:
  - registry.ocp4.gsslab.brq.redhat.com:443/openshift/ocp4.4.3-x86_64
  source: quay.io/openshift-release-dev/ocp-v4.0-art-dev
```
  
* Run the Post Install Script **./postinstall.sh** 
* Create Manifest and catalogue for OLM

```
$ mkdir redhat-operators-manifests
$ cd redhat-operators-manifests
$ wget https://raw.githubusercontent.com/waynedovey/quay-disconnected/master/imageContentSourcePolicy.yaml
$ wget https://raw.githubusercontent.com/waynedovey/quay-disconnected/master/mapping.txt
$ LOCAL_REGISTRY='registry.ocp4.gsslab.brq.redhat.com:443'
$ oc adm catalog build \
    --appregistry-org redhat-operators \
    --from=registry.redhat.io/openshift4/ose-operator-registry:v4.4 \
    --filter-by-os="linux/amd64" \
    --to=${LOCAL_REGISTRY}/olm/redhat-operators:v1
$ oc patch OperatorHub cluster --type json \
  -p '[{"op": "add", "path": "/spec/disableAllDefaultSources", "value": true}]'  
$ cd ..
$ docker login -u="redhat+quay" -p="O81WSHRSJR14UAZBK54GQHJS0P1V4CLWAJV1X2C4SD7KO59CQ9N3RE12612XU1HR" quay.io
$ wget https://raw.githubusercontent.com/waynedovey/quay-disconnected/master/Image-Upload.sh
$ chmod +x Image-Upload.sh
$ ./Image-Upload.sh
$ oc apply -f ./redhat-operators-manifests
$ cat << EOF >postinstall/catalogsource.yaml
apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  name: my-operator-catalog
  namespace: openshift-marketplace
spec:
  sourceType: grpc
  image: ${LOCAL_REGISTRY}/olm/redhat-operators:v1
  displayName: My Red Hat Operator Catalog
  publisher: grpc
EOF
$ oc create -f postinstall/catalogsource.yaml
```

* Nodes Rolling reboot (10min)
* Create the Quay Operator Disconnected 

```
$ oc new-project quay-enterprise
```
* Deploy Quay Operator from UI
* Ensure the redhat-pull-secret Image Pull Secret is created 
```
$ oc get deployment quay-operator -n quay-enterprise -o yaml > quay-operator.yaml
```
* replace quay-operator.yaml image: registry.redhat.io/quay/quay-rhel8-operator@sha256:xxxx with image: registry.redhat.io/quay/quay-rhel8-operator@sha256:cdcd009fd9796522d4037d591a48be054ee3a91c563ac214e4ed8b365d2475be
```
$ oc delete Deployment quay-operator
$ oc apply -f quay-operator.yaml
$ wget https://raw.githubusercontent.com/waynedovey/quay-disconnected/master/example-quayecosystem.yaml
$ oc apply -f example-quayecosystem.yaml -n quay-enterprise
```


