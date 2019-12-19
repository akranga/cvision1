local skaffold = import 'skaffold.libsonnet';
local template = import 'skaffold-template.json';
local app = std.extVar("HUB_APP_NAME");

local result = template {
  metadata +: {
    name: app + "-",
  },
  build: {
    artifacts: [
      template.build.artifacts[0] + { 
        image: app,
      }
    ],
  },
  profiles+: [
    {
      name: "incluster",
      build: {
        cluster: {
          dockerConfig: {
            secretName: app + "-dockerconfig",
          },
        },
      },
    },
  ],
};

std.prune(result)
