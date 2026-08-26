# Ejecución local

## Requisitos usados

- Docker 29.4.1.
- PostgreSQL 16 Alpine.
- Liquibase 4.33.

## Red y base aislada

```powershell
docker network create iam-evidence-net

docker run -d `
  --name iam-db-evidence-20260826 `
  --network iam-evidence-net `
  -e POSTGRES_DB=iam `
  -e POSTGRES_USER=iam_admin `
  -e POSTGRES_PASSWORD=iam_local_evidence `
  -p 55439:5432 `
  postgres:16-alpine
```

La contraseña anterior es exclusivamente local y demostrativa; no se almacena en archivos del repositorio.

## Aplicar migraciones

Ejecutar desde la raíz del repositorio y reemplazar `<RUTA_MICRO>` por la ruta absoluta de `design-software-iam-db-develop`:

```powershell
docker run --rm --network iam-evidence-net `
  -v "<RUTA_MICRO>:/liquibase/iam" `
  liquibase/liquibase:4.33 `
  --url=jdbc:postgresql://iam-db-evidence-20260826:5432/iam `
  --username=iam_admin `
  --password=iam_local_evidence `
  --changelog-file=iam/changelog/changelog-master.yaml `
  update
```

## Validación final

```text
No validation errors found.
Liquibase command 'validate' was executed successfully.

iam_admin@jdbc:postgresql://iam-db-evidence-20260826:5432/iam is up to date
Liquibase command 'status' was executed successfully.
```

## Rollback probado

```powershell
# Los argumentos de conexión son los mismos del comando update.
liquibase rollback-count 1
```

HU-IAM-003 fue revertida y aplicada nuevamente con éxito.

