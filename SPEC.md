# Forza-Style Racing Game — SPEC

## 1. Project Overview
**Type:** 3D Racing Game (time trial / circuit racing)
**Engine:** Three.js (WebGL) — single HTML file, no build step
**Target:** Browser, runs from local file or simple HTTP server

---

## 2. Visual & Rendering Specification

### Scene Setup
- **Camera:** Third-person chase cam, fixed distance behind car (~8 units), slight height offset (~3 units), smoothly lerps to follow car rotation
- **FOV:** 70°
- **Lighting:**
  - Hemisphere light (sky blue top / earthy bottom)
  - Directional "sun" light casting soft shadows
  - Point lights on car headlights (two white spotlights)
- **Environment:**
  - Sky: gradient blue sky with sun disc
  - Fog: slight distance fog (blue-grey) for depth
  - Ground plane: green grass extending to horizon

### Road Design (Procedural)
- Road built as connected **CatmullRomCurve3** segments — smooth curves
- Each segment: straight → gentle curve → straight → sharp curve variety
- Road width: 14 units; rendered as a ribbon mesh following the curve
- Road material: dark asphalt grey with white shoulder lines and yellow center dashes
- **Barriers:** low concrete walls on both sides of road, following curve
- **Environment objects** placed alongside road:
  - Pine trees (green cone + brown cylinder, procedural geometry)
  - Lamp posts with orange point lights (every ~80 units)
  - Distance mountains (large low-poly triangles in fog)

### Car Design
- Body: box geometry stretched into a sports car silhouette, metallic red
- 4 wheels: dark cylinders with silver hub caps
- Windshield: dark semi-transparent inset
- Headlights: two small emissive white boxes at front
- Tail lights: two small emissive red boxes at rear
- **Shadow:** cast onto ground plane below

### Post-Processing / Effects
- Subtle **speed lines** overlay at high speed (CSS/canvas overlay, radial blur effect)
- **Skid marks** on road surface when drifting (flat dark lines drawn on road UV)
- **Dust particles** behind wheels when off-road (small brown quads)

### Color Palette
- Sky: `#4A90D9` to `#87CEEB`
- Grass: `#3A7D44`
- Road: `#2C2C2C`
- Car: `#D62828` (metallic red)
- HUD accent: `#F0C040` (gold/yellow)
- Barriers: `#CCCCCC`

---

## 3. Simulation Specification

### Physics Model (Custom — no external physics engine)
- **Coordinate system:** X = lateral, Y = up, Z = forward (along road)
- **Car state:** position (x,z), heading angle, speed (scalar forward velocity)
- **Acceleration:** W key → +accel; S key → -brake/reverse
- **Steering:** A/D keys → turn rate proportional to speed (no steering at standstill)
- **Max speed:** ~80 units/s forward, 20 reverse
- **Friction / drag:** constant deceleration when no input
- **Grip model:** lateral velocity reduced by grip factor; at high lateral slip → drift state
- **Collision with barriers:** speed reduced, car pushed back onto road
- **Collision with environment objects:** speed reduced, game over or respawn

### Simulation Parameters
- Fixed timestep: 1/60s, clamped deltaTime max 0.05s
- Road curve sample rate: 50 points per segment for smooth following
- Car follows road center + player lateral offset

---

## 4. Interaction Specification

### Controls
| Key | Action |
|-----|--------|
| W / ↑ | Accelerate |
| S / ↓ | Brake / Reverse |
| A / ← | Steer Left |
| D / → | Steer Right |
| Space | Handbrake (initiates drift) |
| R | Restart race |
| Esc | Pause menu |

### Game States
1. **Title Screen** — "FORZA RACER" logo, "Press ENTER to Start"
2. **Countdown** — 3, 2, 1, GO! overlay
3. **Racing** — full gameplay
4. **Paused** — overlay with Resume / Restart options
5. **Finished** — lap complete, show time, restart prompt

### HUD Elements
- **Speedometer** (bottom-right): numeric km/h + arc gauge
- **Lap Timer** (top-center): current lap time + best lap
- **Lap Counter** (top-right): Lap X / 3
- **Mini-map** (bottom-left): top-down road overview with car dot

---

## 5. Game Flow

### Race Structure
- 3-lap circuit race
- Timer starts on "GO!"
- Finish line at start/finish zone
- Best lap time tracked
- Total race time shown on completion

### Scoring
- Primary: total race time
- Secondary: best lap time
- Displayed on finish screen with rating (Gold / Silver / Bronze thresholds)

---

## 6. Acceptance Criteria

- [x] Car renders as recognizable 3D sports car with shadows
- [x] Car responds to WASD/arrow keys with realistic acceleration and steering
- [x] Road has smooth curves, not just straight
- [x] Chase camera smoothly follows car
- [x] Speedometer shows real-time speed
- [x] Lap timer counts correctly
- [x] Collision with barriers slows car and keeps it on track
- [x] Title screen → countdown → race → finish flow works
- [x] Restart (R key) resets car and timer
- [x] No console errors on load or during gameplay
- [x] Runs at 60fps on modern hardware

---

## 7. Implementation Phases (One at a Time, Verify Each)

1. **Core 3D scene** — Three.js setup, ground, sky, lighting, camera
2. **Road mesh** — procedural road ribbon with curves
3. **Car mesh** — simple 3D car with wheels
4. **Car physics** — acceleration, braking, steering, movement
5. **Chase camera** — smooth follow behind car
6. **Barriers & environment** — walls, trees, mountains
7. **HUD** — speedometer, timer, lap counter, mini-map
8. **Game states** — title, countdown, race, pause, finish
9. **Polish** — skid marks, dust, speed lines, sounds
