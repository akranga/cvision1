local k8s = import 'libs/templates.libsonnet';
local app = std.extVar("HUB_APP_NAME");

k8s.deployment(name=app) {
  metadata+: {
    name: "application"
    // name: "$(HUB_APP_NAME)"
  },
  spec+: {
    template+: {
      spec+: {
        containers: [
          k8s.container("application", "opencv", ports=[80],)
        ],
      }
    },
  },
}
