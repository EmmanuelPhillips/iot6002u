// COVER SHEET
#page(numbering: none)[
  #align(center + horizon)[
    #text(size: 24pt, weight: "bold")[PwC UK Office Attendance Predictor]
    #v(0.5em)
    #text(size: 14pt)[Project Proposal]

    #v(3em)
    #grid(
      columns: (auto, auto),
      column-gutter: 1em,
      row-gutter: 0.8em,
      align: (right, left),
      [*Name:*], [Emmanuel Phillips],
      [*Student ID:*], [230355585],
      [*Module:*], [IOT6002U - Assessment 001],
      [*University email:*], [ec23279\@qmul.ac.uk],
      [*Work email:*], [emmanuel.j.phillips\@pwc.com],
    )
  ]
  #align(center + bottom)[
    #datetime.today().display("[day] [month repr:long] [year]")
  ]
]

// SET UP LAYOUT FOR REST OF THE DOCUMENT
#set page(numbering: "1")
#set heading(numbering: "1.")
#set text(size: 11pt, font: "New Computer Modern")

//SET UP CONTENTS PAGE
#outline()
#pagebreak() // ENSURE CONTENTS IS ON ITS OWN PAGE

// EACH TOP-LEVEL SECTION STARTS ON A NEW PAGE, AND TABLES NEVER SPLIT ACROSS PAGES
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}
#show table: set block(breakable: false)

// GLOBAL TABLE STYLE
#set table(
  inset: 6pt,
  align: left + top,
  stroke: (x, y) => if y == 0 { (bottom: 0.8pt) } else { (bottom: 0.4pt + luma(200)) },
  fill: (x, y) => if y == 0 { luma(235) },
)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: table): set text(size: 9pt)

// 150 WORDS
= Problem Definition

PwC UK operates a hybrid working model, so daily office attendance varies by site and weekday. Facilities Management (FM) uses attendance to plan catering and cleaning, and Real Estate to allocate space. Without forward visibility, FM risks food waste, mis-sized cleaning shifts and shortfalls on busy days.

Events such as bank holidays, rail strikes and internal events also shift attendance. These are logged in a manual form, but the log is historical and not used to forecast, even though many events are known in advance. Some public events (bank holidays, weather warnings) can be collected automatically, strikes can be compiled from published announcements, and internal events will remain manual.

The Real Estate Data Analytics (REDA) team's cloud data platform (Databricks) holds daily headcount per office. Forecasting relies on the built-in forecast in Power BI, a reporting tool, which has not been checked against past attendance or simple baselines, so its accuracy is unknown. Any new model must beat assuming attendance equals the same weekday last week, a standard benchmark (Makridakis, Spiliotis and Assimakopoulos, 2020).

// 100 WORDS
= Project Aim and Objectives

*Aim:* Develop and evaluate a 1-14 day office attendance forecasting pipeline that outperforms seasonal naive and Power BI baselines, collects public disruption data automatically and provides calibrated prediction intervals.

*Objectives:*
+ Define KPIs and simulation assumptions, and generate synthetic data mirroring REDA table structures.
+ Automate collection of bank holidays and weather warnings, compile announced strike dates, and store them in a staged (medallion) data architecture.
+ Benchmark seasonal naive and Power BI baselines.
+ Compare SARIMAX, LightGBM and XGBoost per office using rolling-origin validation (repeated forward forecasting; Cerqueira, Torgo and Mozetic, 2020) and average error measures (MAE, MAPE).
+ Produce prediction intervals and report their coverage.
+ Identify influential events using feature importance.
+ Deliver a dashboard, evaluate results and recommend next steps.

*Future value:* a validated forecast could support wider space optimisation decisions.

// 150 WORDS
= Research Plan

Prior work will be identified through IEEE Xplore, the ACM Digital Library, ScienceDirect, Google Scholar and arXiv, plus Databricks and MLflow documentation. Searches are mapped to project objectives (@tbl-research).

Peer-reviewed work from 2018 onwards is prioritised for methods, and from 2020 for hybrid working. Sources are selected for transparent data and relevance to small daily series. Occupancy estimation research is largely sensor-based (Chen, Jiang and Xie, 2018), so findings will guide method choices rather than set expected accuracy.

AI may support keyword generation and abstract screening; all sources are read and verified directly. References are managed using MyBib. Findings will inform model selection, validation, feature design and interval calibration.

