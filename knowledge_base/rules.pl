% SAPAES KNOWLEDGE BASE: PRACTICAL RULES

%RISK CLASSIFICATION RULES
% Evaluates student states based on comprehensive score and attendance grids.

% Excellent: High score and high attendance
risk_level(Score, Attendance, excellent) :-
    Score >= 75,
    Attendance >= 80.

% Good: Passing score and acceptable attendance (but missing the Excellent threshold)
risk_level(Score, Attendance, good) :-
    Score > 50, Score < 75, Attendance >= 50.
risk_level(Score, Attendance, good) :-
    Score >= 75, Attendance >= 50, Attendance < 80.

% Moderate: Borderline score with acceptable attendance
risk_level(Score, Attendance, moderate) :-
    Score >= 40, Score =< 50, Attendance >= 50.

% Attendance Concern: Passing or moderate score, but terrible attendance
risk_level(Score, Attendance, attendance_concern) :-
    Score >= 40, Attendance < 50.

% Academic Concern: Failing score despite good attendance (trying, but failing)
risk_level(Score, Attendance, academic_concern) :-
    Score < 40, Attendance >= 60.

% High Risk: Failing score AND poor attendance (not trying, and failing)
risk_level(Score, Attendance, high) :-
    Score < 40, Attendance < 60.


%RECOMMENDATION RULES
% Maps specific states to practical intervention strings

recommendation(excellent, "Advanced coursework or Honors program recommended").
recommendation(good, "Keep up the good work. Consider peer tutoring to reach Excellent").
recommendation(moderate, "Enroll in remedial program and review study habits").
recommendation(attendance_concern, "Parent-Teacher Meeting Required to address absenteeism").
recommendation(academic_concern, "Mandatory academic tutoring. Attendance is good, but comprehension is lacking").
recommendation(high, "Immediate academic counseling, remedial classes, and parent meeting").


%EXPLANATION RULES
% Provides reasoning for Explainable AI requirement

explain(excellent, "Score is 75 or above, and attendance is 80% or above").
explain(good, "Score is above 50 with acceptable attendance, but does not meet Excellent criteria").
explain(moderate, "Score is between 40 and 50 with at least 50% attendance").
explain(attendance_concern, "Score is passing or borderline, but attendance is below 50%").
explain(academic_concern, "Attendance is 60% or better, but average score is below 40").
explain(high, "Score is below 40 and attendance is below 60%").