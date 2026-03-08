from pyswip import Prolog
from input_handler import get_average_score, get_attendance, get_trend


def main():

    print("Student Academic Performance Advisory Expert System")
    print("----------------------------------------------------")

    # Collect user input
    avg_score = get_average_score()
    attendance = get_attendance()
    trend = get_trend()

    # Initialize Prolog
    prolog = Prolog()

    # Load the knowledge base
    prolog.consult("../prolog/knowledge_base.pl")

    # Clear previous facts
    prolog.retractall("average_score(_)")
    prolog.retractall("attendance(_)")
    prolog.retractall("trend(_)")

    # Assert new facts into Prolog
    prolog.assertz(f"average_score({avg_score})")
    prolog.assertz(f"attendance({attendance})")
    prolog.assertz(f"trend({trend})")

    # Query the system
    risk = list(prolog.query("risk_level(Risk)"))
    recommendation = list(prolog.query("recommendation(Advice)"))

    # Display results
    print("\n--- System Result ---")

    if risk:
        print("Risk Level:", risk[0]["Risk"])
    else:
        print("Risk Level: Not determined")

    if recommendation:
        print("Recommendation:", recommendation[0]["Advice"])
    else:
        print("Recommendation: None available")


if __name__ == "__main__":
    main()