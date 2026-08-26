# Evidencia HU-IAM-003 — Contraseña temporal y reset

## Implementación

Se agregó un changeset incremental, sin editar changesets ya aplicados:

- `identity.user.must_change_password`.
- `identity.user.temporary_password_expires_at`.
- `identity.user.password_changed_at`.
- Índices por usuario/IP y fecha para controlar solicitudes repetidas de reset.
- Rollback completo del changeset.

## Resultado de Liquibase

```text
Running Changeset: hu-iam-003-password-lifecycle-001
Run: 1
Previously run: 29
Total change sets: 30
Liquibase: Update has been successful.
```

## Prueba SQL

```sql
BEGIN;
INSERT INTO identity."user"
  (email,password_hash,first_name,last_name,actor_type,
   must_change_password,temporary_password_expires_at)
VALUES
  ('hu003@example.test','hash-temporal','HU','Tres','USER',
   true,now()+interval '72 hours');

INSERT INTO session.password_reset_request(user_id,token_hash)
SELECT id,'reset-hash-hu003'
FROM identity."user"
WHERE email='hu003@example.test';

SELECT u.must_change_password,
       u.temporary_password_expires_at>now() AS temporal_vigente,
       r.is_used,
       r.expires_at>now() AS reset_vigente
FROM identity."user" u
JOIN session.password_reset_request r ON r.user_id=u.id
WHERE u.email='hu003@example.test';
ROLLBACK;
```

## Resultado

```text
must_change_password | temporal_vigente | is_used | reset_vigente
t                    | t                | f       | t
ROLLBACK
```

## Prueba de rollback

```text
Rolling Back Changeset: hu-iam-003-password-lifecycle-001
Liquibase command 'rollback-count' was executed successfully.
```

Después del rollback se ejecutó nuevamente `update` y el changeset fue aplicado correctamente.

