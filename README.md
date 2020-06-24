# Quay Disconnected Repo for OpenShift 4.x

## Instructions

* Run the ./disconnected-sync.sh script to update the offline registry
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
  
*   

### imageContentSourcePolicy.yaml update 

### New Image source

### mapping.txt

