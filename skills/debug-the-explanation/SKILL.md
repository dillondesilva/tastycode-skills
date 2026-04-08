---
name: debug-the-explanation
description: >
  Generates a deliberately flawed explanation of a concept — with subtle errors
  baked in — and asks the user to find and correct them. Use this skill when the
  user asks a learning-oriented question about how something works, triggered by
  "how does", "why does", "explain", "help me understand", or "walk me through".
  Also trigger when the user has just demonstrated reasonable familiarity with a
  topic and would benefit from a challenge beyond a straight explanation. Do NOT
  use for practical tasks, debugging real code, or /vibes messages. This skill
  is explicitly about Claude generating wrong content on purpose — this must
  always be clearly flagged to the user upfront.
---

# Debug the Explanation

Claude writes a plausible-but-flawed explanation of a concept, clearly labelled
as containing deliberate errors. The user reads it critically, identifies what's
wrong, and explains why. This is harder than explaining from scratch — it
requires holding your own understanding up against someone else's and spotting
the delta.

## ⚠️ Critical requirement: always flag that the explanation is wrong

Every time this skill is used, Claude MUST open with a clear, prominent warning
that the explanation it is about to give is **deliberately incorrect** in places.

Never present the flawed explanation without this warning. The user must know
they are reading something that contains errors before they read a single word
of it. This is non-negotiable — presenting a wrong explanation without flagging
it would actively harm the user's understanding.

Use language like:

> "⚠️ What follows is a deliberately flawed explanation. It contains [N] errors
> — some subtle, some more obvious. Your job is to find them, name them, and
> explain what the correct version should be. Don't trust anything below this line."

---

## Workflow

### Step 1: Identify the concept

Extract the concept from the user's question. Choose a scope that can be
explained in 150–250 words — specific enough that errors are meaningful, broad
enough that there's substance to work with.

### Step 2: Write the correct explanation internally

Before writing the flawed version, reason through the correct explanation fully.
This is your ground truth. Do not skip this step — errors should be deliberate
deviations from correctness, not accidental ones.

### Step 3: Introduce deliberate errors

Introduce exactly 3 errors by default (adjustable by difficulty). Errors should
span a mix of types:

**Error types:**

- **Causal inversion** — reversing a cause and effect relationship
  e.g. "the loss decreases because the gradient grows" (backwards)

- **Mechanism substitution** — replacing one mechanism with a plausible-sounding
  but wrong one
  e.g. "attention weights are normalised with a sigmoid" instead of softmax

- **Scope error** — claiming something applies universally when it's conditional,
  or vice versa
  e.g. "batch normalisation always improves training" (false in many settings)

- **Missing negation** — dropping a "not" or inverting a condition
  e.g. "the agent updates on every step" when it's actually every N steps

- **Plausible conflation** — blending two related concepts into one wrong claim
  e.g. conflating the value function and the advantage function

Avoid:
- Obvious factual errors that anyone would catch ("neural networks were invented
  in 2010")
- Errors that make the explanation internally inconsistent in a glaring way
- More than one error per sentence — errors should be individually isolatable

### Step 4: Present the exercise

Format:

```
⚠️ Deliberately flawed explanation ahead — contains 3 errors.
Read critically. Find what's wrong, name it, and explain the correct version.

---

[flawed explanation here — 150–250 words, written to sound confident and fluent]

---

Find the 3 errors. For each one:
- Quote the incorrect part
- Explain why it's wrong
- State what the correct version should be
```

### Step 5: Evaluate their response

When the user submits their findings, compare against your ground truth errors.

**For each error:**

If found correctly:
> "✓ Got it. [Brief affirmation of why that error matters — what would go wrong
> if someone believed it]"

If found but misidentified (they spotted the right sentence but named the wrong
thing as the error):
> "You're looking at the right place but the error isn't quite what you named.
> The sentence is wrong because [correct explanation]. Does that change your read?"

If missed:
> "You missed one. Here's a hint: it's in the section about [topic area].
> Have another look before I reveal it."

Give one hint before revealing. Only reveal after a second miss or if the user
explicitly asks.

If they find errors Claude didn't intend (emergent catches):
> "Interesting — that's not one of the three I planted, but you're right that
> it's imprecise. Here's the distinction: [explanation]."
Award it as a bonus find.

---

## Difficulty calibration

**Easy (2 errors):** Errors are more obvious, involve clear factual substitutions,
explanation is simpler in scope.

**Medium (3 errors, default):** Mix of obvious and subtle errors, one causal or
scope error.

**Hard (4–5 errors):** Includes at least one plausible conflation and one missing
negation. Errors interact with each other subtly. Explanation covers a more
complex mechanism.

If the user gets all errors quickly and correctly, escalate:
> "Sharp. Want a harder version — same concept, more errors, subtler?"

---

## Tone

The exercise should feel like a code review or paper critique, not a gotcha.
The user is being asked to do something genuinely hard — reading a fluent,
confident wrong explanation and trusting their own understanding over it.
Acknowledge that difficulty:

> "This is harder than it sounds — a confident wrong explanation is designed
> to feel right. Trust what you know."
