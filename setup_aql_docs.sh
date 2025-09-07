#!/usr/bin/env bash
set -euo pipefail

# --- Ensure public images folder exists ---
mkdir -p public/images

# If you already have your AQL logo PNG, place it at:
#   public/images/aql-logo.png
# If you DON'T yet, create a tiny placeholder (replace later):
if [ ! -f public/images/aql-logo.png ]; then
python3 - <<'PY'
import base64, pathlib
png=base64.b64decode("iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8z8AABQMBg2Gm+YkAAAAASUVORK5CYII=")
pathlib.Path("public/images").mkdir(parents=True, exist_ok=True)
open("public/images/aql-logo.png","wb").write(png)
print("Created placeholder public/images/aql-logo.png (replace with your real logo).")
PY
fi

# --- If your OpenAPI is still openapi_widebot.yaml, mirror to openapi_aql.yaml ---
if [ -f openapi_widebot.yaml ] && [ ! -f openapi_aql.yaml ]; then
  cp openapi_widebot.yaml openapi_aql.yaml
fi

# --- docs.json (AQL brand, only 'User Guide' & 'AI APIs') ---
cat > docs.json <<'JSON'
{
  "name": "AQL",
  "theme": "mint",
  "colors": {
    "primary": "#FF7A00",
    "light": "#F7FAFF",
    "dark": "#1A1F36"
  },
  "logo": {
    "light": "/images/aql-logo.png",
    "dark": "/images/aql-logo.png",
    "href": "https://widebot.ai"
  },
  "icons": { "library": "lucide" },
  "favicon": "/favicon.ico",
  "navigation": {
    "tabs": [
      {
        "tab": "User Guide",
        "groups": [
          { "group": "Quick Start",       "icon": "rocket",      "pages": ["quickstart"] },
          { "group": "Accounts & Access", "icon": "user",        "pages": ["accounts"] },
          { "group": "Workspaces",        "icon": "layout-grid", "pages": ["workspaces","workspace-home","sidebar"] },
          { "group": "AI Features",       "icon": "sparkles",    "pages": ["ai-overview","ai-knowledge","ai-assistant","aql-genai"] },
          { "group": "Workspace Settings","icon": "settings",    "pages": ["settings","billing","team","api-credentials"] },
          { "group": "Help",              "icon": "life-buoy",   "pages": ["troubleshooting","release-notes"] }
        ]
      },
      {
        "tab": "AI APIs",
        "groups": [
          { "group": "API Reference", "icon": "cpu", "openapi": "openapi_aql.yaml" }
        ]
      }
    ]
  }
}
JSON

# --- Quick Start (platform demo) ---
cat > quickstart.mdx <<'MDX'
---
title: Quick Start
icon: "rocket"
---

# Quick Start (Platform Demo)

This is the shortest path to demo **AQL**: create an account, pick a workspace, start a free trial or buy a subscription, then try AI features.

## 1) Create your account
- **Sign in / Sign up** with **Facebook**, **Google**, or **Email + Phone**.
- Complete any verification steps if prompted.

## 2) Choose your workspace
- On entry, you’ll see **Workspaces** you can access.
- Select a workspace and **Start Free Trial** or **Buy Subscription**.

## 3) Tour the Workspace Home
- **Workspace name** at the top.
- **Subscription details** (plan & renewal).
- **Tokens summary** used by **AQL GenAI** and **AI Knowledge Assistant**.

## 4) Try the AI features (left sidebar)
- **AI Knowledge (RAG):** upload a few FAQs, index, then ask questions.
- **AI Knowledge Assistant:** ask a policy or product question; check citations.
- **AQL GenAI (LLM):** try a simple prompt and a streaming response.

## 5) Invite a teammate (optional)
- Go to **Workspace Settings → Team** and invite by email with the right role.

> Tip: Keep demo content simple (3–5 FAQs) and use short, clear questions.
MDX

# --- Accounts & Access ---
cat > accounts.mdx <<'MDX'
---
title: Accounts & Access
icon: "user"
---

# Accounts & Access

## Sign in / Sign up
- **Facebook** or **Google** SSO.
- **Email + Phone**: enter your email & phone, then verify if required.

## Profile basics
- Add your name, photo, and organization from your account menu.
- Update email/phone; set recovery options.

## Access control
- Your visible **Workspaces** depend on invitations and roles.
- For team access, see **Workspace Settings → Team**.
MDX

# --- Workspaces ---
cat > workspaces.mdx <<'MDX'
---
title: Workspaces
icon: "layout-grid"
---

# Workspaces

## View & select
- On login, you’ll see all **Workspaces** you can access.
- Click a workspace card to open it.

## Free trial vs. subscription
- **Free Trial**: quick evaluation with token & feature limits.
- **Subscription**: unlocks higher limits and enterprise features.
- Upgrade anytime from **Workspace Settings → Billing**.
MDX

# --- Workspace Home ---
cat > workspace-home.mdx <<'MDX'
---
title: Workspace Home
icon: "home"
---

# Workspace Home

## Overview
- **Workspace name** and status at a glance.
- **Subscription details**: plan, renewal date, usage limits.

