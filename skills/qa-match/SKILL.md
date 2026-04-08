---
name: qa-match
description: >
  Generates a question-and-answer matching exercise using a letter-coded table,
  where the user matches shuffled answers to their correct questions. Use this
  skill when the user asks a learning-oriented question that touches on multiple
  related concepts, terms, or mechanisms at once — triggered by questions like
  "what are the different types of", "can you explain all the parts of",
  "what do each of these do", "break down the components of", or any question
  where a useful answer would naturally cover 4+ distinct concepts. Do NOT use
  for single-concept questions, practical tasks, or debugging. Only trigger when
  learning intent is clear and the topic is naturally multi-part.
---

# Q&A Match

This skill turns a multi-concept learning question into a matching exercise.
Questions and answers are presented in separate shuffled columns — the user
matches them using letter codes, demonstrating recall and discrimination between
related ideas.

## When to use

Trigger when the answer would naturally cover 4+ distinct concepts:
- "What are the different RL algorithm families and when do you use each?"
- "Can you break down the components of a transformer?"
- "What do each of the LeRobot dataset fields represent?"
- "Explain the different types of reward shaping"

Do NOT trigger on:
- Single-concept questions ("what is a Q-function?")
- "How does X work?" questions (→ use fill-the-blanks instead)
- Practical/task requests
- `/vibes` messages

---

## Workflow

### Step 1: Extract the concept set

Identify 4–8 distinct concepts, terms, or components from the user's question.
These become the questions. Aim for concepts that are related enough to be
confusable — that's what makes matching non-trivial.

### Step 2: Write Q&A pairs

For each concept write:
- A **question** that is specific enough to have one clear answer
- An **answer** that is concise (1–3 sentences), distinct from the others,
  and would be wrong if matched to a different question

Avoid answers that are so generic they could plausibly match multiple questions.

### Step 3: Shuffle and code

- Assign each **question** a number: 1, 2, 3...
- Assign each **answer** a letter: A, B, C... — in a *different* shuffled order

Present both columns side by side or stacked clearly.

**Format:**
```
## Questions
1. What is the role of the critic in an actor-critic method?
2. What does the advantage function measure?
3. What is the purpose of entropy regularisation?
4. What is a baseline in policy gradient methods?
5. What does clipping do in PPO?

---

## Answers (match to questions above)

A. A value subtracted from returns to reduce variance without introducing bias.

B. Encourages the policy to maintain randomness, preventing premature convergence
   to a deterministic policy.

C. Estimates the value of states, providing a signal to update the actor without
   needing full returns.

D. Limits how much the policy can change in a single update, keeping training stable.

E. How much better an action was compared to what was expected under the current policy.
```

### Step 4: Prompt the user

> "Match each answer (A–E) to its question (1–5). Write your answers as:
> 1-?, 2-?, 3-?, 4-?, 5-?"

### Step 5: Evaluate their response

When the user submits their matches:

**For each pair:**
- ✓ Correct: confirm briefly and add one sentence of reinforcing context
- ✗ Incorrect: reveal the right match and explain *why* the confusion is
  understandable, then clarify the distinction

**Example correction:**
> "3 → B is right, not 3 → A. Easy mix-up — both relate to variance reduction,
> but entropy regularisation acts on the *policy distribution* itself, while a
> baseline acts on the *return estimate*. Different levers."

If they score 100%: offer a harder round with more confusable concepts, or
flip the exercise — give them the answers and ask them to write the questions.

---

## Difficulty calibration

**Easier:** Make answers longer and more descriptive, questions more specific
**Harder:** Make answers terse, include plausible distractors, use jargon without
definition, increase the number of pairs to 8+

Default to medium difficulty. If the user seems confident, ratchet up.

---

## Tone

Frame it as a quick check, not a test. Something like:
> "Let's see how these concepts sit — quick matching exercise, no pressure."

If they get most right, make it feel like confirmation rather than examination.
