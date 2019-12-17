local k8s = import 'lib/k8s.libsonnet';
local app = std.extVar("HUB_APP_NAME");
local ingressHost = std.extVar("HUB_INGRESS_HOST");

k8s.ingress(name=app) {
  spec: {
    rules: [
      k8s.ingressRule(host=ingressHost, serviceName=app),
    ]
  },
}
