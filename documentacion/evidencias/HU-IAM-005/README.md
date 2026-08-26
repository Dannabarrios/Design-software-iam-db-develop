# Evidencia HU-IAM-005 — Gestión de usuarios y roles

## Alcance verificado

- Creación de usuarios.
- Asignación de roles mediante `rbac.user_role`.
- Desactivación lógica mediante `identity.user.is_active`.

## Prueba SQL resumida

```sql
BEGIN;
-- Se crean administrador y usuario.
-- Se asigna SYSTEM_ADMIN al usuario y luego se desactiva.
SELECT u.email,u.is_active,r.name AS role
FROM identity."user" u
JOIN rbac.user_role ur ON ur.user_id=u.id
JOIN rbac.role r ON r.id=ur.role_id
WHERE u.email='user.hu005@test';
ROLLBACK;
```

## Resultado

```text
email             | is_active | role
user.hu005@test   | f         | SYSTEM_ADMIN
ROLLBACK
```

## Conclusión

Las relaciones y restricciones permiten crear, desactivar y asignar roles a usuarios conservando integridad referencial.

