# 📘 Knowledge Engineering Document (System Design & Logic)
**Project:** Student Academic Performance Advisory Expert System (SAPAES)
**Role:** System Designer & Research Specialist 

---

## 1. High-Level System Architecture
The system follows a strict 3-layer Expert System Architecture:
1. **Interface Layer (Python):** Collects percepts (user inputs) and displays actions.
2. **Inference Layer (Prolog - inference.pl):** The core engine that triggers Forward Chaining.
3. **Knowledge Base (Prolog - rules.pl):** The declarative IF-THEN rules and thresholds.

## 2. Mapping of Intelligent Agent Model
This project strictly maps to an AI Agent behavior model:
* **Percepts (Environment Inputs):** `average_score`, `attendance`, `performance_trend`
* **Reasoning (Brain):** Forward Chaining through MECE Prolog rules.
* **Actions (Outputs):** `risk_level`, `recommendation`, `explanation`

## 3. Repository System Structure
```text
DCIT313-Group_NeurAI-Student-Academic-Performance-Advisory-Expert-System
├── knowledge_base
│   ├── rules.pl          
│   └── inference.pl      
│
├── interface
│   ├── main.py           
│   └── input_handler.py  
│
├── docs
│   ├── knowledge_eng.md  
│   └── system_manual.pdf 
│
└── README.md
```

## 4. Component-Level Design

### 4.1 User Interface (Python)

Collects numerical and categorical data:

- `average_score` (Float: 0–100)
- `attendance` (Float: 0–100)

> **Constraint:** Python contains ZERO logic. It only collects facts and queries Prolog.

### 4.2 Knowledge Base (Prolog: `rules.pl`)

The domain logic uses **Mutually Exclusive and Collectively Exhaustive (MECE)** partitions.

**Predicate Format:** `risk_level(Score, Attendance, RiskResult)`

**The 6 Expert States:**

| State | Condition |
|---|---|
| **Excellent** | Score >= 75 AND Attendance >= 80 |
| **Good** | (50 < Score < 75 AND Attendance >= 50) OR (Score >= 75 AND 50 <= Attendance < 80) |
| **Moderate** | 40 <= Score <= 50 AND Attendance >= 50 |
| **Attendance Concern** | Score >= 40 AND Attendance < 50 |
| **Academic Concern** | Score < 40 AND Attendance >= 60 |
| **High Risk** | Score < 40 AND Attendance < 60 |

### 4.3 Inference Engine (Prolog: `inference.pl`)

- Applies **Forward Chaining**.
- Python asserts dynamic facts (e.g., `average_score(38).`, `attendance(55).`).
- `inference.pl` gathers these facts, passes them to `rules.pl` predicates.
- Generates a unified conclusion for Python to fetch.

### 4.4 Python–Prolog Interface (`pyswip`)

- Python → `pyswip` bridge → SWI-Prolog.
- Python queries a single endpoint (e.g., `evaluate_student(Risk, Advice, Explanation)`) rather than checking individual rules.

---

## 5. System Workflow (Data Flow)

1. **Perception:** User enters Score = 38, Attendance = 55.
2. **Fact Assertion:** Python dynamically asserts `average_score(38).` and `attendance(55).` into the Prolog environment.
3. **Rule Matching (Inference):** Prolog evaluates the MECE bounds. It finds that `38 < 40` AND `55 < 60`.
4. **Conclusion Generation:** Rule triggers `risk_level(..., high)`.
5. **Action Mapping:** System fetches the corresponding `recommendation(high, Advice)` and `explain(high, Reason)`.
6. **Output:** Python prints the formatted result to the terminal.

---

## 6. Testing Strategy & Validation Bounds

The Inference engine **MUST** pass these specific edge cases to prove the MECE logic is working:

| Test Case Profile | Score | Attendance | Expected Risk Level | Expected Action |
|---|---|---|---|---|
| The Perfect Student | 85 | 90 | `excellent` | Advanced coursework |
| The Average Attender | 65 | 75 | `good` | Keep up good work / Peer tutoring |
| The Borderline | 45 | 55 | `moderate` | Remedial program |
| The Truant Genius | 80 | 30 | `attendance_concern` | Parent-teacher meeting |
| The Struggling Attender | 35 | 85 | `academic_concern` | Mandatory tutoring |
| The Complete Failure | 20 | 10 | `high` | Immediate counseling |

---

## 7. Key Design Principles 

- **Separation of Concerns:** Intelligence is strictly sandboxed in `.pl` files. Python acts solely as the IO (Input/Output) layer.
- **Explainable AI (XAI):** Every output includes an `explain/2` predicate string, satisfying the "Transparent Reasoning" requirement of the rubric.
- **Deterministic Logic:** By using MECE bounds, the Prolog engine resolves in $O(N)$ time without backtracking conflicts.