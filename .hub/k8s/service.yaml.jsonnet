local k8s = import 'k8s.libsonnet';
local app = std.extVar("HUB_APP_NAME");

local result = k8s.service(name=app, ports=[80],) {
  spec+: {
    selector+: {
      app: "application"
    },
  },
};

std.prune(result)
