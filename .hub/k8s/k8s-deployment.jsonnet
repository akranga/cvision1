local k8s = import 'k8s.libsonnet';
local template = import 'deployment-template.json';
local app = std.extVar("HUB_APP_NAME");

local result = template + {
  metadata+: {
    name: app
  },
  spec+: {
    template+: {
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
