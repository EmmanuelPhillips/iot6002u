// iot6000u 001 presentation skeleton
// compile: typst compile phronesis.typ
// watch:   typst watch phronesis.typ
// requires typst >= 0.14 (touying 0.7.4 is fetched on first compile)

#import "@preview/touying:0.7.4": *
#import themes.simple: *

// ---------- config ----------
#let accent = rgb("#2f6fed")

#let stat(big, body, src) = block(
  height: 100%,
  width: 100%,
  grid(
    rows: (auto, 1fr, auto),
    row-gutter: 0.4em,
    text(size: 34pt, weight: "bold", fill: accent)[#big],
    text(size: 18pt)[#body],
    text(size: 14pt, fill: gray)[#src],
  ),
)

#show: simple-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Phronesis],
    subtitle: [Adaptive AI practice to rebuild code comprehension],
    author: [Emmanuel Phillips],
    date: [5th November 2026],
    institution: [Queen Mary University of London],
  ),
  // keep the bottom-right free for the obs webcam overlay
  config-page(margin: (top: 2.5em, bottom: 2.5em, left: 3em, right: 3em)),
)

#set text(size: 22pt )
#show raw: set text(size: 16pt)
#show link: set text(fill: accent)

// ---------- 1. title (0:20) ----------
#title-slide[
  = Phronesis
  Adaptive AI practice to rebuild code comprehension
  #v(0.5em)
  Name: Emmanuel Phillips \
  Student ID: 230355585 \
  Module: IOT6000U Digital Innovation and Product Development \
  Assessment: 001 Presentation
]

// ---------- 2. area of investigation (1:15) ----------
== Area of Investigation: AI is outpacing understanding

*Vibe coding:* using artificial intelligence, prompted by natural language, to assist with writing computer code @collins2025

#v(0.6em)

#grid(
  columns: (1fr, 1fr, 1fr),
  rows: (9em),
  gutter: 1.2em,
  align: top,
  stat(
    [84%],
    [of developers use or plan to use AI tools, 51% of professionals daily],
    [@stackoverflow2025],
  ),
  stat(
    [50% vs 67%],
    [comprehension quiz score, AI-assisted vs hand-coding developers, biggest gap on debugging],
    [@shen2026skill],
  ),
  stat(
    [17% lower],
    [grades once AI access was removed, for students with unrestricted GPT-4],
    [@bastani2025guardrails],
  ),
)

#v(0.6em)

How AI is used matters: designs that keep learners engaged largely avoided the harm @shen2026skill @bastani2025guardrails

// ---------- 3. gap in current solutions (0:45) ----------
== Gap in current solutions

#[
  #set text(size: 18pt)
  #table(
    columns: (1.1fr, 1.2fr, 1.5fr),
    inset: 8pt,
    stroke: (bottom: 0.5pt + gray),
    [*What exists*], [*What it offers*], [*What it misses*],
    [Interview platforms (e.g. LeetCode)], [Huge fixed problem bank], [Built around passing interviews],
    [AI add-ons (e.g. LCPath, LeetCode Coach)], [Weakness analysis and hints @leetcodecoach2026], [Aimed at interview candidates, still centred on solving problems],
    [Course platforms (e.g. Codecademy)], [AI tutoring], [Set curriculum],
    [Knowledge tracing research], [Models learner progress over time], [Mostly predicts correctness from quiz-style data @dai2021knowledgetracing],
  )
]

#v(0.8em)

#block(
  fill: accent.lighten(85%),
  inset: 12pt,
  radius: 6pt,
  width: 100%,
)[
  *The gap:* adaptive practice aimed at comprehension (reading, tracing and debugging code). Tracing and explaining skills are linked to code writing ability @lopez2008relationships
]

// ---------- 4. proposed ai solution (1:30) ----------
== Proposed AI solution

- short daily challenge set tailored to your weak concepts
- weakness model: mastery score per concept (e.g. knowledge tracing)
- llm: generates variants and hints
- architecture diagram goes here

// ---------- 5. prototype and feasibility (1:15) ----------
== Prototype and feasibility

// swap in real screenshots and code
```python
def next_challenge(mastery: dict[str, float], pool: list[dict]) -> dict:
    weakest = min(mastery, key=mastery.get)
    return next(c for c in pool if weakest in c["concepts"])
```

// ---------- 6. alternative comparison (1:00) ----------
== Alternative solution comparison

#table(
  columns: (auto, 1fr, 1fr),
  inset: 8pt,
  [], [*Proposed*], [*Alternative*],
  [approach], [ml-based weakness tracking], [rules-based tagging],
  [question source], [llm-generated plus curated], [curated bank only],
  [advantage], [competitive advantage here], [simpler, cheaper],
)

// ---------- 7. obstacles: external (1:00) ----------
== Obstacles: external (PESTEL)

#table(
  columns: (auto, 1fr),
  inset: 6pt,
  [*Political*], [],
  [*Economic*], [],
  [*Social*], [],
  [*Technological*], [],
  [*Environmental*], [],
  [*Legal*], [],
)

// ---------- 8. obstacles: internal (0:45) ----------
== Obstacles: internal

- technical: cold start problem, question quality
- human: motivation and retention
- resourcing: build time, llm costs
- mitigations for each

// ---------- 9. business case: initiative and benefits (1:00) ----------
== Business case: initiative and value

- type of initiative and why (startup, social enterprise or internal initiative)
- benefits and value delivered
- scale path: interview prep, ctf prep, corporate l&d

// ---------- 10. business case: resources (0:45) ----------
== Business case: resources

- short term: people, tools, costs
- long term: people, tools, costs

// ---------- 11. conclusion (0:15) ----------
== Conclusion

- one line recap of problem, solution and value

// ---------- 12. references (0:10) ----------
== References

#set text(size: 14pt)
#bibliography("refs.bib", title: none, style: "harvard-cite-them-right", full: true)
