---
sidebar_position: 2
---

# Architecture

```mermaid
flowchart TD
  subgraph consumers["Consumers"]
    mobile["Mobile App"]@{ shape:circ }
    admin["Admin Website"]@{ shape:circ }
  end

  subgraph providers["Providers"]
    subgraph services["Services"]
      apiServer["API Server"]
      authenticationServer["Authentication Server"]
    end
    subgraph databases["Databases"]
      authDatabase["Auth Database"]@{ shape: db }
      publicDatabase["Public Database"]@{ shape: db }
    end
  end

  mobile-->authenticationServer
  mobile-->apiServer
  admin-->apiServer
  apiServer<-->authenticationServer
  apiServer-->publicDatabase
  authenticationServer-->authDatabase
```

:::info

This is Service-Oriented Architecture _(SOA)_

:::
