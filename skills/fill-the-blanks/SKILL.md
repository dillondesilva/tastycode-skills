---
name: fill-the-blanks
description: >
  Generates a fill-in-the-blanks pseudocode exercise to help the user learn
  how a component or workflow works by completing it themselves, rather than
  just reading an explanation. Use this skill when the user asks a learning-oriented
  question about how something works in code — triggered by questions starting
  with or containing "how does", "how do", "how would", "explain how", "walk me
  through", or "why does X work". Do NOT use for purely practical requests like
  "write me a function" or "fix this bug". Only trigger when there is a clear
  learning intent behind a code or systems question.
---

# Fill the Blanks

This skill turns a "how does X work?" question into a pseudocode exercise where
the user fills in the missing pieces themselves, building genuine understanding
rather than passively reading an explanation.

## When to use

Trigger on learning-intent questions about code or systems:
- "How does the training loop work?"
- "How would a VLA model process an observation?"
- "Walk me through how LeRobot handles data collection"
- "Why does backprop flow through this layer?"

Do NOT trigger on:
- "Write me a function that..."
- "Fix this bug"
- "What's the syntax for..."
- `/vibes` messages

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
