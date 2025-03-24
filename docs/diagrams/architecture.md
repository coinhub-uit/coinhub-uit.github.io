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
      authenticationDatabase["Authentication Database"]
      resourcesDatabase["Resources Database"]
    end
  end

  mobile-->authenticationServer
  mobile-->apiServer
  adminWebsite-->apiServer
  authenticationServer-->authenticationDatabase
  apiServer-->authenticationDatabase
  apiServer-->resourcesDatabase
```

:::info

This is Service-Oriented Architecture _(SOA)_

:::
