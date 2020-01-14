local k8s = import 'k8s.libsonnet';
local template = import 'deployment.json';
local app = {
  app: std.extVar("HUB_APP_NAME"), 
};

local result = template + {
  metadata+: {
    name: app
  },
  spec+: {
    selector+: {
      matchLabels+: {app}, 
    },
    template+: {
      metadata+: {
        labels+: {app},
      },
      spec+: {
        containers: [
          template.spec.template.spec.containers[0] + {
            image: app
          }
        ],
      },
    },
  },
};

std.prune(result)
