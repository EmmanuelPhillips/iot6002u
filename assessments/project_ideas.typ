#set page(numbering: "1")
#set heading(numbering: none)
#set text(size: 11pt, font: "Times New Roman")

Emmanuel Phillips | 230355585 | ec23279\@qmul.ac.uk | emmanuel.j.phillips\@pwc.com
= Project Idea Options

== My Ideas
- Attendance Predictor: short-term forecast per office so facilities management can plan catering, cleaning.
- MCP with Genie: expose curated data to agents through MCP.

== Alternative Ideas
- Data Engineering: data quality framework.
- AI and Analytics Agents: a Genie evaluation framework.
- Attendance and Space Analytics: distinct from prediction, detecting anomalies.

== Attendance Predictor
Preferred Project
- Aim: Develop and evaluate a short-term office attendance forecasting model for PwC UK offices. This will support FM planning.
- Measurable Objective: Beat a naive baseline model (i.e. same weekday last week) on MAPE or MAE per office, over a 1-14 day horizon.
- Models to compare: Seasonal baseline, prophet, SARIMAX, lightgbm, xgboost.
- Features: Day of week, bank holidays, anomalous dates, strikes, weather warnings etc.
- Tooling: MLflow, delta tables from medallion layers (make synthetic data so as to not use PwC data).
- Risks: Personal data, limited history due to pandemic.

== MCP with Genie
- Aim: Expose curated gold tables to AI agents through an MCP server, with access controls and audit logging.
- Measurable Objective: Hard to define. A possible metric is answer accuracy on a fixed benchmark question set.
- Tooling: Databricks Genie spaces, MCP server, Unity Catalog permissions.
- Risks: Fast-moving technology, weaker research base, no obvious success metric.
- Note: Works better as a later objective, e.g. exposing forecasts through a Genie space.

== Data Engineering
- Automated data quality framework: validation rules, duplicate and redundant column detection, and monitoring across bronze, silver and gold layers.
- Pipeline performance and cost optimisation: benchmark incremental loads, caching and table design against Databricks compute cost.
- Metadata and lineage tooling: LLM-assisted data dictionary and lineage map that documents columns and flags unused ones.
- Builds on: last year's medallion lakehouse work.
- Measurable: number of issues caught, pipeline runtime, compute cost.

== AI and Analytics Agents
- Genie evaluation framework: benchmark question set to measure text-to-SQL accuracy per space and improve space configuration.
- Natural language reporting agent: answers attendance and utilisation questions with cited source tables.
- Builds on: last year's Genie space configuration.
- Measurable: text-to-SQL accuracy before and after configuration changes.

== Attendance and Space Analytics
Distinct from prediction
- ML-based anomaly detection: replace or extend the rules-based anomalous dates flag, ideally learning which events actually shift attendance.
- Attendance driver analysis: explanatory model of what drives attendance (commute time via TfL API, weekday, policy days, events).
- Automated event ingestion: pull strikes, weather warnings and disruptions from public feeds instead of the manual form.
- Space demand scenario simulation: use headcount and attendance to test desk ratios and office consolidation options.
- Builds on: last year's anomalous dates flag.

== Fallbacks if the Predictor Goes Elsewhere
- ML-based anomaly detection
- Attendance driver analysis
- Both reuse the same data and existing flag, but are clearly different projects.
