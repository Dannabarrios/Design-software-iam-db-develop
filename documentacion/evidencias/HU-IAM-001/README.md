# Evidencia HU-IAM-001 — Login, bloqueo y auditoría

## Alcance verificado en IAM DB

- Contador `identity.user.failed_attempts`.
- Bloqueo temporal `identity.user.locked_until`.
- Auditoría `identity_audit.audit_login`.
- Resultado `ACCOUNT_LOCKED` permitido por restricción.

## Ejecución limpia

```text
Run: 29
Previously run: 0
Filtered out: 0
Total change sets: 29
Liquibase: Update has been successful. Rows affected: 257
```

## Comando de prueba

```sql
BEGIN;
INSERT INTO identity."user"
  (email,password_hash,first_name,last_name,actor_type)
VALUES ('hu001@example.test','hash','HU','Uno','USER');

UPDATE identity."user"
SET failed_attempts=5,
    locked_until=now()+interval '15 minutes'
WHERE email='hu001@example.test';

INSERT INTO identity_audit.audit_login(user_id,email_attempted,outcome)
SELECT id,email,'ACCOUNT_LOCKED'
FROM identity."user"
WHERE email='hu001@example.test';

SELECT u.email,u.failed_attempts,
       u.locked_until>now() AS bloqueado,a.outcome
FROM identity."user" u
JOIN identity_audit.audit_login a ON a.user_id=u.id
WHERE u.email='hu001@example.test';
ROLLBACK;
```

## Resultado

```text
email              | failed_attempts | bloqueado | outcome
hu001@example.test | 5               | t         | ACCOUNT_LOCKED
ROLLBACK
```

## Conclusión

IAM DB soporta intentos fallidos, bloqueo y auditoría. La validación de credenciales y emisión de tokens corresponde al backend.

