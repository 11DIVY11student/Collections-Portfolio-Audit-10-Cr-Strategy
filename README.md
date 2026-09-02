# Collections-Portfolio-Audit-10-Cr-Strategy
Role: Lead Data Scientist / Analytics Strategy

Tech Stack: Python (Pandas, Seaborn, StatModels), SQL (PostgreSQL), Power BI, Counterfactual Analysis (DiD)

This repository contains a full-stack data science audit of an operational collections portfolio. It demonstrates the complete lifecycle of dismantling flawed legacy reporting, exposing synthetic vendor data, and engineering a production-ready data pipeline to justify a ₹10 Cr budget reallocation to the executive team.

The Business Problem
The operational collections team reported a sustained 11% month-over-month improvement in recovery rates, requesting a ₹10 Cr budget expansion to scale their current vendor strategy. However, top-line revenue remained flat. This project was initiated to audit the underlying data, isolate true causal operational lift, and determine exactly how capital should be deployed.

Key Forensic Findings
Through rigorous statistical investigation and the development of a "Golden Dataset," the legacy reporting was proven to be artificially inflated by severe data traps:

The Attribution Fraud: Legacy systems used an infinite attribution window. Analysis revealed that 89% of all payments were organic self-cures (zero agent touch or >72 hours post-contact), meaning the business was falsely paying vendor commissions on natural payments.

Synthetic Vendor Data: Cross-tabulation and bias testing (Simpson’s Paradox, Survivorship Bias) exposed that third-party telephony logs contained mechanically generated dummy data. For example, risk segments were perfectly distributed at 25% across all cohorts, an impossibility in real-world credit risk.

Time-Series Artifacts: The reported 11% growth was a cherry-picked seasonal fluctuation (a sawtooth trend) exacerbated by ignoring late-arriving data bias (an 80% volume drop-off in recent, immature cohorts).

Methodology: Difference-in-Differences (DiD)
To isolate the true financial impact of active operational strategies, a Difference-in-Differences counterfactual model was applied. By restricting attribution strictly to a 72-hour window and comparing legacy vs. new targeting strategies, the model proved a net-positive operational lift of +₹4,482.36 per account when executed correctly.

The ₹10 Cr Solution (Executive Output)
Based on the strict 72-hour causal attribution model, the final Power BI dashboard successfully reallocated the ₹10 Cr budget to maximize ROI and eliminate vendor fraud:

WhatsApp (₹3.5 Cr): Aggressively scale the highest-margin digital driver.

Calls (₹5.5 Cr): Scale funding but legally gate vendor commissions to the 72-hour attribution window.

SMS (₹1.0 Cr): Maintain baseline operations.

Field Visits (₹0 Cr): Defund immediately due to high cost and zero statistical ROI.

Repository Structure
/sql/: Production-quality, reproducible SQL pipelines (CTEs, Window Functions) handling raw ingestion, entity resolution (dropping ghost accounts), and 72-hour attribution matrix engineering.

/python/: Jupyter notebooks detailing the statistical forensics, bias testing, and DiD modeling.

/dashboard/: The final Power BI .pbix file containing the single-screen Executive Decision Matrix.

/reports/: PDF exports of the Executive Memorandum and Pipeline Architecture Diagram.