#figure(
  table(
    columns: (auto, 1.5fr, auto, 1.3fr),
    table.header[*Objective*][*Search terms*][*Sources*][*Purpose*],

    [Simulation],
    [
      "synthetic time series generation" \
      "hybrid working attendance patterns" \
      "weekday effects office attendance"
    ],
    [Google Scholar, arXiv],
    [Ground simulation assumptions and reduce the risk of unrealistic data],

    [Platform],
    [
      "medallion architecture" \
      "MLflow experiment tracking"
    ],
    [Databricks and MLflow documentation],
    [Inform pipeline design and experiment tracking],

    [Baselines],
    [
      "seasonal naive forecasting" \
      "forecast benchmark" \
      "M-competition"
    ],
    [IEEE Xplore, Google Scholar],
    [Confirm baseline choice and standard evaluation metrics],

    [Models],
    [
      "SARIMAX exogenous variables" \
      "LightGBM time series" \
      "XGBoost forecasting" \
      "rolling-origin evaluation"
    ],
    [ScienceDirect, arXiv],
    [Justify model selection and validation strategy],

    [Events],
    [
      "calendar effects forecasting" \
      "holiday effect forecasting" \
      "special events demand forecasting" \
      "feature importance time series"
    ],
    [ACM DL, IEEE Xplore],
    [Decide which event features to include and how to encode them],

    [Intervals],
    [
      "conformal prediction time series" \
      "prediction interval calibration" \
      "quantile regression forecasting"
    ],
    [arXiv, Google Scholar],
    [Choose an interval method suitable for small daily series],

    [Context],
    [
      "hybrid work office occupancy" \
      "workplace utilisation post-2020"
    ],
    [Google Scholar, grey literature],
    [Ground assumptions about attendance patterns],
  ),
  caption: [Literature search plan by project objective],
) <tbl-research>

// 100 WORDS
= Identification of Technologies, Tools and/or Datasets

*Platform:* Databricks with Delta tables and MLflow (experiment tracking), so the pipeline mirrors production, with Unity Catalog providing governance. Alternatives: local Python with DuckDB (cheaper, ungoverned) and Azure ML (heavier for a small problem).

*Models:* Chosen for interpretability (SARIMAX; Hyndman and Athanasopoulos, 2021) and flexibility with event features (LightGBM, Ke et al., 2017; XGBoost, Chen and Guestrin, 2016), as compared in @tbl-models.

*Data:* Synthetic data is generated in Python (Faker plus custom simulation), mirroring the REDA attendance, office and date tables, with event effects from documented assumptions. Bank holidays, Met Office warnings and TfL disruption come from public feeds, and strike dates are compiled manually from union and operator announcements, as no structured feed exists. No real PwC attendance data is used.

*Intervals and dashboard:* Conformal prediction or quantile regression, chosen during research for small daily series; Power BI for the dashboard, with Databricks dashboards as an alternative.

#figure(
  table(
    columns: (auto, 1.4fr, 1.4fr, auto),
    table.header[*Model*][*Strengths*][*Constraints*][*Decision*],
    [SARIMAX], [Captures weekly patterns and event effects; easy to explain], [Assumes simple relationships between events and attendance], [Included],
    [LightGBM], [Quickly learns interacting effects (e.g. a strike on a Friday)], [Harder to explain; can overfit short series], [Included],
    [XGBoost], [Similar to LightGBM; widely used and documented], [Harder to explain], [Included],
    [ARIMA], [Simple classical method], [Cannot use event data; SARIMAX extends it with seasonality and external variables], [Excluded],
    [Prophet], [Handles holidays and seasonality automatically], [Overlaps the included models; adds scope], [Excluded],
    [LSTM (neural network)], [Learns long, complex patterns], [Needs large data and is hard to explain; daily office series are small], [Excluded],
  ),
  caption: [Candidate forecasting models, strengths, constraints and decision],
) <tbl-models>

// EXCLUDED FROM WORD COUNT
= Project Plan and Milestones

== Key dates

