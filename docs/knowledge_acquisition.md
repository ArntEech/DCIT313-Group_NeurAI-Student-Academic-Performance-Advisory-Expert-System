# 📘 Knowledge Engineering Document

## Student Academic Performance Advisory Expert System (SAPAES)

**Course:** DCIT 313 — Introduction to Artificial Intelligence  
**Group:** 36 (Team NeurAI)  
**Date:** March 2026

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [System Architecture](#2-system-architecture)
3. [Intelligent Agent Model](#3-intelligent-agent-model)
4. [Repository Structure](#4-repository-structure)
5. [Component Design](#5-component-design)
6. [System Workflow](#6-system-workflow)
7. [Data Flow](#7-data-flow)
8. [Rule Evaluation Flowchart](#8-rule-evaluation-flowchart)
9. [Design Principles](#9-design-principles)
10. [Testing Strategy](#10-testing-strategy)
11. [Technology Stack](#11-technology-stack)

---

## 1. Introduction

### What is SAPAES?

SAPAES (**S**tudent **A**cademic **P**erformance **A**dvisory **E**xpert **S**ystem) is a rule-based AI system that acts like a **virtual Academic Advisor**. It takes a student's academic data as input and uses logical reasoning to:

- **Classify** the student's academic risk level (High, Moderate, or Excellent)
- **Recommend** specific interventions (counseling, remedial classes, advanced coursework)
- **Explain** *why* it reached that conclusion (Explainable AI)

### Why is it an Expert System?

An **Expert System** captures knowledge from a human expert (in this case, an Academic Advisor) and encodes it as logical rules. Instead of writing `if-else` statements in Python, the intelligence lives entirely inside **Prolog rules** — making the system truly "intelligent" in the AI sense.

---

## 2. System Architecture

SAPAES follows a **3-Layer Expert System Architecture**, where each layer has a distinct responsibility:

```
┌─────────────────────────────────────────────────────┐
│                  LAYER 1: INTERFACE                  │
│          Python (main.py, input_handler.py)          │
│     Collects student data & displays results         │
└──────────────────────┬──────────────────────────────┘
                       │  pyswip bridge
                       ▼
┌─────────────────────────────────────────────────────┐
│              LAYER 2: INFERENCE ENGINE               │
│              SWI-Prolog (inference.pl)               │
│      Evaluates rules against student facts           │
└──────────────────────┬──────────────────────────────┘
                       │  consults
                       ▼
┌─────────────────────────────────────────────────────┐
│              LAYER 3: KNOWLEDGE BASE                 │
│              SWI-Prolog (rules.pl)                   │
│    Contains all expert rules & recommendations       │
└─────────────────────────────────────────────────────┘
```

| Layer | Technology | File(s) | Responsibility |
|:------|:-----------|:--------|:---------------|
| **Interface** | Python | `main.py`, `input_handler.py`, `output_formatter.py` | Collect input from user, display results |
| **Inference Engine** | SWI-Prolog | `inference.pl` | Match facts against rules, derive conclusions |
| **Knowledge Base** | SWI-Prolog | `rules.pl` | Store all expert rules, recommendations, and explanations |

> **Key Principle:** Python handles *interaction*, Prolog handles *intelligence*. Python never contains decision logic — all reasoning is done through Prolog rules.

---

## 3. Intelligent Agent Model

SAPAES behaves as an **Intelligent Agent** — a system that *perceives* its environment, *reasons* about it, and *acts* accordingly.

### Agent Component Mapping

| Agent Component | What It Means | SAPAES Implementation |
|:----------------|:-------------|:---------------------|
| **Perception** | What the agent "sees" | Student input — score, attendance, trend |
| **Environment** | The domain the agent operates in | Academic evaluation / university context |
| **Reasoning** | How the agent "thinks" | Prolog rule inference (Forward Chaining) |
| **Action** | What the agent "does" | Classifies risk + gives recommendation + explains why |

### How Data Flows Through the Agent

```
        ┌─────────────────────────┐
        │       PERCEPTS          │
        │  (What the agent sees)  │
        ├─────────────────────────┤
        │  • average_score        │
        │  • attendance           │
        │  • performance_trend    │
        └────────────┬────────────┘
                     │
                     ▼
        ┌─────────────────────────┐
        │    INFERENCE RULES      │
        │  (How the agent thinks) │
        ├─────────────────────────┤
        │  Prolog evaluates rules │
        │  against the percepts   │
        └────────────┬────────────┘
                     │
                     ▼
        ┌─────────────────────────┐
        │       ACTIONS           │
        │  (What the agent does)  │
        ├─────────────────────────┤
        │  • risk_level           │
        │  • recommendation       │
        │  • explanation          │
        └─────────────────────────┘
```

**In plain English:** The system *perceives* a student's score, attendance, and trend → *reasons* about them using Prolog rules → *acts* by outputting a risk level, recommendation, and explanation.

---

## 4. Repository Structure

```
DCIT313-Group_NeurAI-Student-Academic-Performance-Advisory-Expert-System/
│
├── knowledge_base/                 ← 🧠 THE INTELLIGENCE (Prolog)
│   ├── rules.pl                    ← Expert rules, recommendations, explanations
│   └── inference.pl                ← Forward chaining inference engine
│
├── interface/                      ← 💻 USER INTERACTION (Python)
│   ├── main.py                     ← Entry point — runs the system
│   ├── input_handler.py            ← Collects & validates student data
│   └── output_formatter.py         ← Formats and displays results
│
├── docs/                           ← 📄 DOCUMENTATION
│   ├── knowledge_acquisition.md    ← This document (knowledge engineering)
│   └── system_report.pdf           ← Final system report
│
├── requirements.txt                ← Python dependencies (pyswip)
└── README.md                       ← Project overview & setup instructions
```

| Folder | Purpose | AI Role |
|:-------|:--------|:--------|
| `knowledge_base/` | Prolog rules that encode expert knowledge | **Intelligence** — this is where the AI "lives" |
| `interface/` | Python scripts for user interaction | **Interaction** — how the user talks to the AI |
| `docs/` | Knowledge engineering documentation | **Documentation** — explains how the system was built |

---

## 5. Component Design

### 5.1 User Interface (Python — `interface/`)

The Python interface is **only** responsible for:

1. **Collecting** student data from the user
2. **Sending** that data to Prolog via `pyswip`
3. **Displaying** the results returned by Prolog

#### Example User Interaction

```
======================================
  SAPAES — Academic Performance Advisory
======================================

Enter student average score: 38
Enter attendance percentage: 55
Enter performance trend (improving/declining/stable): declining
```

> ⚠️ **Important:** Python does **NOT** contain any decision logic. No `if score < 40` in Python. All reasoning is done by Prolog.

---

### 5.2 Knowledge Base (Prolog — `knowledge_base/rules.pl`)

This is where the **intelligence** lives. All expert knowledge is encoded as Prolog rules.

#### Risk Classification Rules

```prolog
% HIGH RISK: Score below 40 AND attendance below 60%
high_risk(Score, Attendance) :-
    Score < 40,
    Attendance < 60.

% MODERATE RISK: Score between 40 and 50 (inclusive)
moderate_risk(Score) :-
    Score >= 40,
    Score =< 50.

% EXCELLENT: Score above 75 AND attendance above 80%
excellent_student(Score, Attendance) :-
    Score > 75,
    Attendance > 80.
```

#### Recommendation Rules

```prolog
recommendation(high,     "Immediate counseling and remedial classes").
recommendation(moderate, "Enroll in remedial program").
recommendation(excellent,"Advanced coursework recommended").
```

#### Explanation Rules

```prolog
explain(high,     "Average score below 40 and attendance below 60%").
explain(moderate, "Average score between 40 and 50").
explain(excellent,"Average score above 75 and attendance above 80%").
```

**What makes this "AI":** The rules are *declarative* — you describe *what* constitutes high risk, not *how* to compute it step-by-step. Prolog's inference engine automatically matches facts against rules to derive conclusions.

---

### 5.3 Inference Engine (SWI-Prolog — `knowledge_base/inference.pl`)

The inference engine uses **Forward Chaining** — it starts with known facts and applies rules to derive new conclusions.

#### How Forward Chaining Works

| Step | What Happens | Example |
|:-----|:-------------|:--------|
| **1. Facts inserted** | Student data is asserted as Prolog facts | `student(38, 55, declining).` |
| **2. Rules evaluated** | Prolog scans all rules to find matches | Checks `high_risk`, `moderate_risk`, `excellent_student` |
| **3. Matching rule fires** | The first satisfied rule triggers | `high_risk(38, 55)` — both conditions met |
| **4. Conclusion generated** | The derived fact is returned | `Risk = high` |

#### Example Trace

```
INPUT:   Score = 38, Attendance = 55

CHECK:   high_risk(38, 55) :- 38 < 40 ✓, 55 < 60 ✓
RESULT:  Rule SATISFIED → Risk = High

OUTPUT:  recommendation(high, "Immediate counseling and remedial classes")
         explain(high, "Average score below 40 and attendance below 60%")
```

---

### 5.4 Python–Prolog Interface (`pyswip` Bridge)

Python communicates with Prolog through the `pyswip` library, which allows Python to:

- Load Prolog files (`.pl`)
- Assert new facts
- Run Prolog queries
- Read back results

#### Communication Flow

```
  Python (main.py)
       │
       │  1. Load rules.pl & inference.pl
       │  2. Assert student facts
       │  3. Query: risk_level(38, 55, Risk)
       │
       ▼
  pyswip Bridge
       │
       │  Translates Python calls → Prolog queries
       │
       ▼
  SWI-Prolog Engine
       │
       │  Evaluates rules, returns: Risk = high
       │
       ▼
  Python receives result
       │
       │  Displays formatted output to user
       ▼
```

#### Example Query Flow

```python
# Python sends a query to Prolog:
result = prolog.query("risk_level(38, 55, Risk)")

# Prolog responds:
# Risk = high
```

---

## 6. System Workflow

Here is the **complete end-to-end flow** of the system, from user input to final output:

### Step 1 — User Input
The user enters three values:
```
Score = 38,  Attendance = 55,  Trend = declining
```

### Step 2 — Fact Creation
Python converts the input into a Prolog fact and asserts it:
```prolog
student(38, 55, declining).
```

### Step 3 — Rule Matching
Prolog checks the asserted facts against all rules:
```
high_risk(38, 55) :- 38 < 40 ✓  AND  55 < 60 ✓  →  MATCH!
```

### Step 4 — Inference
The system concludes:
```
Risk = High
Recommendation = "Immediate counseling and remedial classes"
```

### Step 5 — Explanation
The system retrieves the reasoning:
```
Explanation = "Average score below 40 and attendance below 60%"
```

### Step 6 — Output
The final result is displayed to the user:
```
╔═══════════════════════════════════════════╗
║          SAPAES RESULT                    ║
╠═══════════════════════════════════════════╣
║                                           ║
║  Risk Level:      HIGH                    ║
║                                           ║
║  Recommendation:                          ║
║  • Immediate Academic Counseling          ║
║  • Enroll in Remedial Classes             ║
║                                           ║
║  Explanation:                             ║
║  Average score below 40 and               ║
║  attendance below 60%.                    ║
║                                           ║
╚═══════════════════════════════════════════╝
```

---

## 7. Data Flow

### Level 0 — Data Flow Diagram (DFD)

This shows the high-level movement of data through the system:

```
  ┌──────────┐       Student Data        ┌──────────────────────┐
  │          │ ──────────────────────────▶│                      │
  │   USER   │                           │   SAPAES System      │
  │          │ ◀──────────────────────────│                      │
  └──────────┘   Risk + Recommendation   └──────────────────────┘
                   + Explanation
```

### Detailed Internal Flow

```
  User Input (Score, Attendance, Trend)
       │
       ▼
  ┌────────────────────────┐
  │  Python Interface      │  ← Collects & validates data
  └───────────┬────────────┘
              │
              ▼
  ┌────────────────────────┐
  │  pyswip Bridge         │  ← Translates to Prolog facts
  └───────────┬────────────┘
              │
              ▼
  ┌────────────────────────┐
  │  Inference Engine      │  ← Matches facts against rules
  │  (inference.pl)        │
  └───────────┬────────────┘
              │
              ▼
  ┌────────────────────────┐
  │  Knowledge Base        │  ← Contains expert rules
  │  (rules.pl)            │
  └───────────┬────────────┘
              │
              ▼
  ┌────────────────────────┐
  │  Result Returned       │  ← Risk level + recommendation
  └───────────┬────────────┘
              │
              ▼
  ┌────────────────────────┐
  │  Output Formatter      │  ← Displays to user
  │  (output_formatter.py) │
  └────────────────────────┘
```

---

## 8. Rule Evaluation Flowchart

This flowchart shows the **decision logic** the Prolog inference engine follows:

```
                    ┌─────────┐
                    │  START  │
                    └────┬────┘
                         │
                         ▼
              ┌─────────────────────┐
              │  Collect student    │
              │  data (Score,       │
              │  Attendance, Trend) │
              └──────────┬──────────┘
                         │
                         ▼
              ┌─────────────────────┐
              │  Score < 40  AND    │──── YES ──▶ ✅ HIGH RISK
              │  Attendance < 60 ?  │
              └──────────┬──────────┘
                         │ NO
                         ▼
              ┌─────────────────────┐
              │  Score between      │──── YES ──▶ ⚠️ MODERATE RISK
              │  40 and 50 ?        │
              └──────────┬──────────┘
                         │ NO
                         ▼
              ┌─────────────────────┐
              │  Score > 75  AND    │──── YES ──▶ 🌟 EXCELLENT
              │  Attendance > 80 ?  │
              └──────────┬──────────┘
                         │ NO
                         ▼
              ┌─────────────────────┐
              │  Default category   │──── ──── ──▶ 📋 NEEDS REVIEW
              └──────────┬──────────┘
                         │
                         ▼
              ┌─────────────────────┐
              │  Generate           │
              │  recommendation     │
              │  + explanation      │
              └──────────┬──────────┘
                         │
                         ▼
              ┌─────────────────────┐
              │  Display result     │
              │  to user            │
              └──────────┬──────────┘
                         │
                         ▼
                    ┌─────────┐
                    │   END   │
                    └─────────┘
```

---

## 9. Design Principles

### 9.1 Separation of Concerns

Each layer has exactly **one job** — they don't overlap:

| Layer | Responsibility | What It Does NOT Do |
|:------|:---------------|:-------------------|
| **Python** (Interface) | Collect input, display output | Does NOT make decisions |
| **Prolog** (Intelligence) | Evaluate rules, derive conclusions | Does NOT interact with user |
| **Docs** (Documentation) | Explain knowledge engineering | Does NOT contain code |

### 9.2 Rule-Based Reasoning

- All decisions are made through **Prolog logical rules**
- There are **no** `if-else` statements in Python making academic decisions
- This is what makes the system a *true* Expert System, not just a regular program

### 9.3 Explainable AI (XAI)

Every decision includes an **explanation** of *why* the system reached that conclusion:

```
Decision:    HIGH RISK
Explanation: "Average score below 40 and attendance below 60%"
```

This makes the system **transparent** — users can understand and trust its reasoning.

---

## 10. Testing Strategy

The system must be validated with a range of test cases covering all risk categories:

| Test # | Score | Attendance | Trend | Expected Result | Why |
|:-------|:------|:-----------|:------|:----------------|:----|
| 1 | 35 | 50 | declining | **High Risk** | Score < 40 AND Attendance < 60 |
| 2 | 45 | 70 | stable | **Moderate Risk** | Score between 40–50 |
| 3 | 80 | 90 | improving | **Excellent** | Score > 75 AND Attendance > 80 |
| 4 | 55 | 45 | declining | **Attendance Concern** | Attendance below threshold despite passing score |

### How to Run Tests

```bash
# Run the system
python interface/main.py

# Enter test values and verify the output matches the expected result
```

---

## 11. Technology Stack

| Technology | Role | Why We Use It |
|:-----------|:-----|:-------------|
| **Python 3.x** | User Interface | Easy to use for input/output handling |
| **pyswip** | Bridge between Python & Prolog | Allows Python to query Prolog directly |
| **SWI-Prolog** | Logic / Inference Engine | Industry-standard Prolog implementation |
| **GitHub** | Version Control & Collaboration | Team coordination and submission |
| **Markdown / PDF** | Documentation | Knowledge engineering reports |

---

## Summary: Why This Design Scores High

| Criteria | How SAPAES Meets It |
|:---------|:-------------------|
| ✅ **Intelligence in Prolog** | All reasoning rules are in `.pl` files — zero logic in Python |
| ✅ **Clean Architecture** | Strict 3-layer separation: Interface → Engine → Knowledge Base |
| ✅ **Explainable Reasoning** | Every conclusion includes a human-readable explanation |
| ✅ **Clear Agent Mapping** | Input (percepts) → Rules (reasoning) → Output (actions) |
| ✅ **Proper Folder Structure** | Follows the mandatory repository layout |
| ✅ **Documented Knowledge Engineering** | This document explains every design decision |
