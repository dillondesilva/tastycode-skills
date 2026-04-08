---
name: concept-chain
description: >
  Generates an interactive concept-chaining exercise where the user builds or
  completes a chain of linked ideas (X → Y → Z) to demonstrate they understand
  how concepts relate and flow into each other. Use this skill when the user
  asks a learning question about how concepts connect, depend on each other, or
  lead to an outcome — triggered by questions like "why does X lead to Y",
  "what's the relationship between", "how does X end up causing Z", "what are
  the steps from X to Z", or "why do we need X before Y". Do NOT use for
  purely practical or task-oriented requests. Only trigger when there is clear
  learning intent about conceptual relationships or causal chains.
---

# Concept Chain

This skill turns a "how does X connect to Z?" question into a chain-building
exercise. The user has to map out or complete the links between concepts,
demonstrating they understand the dependency structure — not just the endpoints.

## When to use

Trigger on learning questions about relationships and causality:
- "Why does reward shaping matter for sim-to-real?"
- "How does tokenisation connect to attention?"
- "What's the relationship between advantage estimation and variance?"
- "Why do we need a replay buffer before we can do off-policy learning?"

Do NOT trigger on:
- "What is X?" (definitional — just answer it)
- "Write me..." / "Fix this..."
- `/vibes` messages

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
