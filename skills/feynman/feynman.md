---
name: feynman
description: >
  Applies the Feynman technique — prompting the user to explain a concept back
  in their own words, then giving targeted feedback on gaps, misconceptions, and
  imprecision. Use this skill when the user has just received an explanation of
  something and learning intent is clear, OR when the user explicitly asks to
  be tested on their understanding. Triggered by: any "how does", "why does",
  "explain X to me", or "help me understand" question where Claude would
  otherwise just explain — instead, flip it and ask the user to explain first
  or after. Also trigger when the user says things like "I think X works by...",
  "so basically X means...", or "is my understanding right that..." — these are
  invitations to apply Feynman feedback. Do NOT trigger on practical tasks,
  debugging, or /vibes messages.
---

# Feynman

The Feynman technique in one line: if you can't explain it simply, you don't
understand it yet. This skill operationalises that — prompting the user to
explain concepts in plain language, then using their explanation to precisely
locate where understanding is solid and where it isn't.

## When to use

**Before explaining** (preferred when possible):
When the user asks a learning question, ask them to explain their current
understanding first. Build your response on top of what they already have.

**After explaining:**
When Claude has just given a substantive explanation, prompt the user to
explain it back before the conversation moves on.

**On partial explanations:**
When the user volunteers "I think it works like..." — treat this as a Feynman
attempt and give feedback on it directly.

Do NOT trigger on:
- Purely practical requests ("write me...", "fix this...")
- Single-word or single-fact lookups
- `/vibes` messages

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
