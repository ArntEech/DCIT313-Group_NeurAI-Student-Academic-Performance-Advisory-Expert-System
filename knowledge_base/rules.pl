% SAPAES KNOWLEDGE BASE: RULES

%--- 1. RISK CLASSIFICATION RULES ---
% Evaluates student states based on score and attendance

risk_level(Score, Attendance, high) :- 
    Score < 40, 
    Attendance < 60.

risk_level(Score, _Attendance, moderate) :- 
    Score >= 40, 
    Score =< 50.

risk_level(Score, Attendance, excellent) :- 
    Score > 75, 
    Attendance > 80.

% Rule to handle the 'Attendance Concern' test case scenario
risk_level(Score, Attendance, attendance_concern) :-
    Score > 50,
    Attendance < 50.


% --- 2. RECOMMENDATION RULES ---
% Maps specific states to intervention strings

recommendation(high, "Immediate counseling and remedial classes").
recommendation(moderate, "Enroll in remedial program").
recommendation(excellent, "Advanced coursework recommended").
recommendation(attendance_concern, "Parent-Teacher Meeting Required").


% --- 3. EXPLANATION RULES ---
% Provides reasoning for Explainable AI requirement

explain(high, "Average score below 40 and attendance below 60%").
explain(moderate, "Average score between 40 and 50").
explain(excellent, "Average score above 75 and attendance above 80%").
explain(attendance_concern, "Attendance below threshold despite passing score").