// UPDATE STATUS AND DATES BEFORE SUBMITTING
#figure(
  table(
    columns: (auto, 1fr, auto),
    table.header[*Status*][*Milestone*][*Date*],
    [Met], [Project options shortlisted], [10 Oct 2026],
    [Planned], [Discuss options with manager and lecturer], [25 Oct 2026],
    [Planned], [Finalise choice of project], [25 Oct 2026],
    [Planned], [Proposal submitted], [30 Oct 2026],
    [Planned], [Project build starts (assumed)], [2 Nov 2026],
    [Planned], [University exam period (expected)], [6 to 20 Jan 2027],
    [Planned], [Return to PwC (expected)], [First week of Feb 2027],
    [Planned], [Learning journals and portfolio (likely)], [22 Feb 2027],
    [Planned], [Gateway (expected)], [2nd to 3rd week of Mar 2027],
    [Planned], [Project report submission], [23 Apr 2027],
    [Planned], [EPA sessions (online)], [17 May to 4 Jun 2027],
  ),
  caption: [Key project milestones and status],
) <tbl-dates>

== Project build schedule (week 1 starts 2 Nov 2026, 25 weeks to submission)

#let tasks = (
  ("KPIs, horizon and simulation assumptions", 1, 2, rgb("#1f4e79")),
  ("Synthetic data generator", 2, 4, rgb("#1f4e79")),
  ("Ingestion pipeline (bronze to gold)", 3, 7, rgb("#1f4e79")),
  ("Baselines (seasonal naive, Power BI)", 6, 7, rgb("#1f4e79")),
  ("Christmas and exams (no planned work)", 8, 12, luma(170)),
  ("Model benchmarking in MLflow", 13, 16, rgb("#1f4e79")),
  ("Check simulation assumptions with FM (at PwC)", 14, 15, rgb("#4f8a6a")),
  ("Intervals and feature importance", 17, 18, rgb("#1f4e79")),
  ("Dashboard", 19, 20, rgb("#1f4e79")),
  ("Dashboard feedback from FM and REDA (at PwC)", 20, 21, rgb("#4f8a6a")),
  ("Evaluation and recommendations", 20, 21, rgb("#1f4e79")),
  ("Report drafting and finalising", 18, 25, rgb("#7f9bb8")),
)

