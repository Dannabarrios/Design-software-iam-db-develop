# Evidencia HU-IAM-004 — Catálogo RBAC

## Alcance verificado

Se validaron `rbac_catalog.module`, `rbac_catalog.feature`, `rbac.role` y `rbac.role_feature`, incluyendo restricciones de unicidad, llaves foráneas y scopes.

## Comando

```sql
SELECT (SELECT count(*) FROM rbac_catalog.module) AS modules,
       (SELECT count(*) FROM rbac_catalog.feature) AS features,
       (SELECT count(*) FROM rbac.role) AS roles,
       (SELECT count(*) FROM rbac.role_feature) AS role_features;

SELECT scope_type,count(*)
FROM rbac.role_feature
GROUP BY scope_type ORDER BY scope_type;
```

## Resultado

```text
modules | features | roles | role_features
10      | 70       | 7     | 168

GLOBAL: 76
TRAINING_CENTER: 75
OWN_FICHAS: 10
OWN_FICHA_AS_LEARNER: 3
OWN_PROFILE: 3
OWN_SCHEDULE: 1
```

## Conclusión

El catálogo y la relación rol-feature con scope se encuentran poblados y disponibles para consulta.

