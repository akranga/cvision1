{
  ingress(name):: {
    kind: "Ingress",
    apiVersion: "extensions/v1beta1",
    metadata: {
      name: name,
      annotations: {},
      labels: {},
    },
    spec: {
      rules: [],
    },
  },

  secret(name, type="Opaque"):: {
    kind: "Secret",
    apiVersion: "v1",
    type: "Opaque",
    metadata: {
      name: name,
      annotations: {},
      labels: {},
    },
    data: {},
  },

  ingressRule(host, serviceName, servicePort=80, path="/"):: {
    host: host,
    http: {
      paths: [
        {
          path: "/", 
          backend: {
            serviceName: serviceName, 
            servicePort: servicePort,
          }
        },
      ]
    }
  },
}


// resource(kind, name, apiVersion="v1"):: {
//     apiVersion: apiVersion,
//     kind: kind,
//     metadata: {
//       name: name,
//       labels: {},
//       annotations: {},
//     },
//     spec: {},
//   },
