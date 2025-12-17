# Encrypted Harmonics

**A generative 3D sculpture of encrypted text — alive with motion, color, and mystery.**

Encrypted Harmonics is a Processing sketch that transforms any text into a living, breathing 3D sculpture. It uses **SHA-256 encryption** to extract structure from the input, then maps that structure into a rotating field of arcs, bands, and solids. The result is a kinetic mandala — a visual encryption that reveals nothing, yet expresses everything.

This version is built for **stability and soul**: the structure is fixed (hashed once), but the sculpture pulses and flows using **Perlin noise**, giving it a sense of life.

---

## Concept

> “Was dich lebendig fühlen lässt, ist nicht das, was du verstehst — sondern das, was du spürst.”  
> *“What makes you feel alive isn’t what you understand — it’s what you feel.”*

This project explores the idea of **aesthetic encryption** — turning data into art. Instead of hiding meaning, it transforms it. The SHA-256 hash of your input becomes the blueprint for a sculpture that is:
- **Irreversible**: You can’t decode the original message.
- **Unique**: Every input creates a different structure.
- **Expressive**: Color, motion, and form reflect the hidden data.

---

## How It Works

### 1. **Input**
A string of text (e.g., a sentence, poem, or phrase) is defined in the `textInput` variable.

### 2. **Hashing**
The input is hashed using the **SHA-256** algorithm, producing a 64-character hexadecimal string.

### 3. **Hex Pairing**
The hash is split into **32 pairs of hex digits** (e.g., `"3f"` → `63`), giving values from `0–255`.

### 4. **Mapping**
Each value is mapped to:
- Rotation angles (X and Y)
- Arc radius and width
- Rotation speed
- Shape type (arc, bar, solid)
- Color band (blended with Perlin noise)

### 5. **Rendering**
- Shapes are drawn in 3D space using Processing’s `P3D` renderer.
- The sculpture rotates slowly as a whole.
- Each glyph pulses and shifts using **Perlin noise**, creating organic motion.

---

## Color System

The sketch uses a vibrant, expressive palette of 5 color bands:
- 🔶 Orange–Yellow
- 💖 Pink–Magenta
- 🔵 Blue–Cyan
- 🟢 Green–Teal
- ⚪ White

Each glyph’s color is selected based on its hash-derived value and blended using `noise()` for subtle, living variation.

---

## Shape Types

Only the original three shape types are used:
- `arcShape()` – layered radial arcs
- `arcBars()` – segmented arc bands
- `arcSolid()` – filled arc rings

These are selected using `val % 3`.

---

## Motion & Noise

- The sculpture’s base structure is **static**, derived from a one-time hash.
- **Perlin noise** is used to animate:
  - Rotation angles
  - Radius wobble
  - Color blending
- This creates a **breathing, meditative quality** — the sculpture feels alive.

---

## How to Run

### Requirements
- [Processing](https://processing.org/download/) (Java mode)
- No external libraries required

### Steps
1. Open the `.pde` file in Processing
2. Modify the `textInput` string to your desired message
3. Run the sketch
4. Watch your encrypted sculpture come to life

---

## File Structure

├── EncryptedHarmonics.pde   # Main Processing sketch

├── README.md                # Project documentation


---

## Author

**Michael**  
Creative Coder & Cybersecurity Expert


---

## License

MIT License — free to use, remix, and build upon.

---

## Final Thought

> “Encryption is not about hiding — it’s about transforming meaning into mystery.”  
> — *Encrypted Harmonics*