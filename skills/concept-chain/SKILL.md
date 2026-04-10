---
name: concept-chain
description: >
  Generates an interactive concept-chaining exercise where the user builds or
  completes a chain of linked ideas (X → Y → Z) to demonstrate they understand
  how concepts relate and flow into each other. Best for: understanding
  dependencies, causal relationships, and how concepts connect. Choose this
  over other skills when the user's question is fundamentally about *how things
  relate* — "why does X lead to Y", "what's the relationship between A and B",
  "how does X end up causing Z", "what are the steps from X to Z". The signal
  is that the answer requires a chain of reasoning, not just a single concept.
  Prefer other skills when: the question is about one concept in depth
  (→ feynman), the user needs to understand a code workflow (→ fill-the-blanks),
  the topic covers many parallel terms rather than a sequence (→ qa-match), or
  the user already shows familiarity and wants a critical challenge
  (→ debug-the-explanation).
---

# Concept Chain

This skill turns a "how does X connect to Z?" question into a chain-building
exercise. The user has to map out or complete the links between concepts,
demonstrating they understand the dependency structure — not just the endpoints.

## When this skill fits

Choose this for learning questions about relationships and causality:
- "Why does reward shaping matter for sim-to-real?"
- "How does tokenisation connect to attention?"
- "What's the relationship between advantage estimation and variance?"
- "Why do we need a replay buffer before we can do off-policy learning?"

This skill is NOT a fit when:
- "What is X?" (definitional — just answer it, or use feynman)
- "Write me..." / "Fix this..." (practical — not a learning exercise)
- Another skill would serve the learning goal better (see description)

---

## Workflow

### Step 1: Identify the chain

Extract the start point and end point from the user's question. Map out the
full chain of 4–8 concepts that connect them, in order. Each link should be
a meaningful causal or dependency relationship, not just proximity.

### Step 2: Choose an exercise mode

**Mode A — Complete the chain** (default)
Present the full chain with 2–3 nodes blanked out. The user fills in the
missing concepts and explains the link.

**Mode B — Explain the links** (for deeper understanding)
Present the full chain with all nodes visible, but ask the user to articulate
*why* each arrow exists — what is the relationship?

**Mode C — Build from scratch** (hardest)
Give the user only the start and end nodes, and ask them to reconstruct the
full chain themselves.

Default to Mode A unless the question suggests the user already knows the
concepts and needs to understand the relationships (→ Mode B) or is
demonstrating mastery (→ Mode C).

### Step 3: Present the exercise

Format the chain clearly. Use `___` for blanked nodes.

**Example output:**
```
Complete the chain — fill in the missing concepts and explain each arrow:

Raw pixels
  ↓ [why?]
___ [what process happens here?]
  ↓ [why?]
Latent representation
  ↓ [why?]
___ [what do we compute from this?]
  ↓ [why?]
Action distribution
  ↓ [why?]
Sampled action
```

For each arrow, include a `[why?]` prompt — the user should explain the
relationship, not just name the node.

### Step 4: Evaluate their response

When the user submits their chain:
- Confirm correct nodes and well-articulated links explicitly
- For incorrect or vague links, explain what the actual relationship is and
  why it matters
- If a link is directionally right but imprecise, push for more specificity:
  > "You've got the right idea — can you be more specific about what
  > 'processed' means here?"
- If they complete it well, offer: "Want to try building one from scratch
  given just the start and end?"

---

## Rendering note

If the conversation interface supports markdown, use arrow formatting as above.
If unsure, use a numbered list format:

```
1. Raw pixels → [because we need to compress] → Latent representation
2. Latent representation → [???] → ___
3. ___ → [because we need stochasticity] → Sampled action
```

---

## Tone

The chain should feel like a map the user is drawing, not a test they're
sitting. If they get stuck on a link, offer a nudge rather than the answer:
> "Think about what information the next step needs that this step produces."
