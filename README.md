# Student Academic Performance Advisory Expert System (SAPAES)
### DCIT 313: Introduction to Artificial Intelligence | Group 36 [Team NeurAI]

## 📌 Project Overview
SAPAES is a symbolic Artificial Intelligence system designed to simulate the diagnostic and advisory capabilities of a human Academic Advisor. By applying **Forward Chaining Inference** over a curated **Knowledge Base**, the system analyzes student performance metrics (GPA, Attendance, Trends) to classify academic risk and provide tailored intervention strategies.

This project follows the architectural principles outlined in *Ertel’s Introduction to Artificial Intelligence*, maintaining a strict separation between the **Knowledge Base** (Prolog) and the **Inference Engine/Interface** (Python).

---

## 👥 The Team (Group 36)
| Name | Student ID | Role |
| :--- | :--- | :--- |
| **Arnold Kyei** | [22224833] | Project Manager (Integration & QA) |
| **Benedict Afortey** | [22142011] | System Designer & Research Specialist |
| **Philemon** | [22031374] | Knowledge Engineer (Rules Specialist) |
| **Francis Siripi** | [22065084] | Inference Engine Developer |
| **Amoako Kwadwo** | [22235985] | Fact Base & User Input Developer |
| **Ekow Tawiah** | [22044491] | Recommendation & Explanation Module |
| **Joana Mamre** | [22039896] | Testing & Validation Engineer |

---

## 🏗️ System Architecture
The system is built using a decoupled architecture:
1.  **Knowledge Base (`/knowledge_base/rules.pl`):** A declarative set of First-Order Logic rules representing academic expertise.
2.  **Inference Engine (`/knowledge_base/inference.pl`):** Uses Forward Chaining to derive new facts from user-provided perceptions.
3.  **Interface (`/interface`):** A Python-based bridge utilizing the `pyswip` library to facilitate interaction between the user and the symbolic logic.

---

## 🚀 Technical Setup
### Prerequisites
* **SWI-Prolog:** Ensure the SWI-Prolog binaries are installed on your system.
* **Python 3.x**

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/ArntEech/DCIT313-Group_NeurAI-Student-Academic-Performance-Advisory-Expert-System.git
  
2. Install dependencies:
```bash
pip install -r requirements.txt
```
3. Run the application:
```bash
python interface/main.py

```

## 🛠️ Contribution Guidelines (Semantic Commits)
To maintain a professional audit trail for grading, all members must use the following commit format:
[MODULE] Action: Description

**[KB]** - Knowledge Base / Prolog changes.

**[UI]** - Python interface / Logic bridging.

**[DOCS]** - Documentation and Research.

**[TEST]** - Validation and Bug fixes.

**[PM]** - Repository management.



## 📜 Acknowledgments
- Russell & Norvig, Artificial Intelligence: A Modern Approach (4th Ed).

- Wolfgang Ertel, Introduction to Artificial Intelligence (2nd Ed).

