local k8s = import 'k8s.libsonnet';
local result = k8s.service(name=app, ports=[80],) {
  spec+: {
    selector+: {
      app: std.extVar("HUB_APP_NAME"),
    },
  },
};

std.prune(result)
