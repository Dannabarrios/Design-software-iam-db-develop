# Evidencia HU-IAM-002 — Refresh, logout y sesiones

## Alcance verificado en IAM DB

- Persistencia segura mediante `session.refresh_token.token_hash`.
- Varias sesiones simultáneas por usuario.
- Vigencia mediante `expires_at` con valor predeterminado de siete días.
- Revocación mediante `is_revoked` y `revoked_at`.

## Comando de prueba

```sql
BEGIN;
INSERT INTO identity."user"
  (email,password_hash,first_name,last_name,actor_type)
VALUES ('hu002@example.test','hash','HU','Dos','USER');

INSERT INTO session.refresh_token(user_id,token_hash,device_hint)
SELECT id,'hash-device-a','Laptop'
FROM identity."user" WHERE email='hu002@example.test';

INSERT INTO session.refresh_token(user_id,token_hash,device_hint)
SELECT id,'hash-device-b','Movil'
FROM identity."user" WHERE email='hu002@example.test';

UPDATE session.refresh_token
SET is_revoked=true,revoked_at=now()
WHERE token_hash='hash-device-a';

SELECT count(*) AS sesiones,
       count(*) FILTER (WHERE is_revoked) AS revocadas,
       count(*) FILTER (WHERE NOT is_revoked) AS activas
FROM session.refresh_token
WHERE user_id=(SELECT id FROM identity."user"
               WHERE email='hu002@example.test');
ROLLBACK;
```

## Resultado

```text
sesiones | revocadas | activas
2        | 1         | 1
ROLLBACK
```

## Conclusión

IAM DB permite múltiples refresh tokens y la revocación individual requerida para logout y gestión de sesiones.

