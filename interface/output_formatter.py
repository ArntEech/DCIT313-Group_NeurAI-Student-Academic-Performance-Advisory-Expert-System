# Owns all terminal display logic for SAPAES.
# main.py passes raw Prolog results here -- no formatting lives outside this file.


def display_result(risk, advice, explanation):
    # Prolog returns risk atoms like 'attendance_concern' or 'high'.
    # Replace underscores and title-case it for human-readable display.
    risk_label = str(risk).replace("_", " ").title()

    print("\n" + "=" * 54)
    print("     STUDENT PERFORMANCE ADVISORY REPORT")
    print("=" * 54)
    print(f"  Risk Level  : {risk_label}")
    print(f"  Advice      : {advice}")
    print(f"  Reasoning   : {explanation}")

    
    print("=" * 54 + "\n")