## Tokens summary
- **AQL GenAI** tokens (LLM usage).
- **AI Knowledge Assistant** tokens (RAG usage).
- Track usage against your plan; upgrade if you approach limits.
MDX

# --- Sidebar Navigation ---
cat > sidebar.mdx <<'MDX'
---
title: Sidebar Navigation
icon: "sidebar"
---

# Sidebar Navigation

Find these sections in the left sidebar:

- **AI Knowledge (RAG)** — upload files, index, reindex, manage sources.
- **AI Knowledge Assistant** — ask questions, see citations, copy responses.
- **AQL GenAI (LLM)** — chat, streaming, and structured outputs.
- **Workspace Settings** — subscription & billing, team, API credentials.
MDX

# --- AI Overview ---
cat > ai-overview.mdx <<'MDX'
---
title: AI Overview
icon: "cpu"
---

# AI Overview

AQL brings together three core capabilities:

- **AI Knowledge (RAG)**: Ground responses on your indexed docs (policies, FAQs, handbooks).
- **AI Knowledge Assistant**: Natural-language Q&A with citations to your sources.
- **AQL GenAI (LLM)**: General chat, streaming responses, and structured outputs.

Use **RAG** for accuracy on your content; use **GenAI** for generative tasks.
MDX

# --- AI Knowledge (RAG) ---
cat > ai-knowledge.mdx <<'MDX'
---
title: AI Knowledge (RAG)
icon: "book-open"
---

# AI Knowledge (RAG)

## Add & index content
1. Go to **AI Knowledge**.
2. **Upload** PDFs/DOCX/TXT or create pages.
3. Click **Index** (or it indexes automatically).
4. Reindex after content changes.

## Best practices
- Keep documents clean and concise.
- Use clear headings and consistent terminology.
- Reindex when policies or pricing change.

## Permissions
- Sources inherit workspace access; restrict sensitive docs as needed.
MDX

# --- AI Knowledge Assistant ---
cat > ai-assistant.mdx <<'MDX'
---
title: AI Knowledge Assistant
icon: "message-square"
---

# AI Knowledge Assistant

## Ask questions
- Open **AI Knowledge Assistant** and ask natural questions.
- Answers cite the sources used (when available).

## Improve results
- Add or refine source documents in **AI Knowledge**.
- Phrase questions with product names or terms found in your docs.
MDX

# --- AQL GenAI (LLM) ---
cat > aql-genai.mdx <<'MDX'
---
title: AQL GenAI (LLM)
icon: "bot"
---

# AQL GenAI (LLM)

## Use cases
- Brainstorm, summarize, draft replies.
- Stream long outputs for a smoother UX.
- Request structured fields (e.g., JSON objects) to capture key data.

## Tips
- Keep prompts short and specific.
- Provide examples of tone/format when needed.
MDX

# --- Workspace Settings ---
cat > settings.mdx <<'MDX'
---
title: Workspace Settings
icon: "settings"
---

# Workspace Settings

## Sections
- **Subscription & Billing** — plan, invoices, payment method.
- **Team Management** — invite members, assign roles.
- **API & Credentials** — find **Bot ID** and **API Key** for integrations.
MDX

# --- Billing ---
cat > billing.mdx <<'MDX'
---
title: Subscription & Billing
icon: "credit-card"
---

# Subscription & Billing

- View current **plan**, renewal date, and invoices.
- Upgrade/downgrade plan and update payment method.
- Get alerts when token usage approaches plan limits.
MDX

# --- Team ---
cat > team.mdx <<'MDX'
---
title: Team Management
icon: "users"
---

# Team Management

- Invite members by email.
- Assign roles (e.g., Admin, Editor, Viewer).
- Remove access or change roles anytime.
MDX

# --- API credentials ---
cat > api-credentials.mdx <<'MDX'
---
title: API & Credentials (Bot ID + API Key)
icon: "key"
---

# API & Credentials

- Find **Bot ID** and **API Key** under **Workspace Settings → API**.
- Keep keys secret; rotate regularly.
- Use separate keys for QC and Production.
MDX

# --- Troubleshooting ---
cat > troubleshooting.mdx <<'MDX'
---
title: Troubleshooting & FAQs
icon: "life-buoy"
---

# Troubleshooting & FAQs

- **Login issues**: retry SSO, check verification email/SMS.
- **Trial not starting**: ensure workspace selection is complete.
- **Tokens not updating**: refresh usage or check billing status.
- **API key not found**: Workspace Settings → API; confirm permissions.
MDX

# --- Release notes (optional) ---
cat > release-notes.mdx <<'MDX'
---
title: Release Notes
icon: "megaphone"
---

# Release Notes

Track product updates and improvements here.
MDX

# If no openapi_aql.yaml exists yet, create a minimal placeholder (replace with your real spec)
if [ ! -f openapi_aql.yaml ]; then
cat > openapi_aql.yaml <<'YAML'
openapi: 3.0.3
info:
  title: AQL API (Placeholder)
  version: 0.0.1
paths: {}
YAML
fi

echo "✅ All files created. Replace public/images/aql-logo.png with your real logo, then run:  mint dev"
