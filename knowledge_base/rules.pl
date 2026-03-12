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


explain(excellent,
"You are doing very well. Your score is 75 or higher and your attendance is also very strong. This shows that you understand the material and participate consistently in class.").

explain(good,
"You are performing well overall. Your score is above 50 and your attendance is acceptable, but there is still room to improve and reach an excellent level.").

explain(moderate,
"Your performance is around the borderline level. Your score is between 40 and 50 and your attendance is at least 50%. With a bit more effort and study time, you could improve your results.").

explain(attendance_concern,
"Your score is around the passing level, but your attendance is very low. Missing many classes can make it harder to understand the material and keep up with the course.").

explain(academic_concern,
"You are attending classes regularly, but your score is still below 40. This may mean you are finding the course difficult and may need extra help or more study time.").

explain(high,
"Your score is below 40 and your attendance is also low. This puts you at high academic risk and it is important to take action quickly to improve both attendance and performance.").