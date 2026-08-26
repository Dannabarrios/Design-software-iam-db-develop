# Flujo simplificado en main

Por restricción de tiempo, el trabajo se realiza directamente en `main`.

Reglas:

1. Una HU por commit.
2. Cada commit incluye la implementación nueva cuando sea necesaria.
3. Cada HU tiene un Markdown en `documentacion/evidencias/HU-IAM-NNN/README.md`.
4. La evidencia contiene comandos, resultados y explicación del alcance de IAM DB.
5. No se modifican changesets que ya fueron aplicados; los cambios de esquema se agregan mediante changesets incrementales.
6. Antes de cerrar el trabajo se ejecutan `liquibase validate` y `liquibase status --verbose`.

