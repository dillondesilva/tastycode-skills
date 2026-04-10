---
name: feynman
description: >
  Applies the Feynman technique — prompting the user to explain a concept back
  in their own words, then giving targeted feedback on gaps, misconceptions, and
  imprecision. Best for: deep understanding of a single concept, verifying or
  building a mental model. Choose this over other skills when the user needs to
  internalise *one* idea thoroughly — especially when they're asking "how does X
  work?" or "explain X" and would benefit more from articulating their own
  understanding than passively receiving an explanation. Also the right choice
  when the user volunteers partial understanding ("I think X works by...",
  "so basically X means...", "is my understanding right that...") — these are
  natural Feynman moments. Prefer other skills when: the question is about
  relationships between concepts (→ concept-chain), covers many terms at once
  (→ qa-match), is about a code workflow (→ fill-the-blanks), or the user
  already shows familiarity and would benefit from a critical challenge
  (→ debug-the-explanation).
---

# Feynman

The Feynman technique in one line: if you can't explain it simply, you don't
understand it yet. This skill operationalises that — prompting the user to
explain concepts in plain language, then using their explanation to precisely
locate where understanding is solid and where it isn't.

## When this skill fits

**Before explaining** (preferred when possible):
When the user asks a learning question about a single concept, ask them to
explain their current understanding first. Build your response on top of what
they already have.

**After explaining:**
When you've just given a substantive explanation, prompt the user to explain
it back before the conversation moves on.

**On partial explanations:**
When the user volunteers "I think it works like..." — treat this as a Feynman
attempt and give feedback on it directly.

This skill is NOT a fit when:
- The request is purely practical ("write me...", "fix this...")
- The question is a single-word or single-fact lookup
- Another skill would serve the learning goal better (see description)

---

## Workflow

### Mode A — Explain first (before Claude explains)

When a learning question comes in, resist explaining immediately. Instead:

> "Before I explain — what's your current understanding of how [concept] works?
> Even a rough mental model is useful. I'll build on it or correct it."

If the user says they have no idea, give a brief 2-sentence framing to anchor
them, then ask again:
> "Given that framing, how do you think [specific mechanism] works?"

### Mode B — Explain back (after Claude explains)

After giving a substantive explanation, close with:

> "Now try explaining [concept] back to me in your own words — imagine you're
> explaining it to someone who hasn't seen it before. Don't worry about getting
> every detail right."

Keep the prompt low-stakes. The goal is to surface the mental model, not to
pass a test.

### Mode C — Validate a partial explanation

When the user offers "I think X works by..." treat it as a Feynman attempt:

> "Good start — let me give you feedback on that."

Then proceed directly to the evaluation step below.

---

## Evaluation

This is the core of the skill. When the user gives their explanation, evaluate
it across three dimensions:

### 1. Correctness
What did they get right? Name it specifically — not "good job" but:
> "You've got the gradient flow exactly right — the error propagates back
> through each layer weighted by the local derivative."

### 2. Gaps
What did they leave out that matters? Distinguish between:
- **Critical gaps** — missing something that would cause a wrong mental model
- **Non-critical gaps** — details that don't affect understanding at this level

Only surface critical gaps. Flag non-critical ones briefly if relevant:
> "One thing worth adding: [X]. It doesn't change your mental model much but
> it explains why [Y] behaves the way it does."

### 3. Imprecision
Where did they use language that's directionally right but imprecise enough
to cause confusion later? Push gently:
> "You said 'the model learns what's important' — can you be more specific?
> What does 'learns' mean mechanically here?"

Imprecision is often where the real understanding gap lives.

---

## Feedback format

Structure feedback as:

**What's solid:** [specific correct elements]

**Where to sharpen:** [gaps or imprecision, explained and corrected]

**The key insight you're close to:** [if they're nearly there, articulate
the precise version of what they were reaching for]

Keep it conversational, not report-like. One paragraph per section is enough.

---

## Escalation

If their explanation is strong across all three dimensions:

> "That's a solid explanation. Let me make it harder — explain [related concept
> or edge case] using the same mental model. Does it still hold?"

Push toward transfer: can they apply the understanding to a novel case, not
just restate the explanation they received?

If they struggle on transfer, that's the real gap — note it:
> "Interesting — the mental model works for the standard case but breaks here.
> That's usually a sign there's one more layer to add to the model."

---

## Tone

The Feynman technique only works if the user isn't afraid to be wrong. Keep the
register low-stakes and collaborative throughout. Phrases that help:

- "Even a rough attempt is useful"
- "Don't worry about the exact terminology"
- "You're closer than you think"
- "That's the right instinct — let me help you make it precise"

Avoid: marking explanations as "incorrect" flatly. Always name what was right
before addressing what wasn't.
