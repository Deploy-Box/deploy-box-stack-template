# {{STACK_NAME}}

> Created from the [Deploy Box Stack Template](https://github.com/Deploy-Box/deploy-box-stack-template).

## Quick Start

1. Click **"Use this template"** on GitHub to create your stack repo
2. Search and replace the placeholder values (see below)
3. Add your application code to `src/`
4. Push to `dev` — the CD pipeline handles the rest

## Placeholder Reference

Find and replace these across the repo:

| Placeholder | Replace with | Example |
|---|---|---|
| `{{STACK_NAME}}` | Display name | `Social Stack` |
| `{{STACK_TYPE}}` | Uppercase type key | `SOCIAL` |
| `{{STACK_DESCRIPTION}}` | One-line description | `Full-stack social media platform...` |
| `{{STACK_FEATURES}}` | JSON array of features | `["React", "Express.js", "PostgreSQL"]` |
| `{{STACK_INFRASTRUCTURE}}` | JSON array of resource types | See [Resource Types](#resource-types) |
| `{{SOURCE_CODE_LOCATION}}` | Blob zip name | `social_stack.zip` |
| `{{PRICE_ID}}` | Stripe price ID | `price_social_basic` |
| `{{DOCKER_IMAGE_NAME}}` | ACR image name (if containerized) | `social-backend` |

## Resource Types

Available resource types for `stack_infrastructure`:

```json
[
  {"resource_type": "AZURERM_RESOURCE_GROUP"},
  {"resource_type": "AZURERM_LOG_ANALYTICS_WORKSPACE"},
  {"resource_type": "AZURERM_CONTAINER_APP_ENVIRONMENT"},
  {"resource_type": "AZURERM_STORAGE_ACCOUNT"},
  {"resource_type": "AZURERM_STORAGE_CONTAINER"},
  {"resource_type": "AZURERM_CONTAINER_APP"},
  {"resource_type": "AZURERM_STORAGE_ACCOUNT_STATIC_WEBSITE"},
  {"resource_type": "DEPLOYBOXRM_WORKOS_INTEGRATION"},
  {"resource_type": "DEPLOYBOXRM_POSTGRES_DATABASE"},
  {"resource_type": "DEPLOYBOXRM_EDGE"}
]
```

Pick only the resources your stack needs. Order matters — dependencies should come first (e.g., Resource Group before Container App).

## CD Pipeline

The included `CD.yml` workflow:

1. **resolve-env** — maps branch to environment (`dev`/`test`/`prod`)
2. **build** — builds Docker image(s) and pushes to ACR (remove if static-only)
3. **upload** — zips source and uploads to Azure Blob Storage
4. **register-stack** — calls the [register-stack](https://github.com/Deploy-Box/deploy-box-platform) reusable workflow to upsert the stack in the Deploy Box database

### Required Setup

**GitHub Environment Variables** (per environment: `dev`, `test`, `prod`):
- `AZURE_CLIENT_ID` — OIDC service principal
- `AZURE_TENANT_ID` — Azure AD tenant
- `AZURE_SUBSCRIPTION_ID` — Azure subscription
- `ACR_NAME` — Azure Container Registry name
- `AZURE_STORAGE_ACCOUNT` — Storage account for source zips
- `AZURE_STORAGE_CONTAINER` — Blob container name

**Organization Secrets** (set once at org level):
- `DEV_DEPLOYBOX_DB_HOST`, `TEST_DEPLOYBOX_DB_HOST`, `PROD_DEPLOYBOX_DB_HOST`
- `DEV_DEPLOYBOX_DB_PORT`, `TEST_DEPLOYBOX_DB_PORT`, `PROD_DEPLOYBOX_DB_PORT`
- `DEV_DEPLOYBOX_DB_NAME`, `TEST_DEPLOYBOX_DB_NAME`, `PROD_DEPLOYBOX_DB_NAME`
- `DEV_DEPLOYBOX_DB_USER`, `TEST_DEPLOYBOX_DB_USER`, `PROD_DEPLOYBOX_DB_USER`
- `DEV_DEPLOYBOX_DB_PASSWORD`, `TEST_DEPLOYBOX_DB_PASSWORD`, `PROD_DEPLOYBOX_DB_PASSWORD`

## Project Structure

```
├── .github/workflows/CD.yml   # CI/CD pipeline
├── Dockerfile                  # Container build (remove for static-only stacks)
├── src/                        # Your application code
└── README.md
```

## License

Proprietary — Deploy Box
