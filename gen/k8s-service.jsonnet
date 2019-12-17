local k8s = import 'lib/k8s.libsonnet';
local app = std.extVar("HUB_APP_NAME");

k8s.service(name=app, ports=[80],) {
  spec+: {
    selector+: {
      app: app
    },
  },
}
