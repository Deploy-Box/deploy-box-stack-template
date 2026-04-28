FROM node:20-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app .

EXPOSE 3000
CMD ["npm", "start"]

# ──────────────────────────────────────────────────────────────────────
# This is a placeholder Dockerfile. Replace with your actual build.
#
# Common patterns:
#
# Python/Django:
#   FROM python:3.12-slim
#   COPY requirements.txt .
#   RUN pip install -r requirements.txt
#   COPY . .
#   CMD ["gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:8000"]
#
# Static-only (no Docker needed):
#   Delete this file and remove the 'build' job from CD.yml
# ──────────────────────────────────────────────────────────────────────
