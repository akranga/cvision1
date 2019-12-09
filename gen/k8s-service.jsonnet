local k8s = import 'libs/templates.libsonnet';
local app = std.extVar("HUB_APP_NAME");

k8s.service(name=app, ports=[80],) {
  spec+: {
    selector+: {
      app: app
    },
  },
}
