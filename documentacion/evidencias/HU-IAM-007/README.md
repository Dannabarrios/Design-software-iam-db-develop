# Evidencia HU-IAM-007 — Eventos de dominio y outbox

## Alcance verificado

- Tabla transaccional `identity.outbox`.
- `event_id` único para idempotencia.
- Payload JSONB.
- `published_at` nulo para identificar eventos pendientes.
- Índice para el relay de publicación.

## Prueba SQL

```sql
BEGIN;
INSERT INTO identity.outbox(event_type,payload) VALUES
('iam.user.created',
 '{"user_id":"11111111-1111-1111-1111-111111111111","actor_type":"INSTRUCTOR"}'::jsonb),
('iam.session.started',
 '{"user_id":"11111111-1111-1111-1111-111111111111"}'::jsonb);

SELECT event_type,
       published_at IS NULL AS pendiente,
       payload->>'user_id' AS user_id
FROM identity.outbox ORDER BY created_at;
ROLLBACK;
```

## Resultado

```text
event_type          | pendiente | user_id
iam.user.created    | t         | 11111111-1111-1111-1111-111111111111
iam.session.started | t         | 11111111-1111-1111-1111-111111111111
ROLLBACK
```

## Conclusión

IAM DB persiste eventos atómicamente y permite que un relay publique los pendientes. La conexión con el broker corresponde al backend/infraestructura.

