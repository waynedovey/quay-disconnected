
#!/bin/bash
# Quay Operator

skopeo copy docker://registry.redhat.io/quay/quay-rhel8-operator@sha256:855743b29f8e050fb1f124b47f622b9e179998df60ad9465b51553f1c729197d docker://registry.ocp4.gsslab.brq.redhat.com:443/quay/quay-rhel8-operator

# Postgresql Image

skopeo copy docker://registry.redhat.io/rhel8/postgresql-96@sha256:e2f16336f000f5c89d5d431a067a6c43c601789e801daee69a12c0871640969f docker://registry.ocp4.gsslab.brq.redhat.com:443/rhel8/postgresql-96

# Redis-5 Image

skopeo copy docker://registry.redhat.io/rhel8/redis-5@sha256:ee07b7d2113fd819b183f01c134dff13c8cfe965669f330a6e384791f8ac3d4e docker://registry.ocp4.gsslab.brq.redhat.com:443/rhel8/redis-5

# Quay Image

skopeo copy docker://quay.io/redhat/quay@sha256:2218711b5d34b1f68ebeeb71fca76546acb9625ef8f1ad493e8dd6a8e89b9838 docker://registry.ocp4.gsslab.brq.redhat.com:443/redhat/quay
