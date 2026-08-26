# Matriz de trazabilidad

| HU | Alcance IAM DB | Commit | Evidencia | Resultado |
|---|---|---|---|---|
| HU-IAM-000 | Estructura inicial | `8b12f0c` | Estructura del repositorio | Completada |
| HU-IAM-001 | Bloqueo y auditoría de login | `5a32eb9` | `evidencias/HU-IAM-001/README.md` | Cumple |
| HU-IAM-002 | Refresh, logout y sesiones | `64592e0` | `evidencias/HU-IAM-002/README.md` | Cumple |
| HU-IAM-003 | Contraseña temporal y reset | `5317d48` | `evidencias/HU-IAM-003/README.md` | Implementada y reversible |
| HU-IAM-004 | Catálogo RBAC | `88bb4d4` | `evidencias/HU-IAM-004/README.md` | Cumple |
| HU-IAM-005 | Usuarios y asignación de roles | `2ea6296` | `evidencias/HU-IAM-005/README.md` | Cumple |
| HU-IAM-006 | Autorización feature y scope | `5dcaa74` | `evidencias/HU-IAM-006/README.md` | Cumple |
| HU-IAM-007 | Eventos mediante outbox | `106770d` | `evidencias/HU-IAM-007/README.md` | Cumple en capa DB |

## Validación global

```text
Liquibase validate: No validation errors found.
Liquibase status: database is up to date.
```

