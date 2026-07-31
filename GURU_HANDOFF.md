# Forza Racer — Handoff

## 2026-07-31 — Engine sound + tachometer + boost pads

### Added
- **Web Audio engine sound**: sawtooth+square+bass oscillators → lowpass filter → gain. Pitch rises with speed (idle hum → redline scream). Initializes on first keypress.
- **Tachometer gauge**: canvas-drawn arc gauge bottom-right. Green sweep → red zone at 82%+. Tick marks, needle, RPM×1000 label. Synced to speed.
- **5 boost pads** placed at t=0.18, 0.38, 0.58, 0.78, 0.92 on the track. Cyan glowing strips with chevron arrows + point lights. Drive over to collect → 1.8s surge (35% above max speed). Pads go dark 8s then recharge.
- **BOOST!** HUD indicator flashes cyan when active.

### How to run
Double-click `RUN.bat` → `http://127.0.0.1:8765`
Enter to start · WASD drive · Space handbrake · Esc pause · R restart

---

## 2026-07-31 — Feature-add crash fix

### What broke
Adding asphalt/grass/sky textures, edge lines, center dashes, lamp posts, FOV kick, camera shake switched to ES modules + local `three.module.js`, but **`buildRoadMesh` referenced `half` outside its loop scope** → `ReferenceError` on load → entire module aborted (black screen / nothing works). A broad `try/catch` also hid frame errors.

### Fix
- Hoisted `const half = ROAD_WIDTH / 2` to function scope in `buildRoadMesh`
- Global `error` handler shows message on `#load-error`
- Frame catch now `console.error`s instead of swallowing silently
- Kept textures / lamps / FOV / shake polish

### How to run
Double-click `RUN.bat` (required for ES modules + local three.module.js)

---

## 2026-07-31 — Fix pass (playable circuit)

### What was broken
1. **Road was not a closed loop** (`CatmullRomCurve3(..., false)`) — open path, could not complete laps
2. **Car faced +Z** while track started toward −Z — wrong direction at spawn
3. **Lap detection** never fired correctly on open curve
4. **Road rendered white** (vertex colors all 1,1,1)
5. **ES module + importmap** flaky on `file://`; switched to classic `three.min.js`

### What changed
- Closed oval circuit with start/finish arch
- Spawn on curve tangent at t=0
- Lap arming + wrap detection (0.82→0.12) with 4s cooldown
- Dark asphalt + white edges + yellow dashes
- Wrong-way indicator, pause timer compensation, `RUN.bat` local server
- Non-module Three.js r160 CDN

### How to run
- **Easiest:** double-click `RUN.bat` (starts `http://127.0.0.1:8765`)
- Or open `index.html` in Chrome/Edge if CDN loads
- **Enter** start · **WASD** drive · **Space** handbrake · **Esc** pause · **R** restart

### Files
- `index.html` — full game
- `RUN.bat` — local server launcher
- `SPEC.md` — design spec

### Next polish (optional)
1. Engine / skid audio
2. Smoother barrier response
3. Night mode / more car detail
