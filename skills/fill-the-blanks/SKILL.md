---
name: fill-the-blanks
description: >
  Generates a fill-in-the-blanks pseudocode exercise to help the user learn
  how a component or workflow works by completing it themselves, rather than
  just reading an explanation. Best for: procedural and code-level understanding
  — training loops, data pipelines, system workflows, algorithms. Choose this
  over other skills when the user's question is about *how something works in
  code* or as a process with sequential steps. The signal is that a good answer
  would naturally be pseudocode or a step-by-step procedure. Prefer other
  skills when: the question is conceptual rather than procedural (→ feynman),
  about relationships between concepts (→ concept-chain), covers many parallel
  terms (→ qa-match), or the user already shows familiarity and wants a
  critical challenge (→ debug-the-explanation).
---

# Fill the Blanks

This skill turns a "how does X work?" question into a pseudocode exercise where
the user fills in the missing pieces themselves, building genuine understanding
rather than passively reading an explanation.

## When this skill fits

Choose this for learning-intent questions about code or systems:
- "How does the training loop work?"
- "How would a VLA model process an observation?"
- "Walk me through how LeRobot handles data collection"
- "Why does backprop flow through this layer?"

This skill is NOT a fit when:
- The request is purely practical ("write me a function...", "fix this bug")
- The question is about syntax lookup, not understanding
- Another skill would serve the learning goal better (see description)

---

## Workflow

### Step 1: Identify the workflow to map

Extract the core process or component from the user's question. Break it into
5–10 logical steps. Aim for a granularity where each step is one meaningful
action — not too atomic, not too broad.

### Step 2: Generate the pseudocode skeleton

Write the pseudocode with 3–5 key steps blanked out as `___[hint]___`.

Hints should be directional but not give the answer away:
- `___[what do we do with the observation before passing it forward?]___`
- `___[how do we know when to stop?]___`
- `___[what gets updated here?]___`

Keep the surrounding context rich enough that a thoughtful person can reason
toward the answer. The blanks should require understanding, not just recall.

**Format:**
```
# [Component Name] — Fill in the blanks

function process(observation):
    # Step 1: Preprocess
    encoded = ___[how do we convert raw obs to a model-ready format?]___

    # Step 2: Forward pass
    action_logits = model.forward(encoded)

    # Step 3: ___[what do we do with raw logits before acting?]___
    action = sample(action_logits)

    # Step 4: Execute
    env.step(action)

    # Step 5: ___[what do we store, and why?]___
    replay_buffer.add(observation, action, reward, next_obs)
```

### Step 3: Invite the user to fill it in

After presenting the skeleton, say something like:

> "Have a go at filling in the blanks — write out what you think goes in each
> one. You don't need to get the syntax perfect, just the intent."

### Step 4: Evaluate their response

When the user fills in the blanks:
- Affirm what they got right specifically
- For gaps or misconceptions, explain the correct answer and *why*
- If they got everything right, offer a harder follow-up variation

---

## Tone

Keep it collaborative, not exam-like. The goal is to help them discover they
understand more than they think, or to pinpoint exactly where the gap is.
