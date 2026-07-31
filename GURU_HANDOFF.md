# SMI Drive — handoff

## Live

| | |
|--|--|
| **GitHub** | https://github.com/hopalongis-del/smi-drive |
| **Render** | https://smi-drive.onrender.com |
| **Dashboard** | https://dashboard.render.com/static/srv-d9mgr4favr4c73ec3iog |
| **Branch** | `main` (auto-deploy on push) |

## What it is

Browser 3D racer (Three.js, single `index.html`): circuit, boost/drift/chaos/eject, mobile touch controls, **top-10 leaderboard** (3-letter initials + total race time in `localStorage`).

## Local

```bat
RUN.bat
```

## Deploy notes

- Static site; build `true`, publish `.`
- `render.yaml` present for blueprints
- Scores are **per browser** (not shared server-side)
