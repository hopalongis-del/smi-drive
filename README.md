# SMI Drive

Browser racing game — closed circuit, boost, drift, chaos bonuses, eject + parachute, and a **top-10 local leaderboard** (initials + finish time).

## Play locally

```bat
RUN.bat
```

Or:

```bash
python -m http.server 8765
```

Open http://127.0.0.1:8765/index.html

## Controls

| Input | Action |
|-------|--------|
| W / ↑ | Accelerate |
| S / ↓ | Brake / reverse |
| A D / ← → | Steer |
| Space | Drift |
| Shift | Boost |
| P | Chaos bonus |
| E | Eject |
| R | Restart |
| Esc | Pause |

**Phone:** on-screen buttons (landscape recommended). After a race, enter initials if you crack the top 10, then **R** / Restart.

## Leaderboard

Top 10 fastest **total race times** are stored in the browser (`localStorage` key `smi_drive_leaderboard_v1`). Scores stay on that device/browser.

## Deploy (Render)

Static site — publish directory `.`, build command empty or `true`. See `render.yaml`.

## Stack

- Three.js (local `three.module.js`)
- Single-page `index.html`