#[
  #show table: set text(size: 8pt)
  #figure(
    table(
      columns: (auto,) + (1fr,) * 25,
      inset: 3pt,
      stroke: 0.4pt + luma(200),
      table.header([*Task*], ..range(1, 26).map(w => text(size: 6pt)[#w])),
      ..tasks
        .map(t => (
          [#t.at(0)],
          ..range(1, 26).map(w => if w >= t.at(1) and w <= t.at(2) {
            table.cell(fill: t.at(3))[]
          } else { [] }),
        ))
        .flatten(),
    ),
    caption: [Project build schedule by week from 2 Nov 2026 (week 25 ends at submission on 23 Apr 2027)],
  ) <tbl-schedule>
]

Dependencies: modelling depends on the synthetic data generator and ingestion pipeline. The dashboard depends on the chosen model and validated intervals. The build does not need the workplace, so it starts in November, with stakeholder checks (green) planned for when I am back at PwC. The report is drafted alongside evaluation and finalised after the gateway. If the schedule slips, the dashboard is dropped first.

// EXCLUDED FROM WORD COUNT
= Risk Register

#figure(
  table(
    columns: (auto, 1.2fr, auto, auto, 2fr),
    table.header[*ID*][*Risk*][*Likelihood*][*Severity*][*Mitigation*],

    [R1],
    [Synthetic data too simple, so models only recover the generating rules],
    [High],
    [High],
    [Add noise, regime changes and unmodelled events, hold out event types from training, document all generator assumptions in an appendix, state that results show method performance rather than real-world accuracy],

    [R2],
    [Real PwC values or identifiers included by accident],
    [Low],
    [High],
    [Generate from schema only, copy no real values, review all outputs before sharing],

    [R3],
    [Findings do not transfer to real data],
    [Medium],
    [Medium],
    [Frame as a method evaluation, build the pipeline so real data can be swapped in later, base parameters on qualitative patterns described by FM],

    [R4],
    [Public feeds unreliable or change format],
    [Medium],
    [Medium],
    [Store raw responses in bronze, validate on load, fall back to manual flag],

    [R5],
    [Models fail to beat baselines],
    [Medium],
    [Medium],
    [Report as a valid finding, recommend baseline-plus improvements],

    [R6], [Scope creep], [Medium], [Medium], [Fixed objectives, natural-language AI query tools (MCP, Genie) out of scope],

    [R7],
    [Confidentiality limits on describing PwC systems],
    [Medium],
    [Medium],
    [Agree restrictions with manager on Power BI setup, office counts and schemas, use generic names],

    [R8],
    [Power BI baseline run on synthetic data is only a proxy for the live forecast],
    [Medium],
    [Low],
    [Document the settings used, state the limitation in the evaluation],

    [R9], [Compute cost overrun], [Low], [Low], [Small data, job clusters with auto-termination],

    [R10],
    [Forecast seen as employee monitoring, or reused for individual tracking or enforcing attendance],
    [Medium],
    [High],
    [Use office-level daily totals only, with no individual or team data and a minimum group size; agree intended use with the line manager; exclude performance management use; review wording with FM and HR before any rollout],

    [R11],
    [Decisions based on the forecast disadvantage groups (e.g. carers, disabled or part-time staff) or give FM staff unpredictable shifts],
    [Medium],
    [High],
    [Keep the forecast advisory with human sign-off; give minimum notice for shift changes; protect accessible and fixed desk provision; consult EDI and employee representatives before any production use],
  ),
  caption: [Risk register with likelihood, severity and mitigations],
) <tbl-risks>

*Ethics and compliance:* The project uses synthetic data generated from table schemas only, with no real PwC values and no human participants. The module organiser does not foresee a need for university ethics review provided the work is not rolled out to production. Attendance forecasting still raises employee trust and EDI questions (R10, R11), so a data protection and EDI impact assessment would precede any rollout. Confidentiality limits on describing PwC systems will be agreed with the line manager.

// EXCLUDED FROM WORD COUNT
= References

#[
  #set par(hanging-indent: 1.5em)

  Cerqueira, V., Torgo, L. and Mozetič, I. (2020) 'Evaluating time series forecasting models: an empirical study on performance estimation methods', _Machine Learning_, 109, pp. 1997--2028. Available at: https://doi.org/10.1007/s10994-020-05910-7.

  Chen, T. and Guestrin, C. (2016) 'XGBoost: a scalable tree boosting system', in _Proceedings of the 22nd ACM SIGKDD International Conference on Knowledge Discovery and Data Mining_. New York: ACM, pp. 785--794. Available at: https://doi.org/10.1145/2939672.2939785.

  Chen, Z., Jiang, C. and Xie, L. (2018) 'Building occupancy estimation and detection: a review', _Energy and Buildings_, 169, pp. 260--270. Available at: https://doi.org/10.1016/j.enbuild.2018.03.084.

  Hyndman, R.J. and Athanasopoulos, G. (2021) _Forecasting: principles and practice_. 3rd edn. Melbourne: OTexts. Available at: https://otexts.com/fpp3/ (Accessed: 19 October 2026).

  Ke, G. et al. (2017) 'LightGBM: a highly efficient gradient boosting decision tree', in _Advances in Neural Information Processing Systems 30_. Red Hook, NY: Curran Associates, pp. 3146--3154.

  Makridakis, S., Spiliotis, E. and Assimakopoulos, V. (2020) 'The M4 Competition: 100,000 time series and 61 forecasting methods', _International Journal of Forecasting_, 36(1), pp. 54--74.
]

// EXCLUDED FROM WORD COUNT
= Appendices

== Appendix A: Generative AI declaration

Generative AI was used in order to help explore potential risks, as well as non-trivial formatting. All AI output was read and verified before being inputted into my project proposal. I take full responsibility for the final content of this document.

== Appendix B: Planned KSB mapping

#figure(
  table(
    columns: (auto, 1fr),
    table.header[*KSB*][*Planned evidence*],
    [S50], [Dashboard and communication of results],
    [S52, S53], [Model benchmarking, rolling-origin validation and stability testing],
    [S54, K56], [Automated ingestion of public data sources],
    [S55, K54], [Analysis of simulated attendance across offices],
    [S2, K3], [Risk register and mitigations],
    [S5, S6, K15], [Project plan, schedule and time/cost estimation],
    [K18, S14], [Research plan and evaluation of forecasting methods],
    [B3], [Synthetic data approach, no real PwC data used],
  ),
  caption: [Planned KSB mapping],
) <tbl-ksb>
