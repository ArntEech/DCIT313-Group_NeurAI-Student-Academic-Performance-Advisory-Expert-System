from pathlib import Path
from pyswip import Prolog
from input_handler import get_average_score, get_attendance, get_trend
from output_formatter import display_result


def main():
    print("Student Academic Performance Advisory Expert System")
    print("----------------------------------------------------")

    # Collect user input from the interface layer.
    # All validation is handled inside input_handler.py -- no logic lives here.
    avg_score = get_average_score()
    attendance = get_attendance()
    trend = get_trend()

    # Build an absolute path to inference.pl regardless of where Python is launched from.
    # inference.pl internally loads rules.pl, so this single consult boots the whole system.
    # Forward slashes are used because SWI-Prolog on Windows prefers them.
    kb_path = str(
        Path(__file__).parent.parent / "knowledge_base" / "inference.pl"
    ).replace("\\", "/")

    prolog = Prolog()
    prolog.consult(kb_path)

    # Clear any facts left from a previous run in the same session,
    # then assert fresh percepts into Prolog's Working Memory.
    # retractall/1 silently succeeds even if no facts exist -- safe to call unconditionally.
    prolog.retractall("average_score(_)")
    prolog.retractall("attendance(_)")
    prolog.retractall("trend(_)")

    prolog.assertz(f"average_score({avg_score})")
    prolog.assertz(f"attendance({attendance})")
    prolog.assertz(f"trend({trend})")

    # Single unified query to the Forward Chaining endpoint in inference.pl.
    # Risk, Advice, and Explanation are all resolved in one call because
    # Risk must be bound before recommendation/2 and explain/2 can fire.
    # Splitting this into separate queries would leave Risk unbound in the second call.
    results = list(prolog.query("evaluate_student(Risk, Advice, Explanation)"))

    # Python's only remaining job: pass the results to the display layer.
    if results:
        display_result(
            results[0]["Risk"],
            results[0]["Advice"],
            results[0]["Explanation"]
        )
    else:
        print("\n[ERROR] The inference engine could not determine a result.")
        print("Verify that score and attendance are within valid ranges (0-100).")


if __name__ == "__main__":
    main()