{
  config(name):: {
    apiVersion: "skaffold/v1",
    kind: "Config",
    metadata: {
      name: name + "-",
    },
    build: {
    },
    deploy: {
      artifacts: {
        
      },
    },
    profiles: {
    },
  },
  dateTimeTagPolicy(format="20060102-150405"):: {
    tagPolicy: {
      dateTime: {
        format: format
      },
    },
  },

  manualSync(src, dest=".",strip=""):: {
    src: src,
    dest: dest,
    strip: strip,
  },
}
