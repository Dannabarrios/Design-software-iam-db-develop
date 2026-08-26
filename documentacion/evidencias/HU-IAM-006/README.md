# Evidencia HU-IAM-006 — Autorización feature y scope

## Alcance verificado

- Scope por centro en `rbac.user_role.training_center_id`.
- Features concedidas por rol mediante `rbac.role_feature`.
- Excepciones individuales mediante `rbac.user_scope_override`.

## Prueba SQL resumida

```sql
BEGIN;
-- Se asigna CENTER_DIRECTOR limitado a un centro.
-- Se concede override GLOBAL para IDENTITY_USER_VIEW.
SELECT r.name,ur.training_center_id,
       uso.scope_type AS override_scope,
       uso.is_allowed,f.code AS feature
FROM rbac.user_role ur
JOIN rbac.role r ON r.id=ur.role_id
JOIN rbac.user_scope_override uso ON uso.user_id=ur.user_id
JOIN rbac_catalog.feature f ON f.id=uso.feature_id;
ROLLBACK;
```

## Resultado

```text
name            | training_center_id                   | override_scope | is_allowed | feature
CENTER_DIRECTOR | 11111111-1111-1111-1111-111111111111 | GLOBAL         | t          | IDENTITY_USER_VIEW
ROLLBACK
```

## Conclusión

La base permite combinar permisos por rol, centro y override individual para la evaluación feature+scope.

