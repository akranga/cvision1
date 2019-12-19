local k8s = import 'lib/k8s.libsonnet';
local app = std.extVar("HUB_APP_NAME");

k8s.deployment(name=app) {
  metadata+: {
    name: "application"
  },
  spec+: {
    template+: {
      spec+: {
        containers: [
          k8s.container("application", "pydashboard", ports=[8000],)
        ],
      }
    },
  },
}
