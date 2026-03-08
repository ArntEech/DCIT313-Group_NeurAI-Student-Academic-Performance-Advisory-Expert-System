# Handles all user input and validation

def get_average_score():
    while True:
        try:
            score = float(input("Enter student's average score: "))
            if score < 0 or score > 100:
                print("Score must be between 0 and 100.")
            else:
                return score
        except ValueError:
            print("Invalid input. Please enter a number.")


def get_attendance():
    while True:
        try:
            attendance = float(input("Enter attendance percentage: "))
            if attendance < 0 or attendance > 100:
                print("Attendance must be between 0 and 100.")
            else:
                return attendance
        except ValueError:
            print("Invalid input. Please enter a number.")


def get_trend():
    while True:

        print("\nSelect Performance Trend:")
        print("1. Improving")
        print("2. Declining")
        print("3. Stable")

        choice = input("Enter option (1-3): ")

        if choice == "1":
            return "improving"

        elif choice == "2":
            return "declining"

        elif choice == "3":
            return "stable"

        else:
            print("Invalid selection. Please choose 1, 2, or 3.")