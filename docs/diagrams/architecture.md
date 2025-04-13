---
sidebar_position: 2
---

# Architecture

```mermaid
flowchart TD
  subgraph consumers["Consumers"]
    mobile["Mobile"]
    adminWebsite["Admin website"]
  end

  subgraph providers["Providers"]
    subgraph services["Services"]
      apiServer["API Server"]
      authenticationServer["Authentication Server"]
    end
    subgraph databases["Databases"]
      authDatabase["Auth Database"]
      publicDatabase["Public Database"]
    end
  end

  mobile-->authenticationServer
  mobile-->apiServer
  adminWebsite-->apiServer
  apiServer-->publicDatabase
  apiServer<-->authenticationServer
  authenticationServer-->authDatabase
```

:::info

This is Service-Oriented Architecture _(SOA)_

:::
