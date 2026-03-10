% ============================================================
% SAPAES INFERENCE ENGINE (inference.pl)
% Role: Forward Chaining bridge between Python's Working Memory
%       and the declarative Knowledge Base (rules.pl).
%
% Data Flow:
%   Python (assertz facts)
%     --> inference.pl reads Working Memory
%     --> fires matching rule in rules.pl (Unification + Guard checks)
%     --> chains conclusion to recommendation and explanation
%     --> Python queries evaluate_student/3 to collect all outputs
% ============================================================


% --- SECTION 1: PROLOG FLAG ---
% SWI-Prolog v7+ treats "double-quoted text" as string objects by default.
% pyswip cannot cleanly return these to Python -- it needs atoms.
% This flag forces "text" to be treated as a simple atom everywhere,
% making recommendation/2 and explain/2 strings readable in Python.
:- set_prolog_flag(double_quotes, atom).


% --- SECTION 2: LOAD KNOWLEDGE BASE ---
% Loads all risk_level/3, recommendation/2, and explain/2 clauses.
% The path resolves relative to THIS file's own directory (knowledge_base/).
% inference.pl therefore owns the loading -- main.py only needs to consult
% this single file to bring the entire system online.
:- consult('rules.pl').


% --- SECTION 3: DYNAMIC DECLARATIONS ---
% These three predicates have NO clauses at load time.
% Python will inject them at runtime via prolog.assertz().
% :- dynamic is a compile-time promise to SWI-Prolog:
%   "Don't raise an unknown procedure error -- clauses are coming."
% Without this, the first call to average_score(Score) in the rule
% body would throw an existence_error and the entire query would fail.
:- dynamic average_score/1.
:- dynamic attendance/1.
:- dynamic trend/1.     % Declared for Python compatibility; reserved for future rules.


% --- SECTION 4: THE FORWARD CHAINING ENDPOINT ---
% This is the single predicate Python queries via pyswip.
% It encodes the complete Forward Chaining inference cycle:
%
%  STEP 1 -- PERCEIVE: Read percepts from Working Memory.
%    Prolog's Unification binds Score and Attendance to the values
%    Python asserted (e.g., average_score(38) --> Score = 38).
%    No loops, no lookups -- Unification IS the retrieval mechanism.
%
%  STEP 2 -- MATCH & FIRE: Pass bound values into rules.pl.
%    Prolog scans each risk_level/3 clause top-to-bottom.
%    It tries to unify (Score, Attendance, Risk) with each clause head,
%    then evaluates the numeric guards (e.g., Score < 40, Attendance < 60).
%    The MECE rule design in rules.pl guarantees exactly ONE clause fires.
%    Risk is now a bound atom, e.g., Risk = high.
%
%  STEP 3 -- CHAIN CONCLUSIONS: Use derived Risk to fetch action strings.
%    recommendation/2 and explain/2 are simple Prolog facts -- lookup is
%    instantaneous via Unification on the now-bound Risk atom.
%    This chaining of one derived fact into the next goal IS Forward Chaining.
%
%  RESULT: Python receives Risk, Advice, and Explanation in one query call.

evaluate_student(Risk, Advice, Explanation) :-
    average_score(Score),                   % STEP 1a: Read Score from Working Memory
    attendance(Attendance),                 % STEP 1b: Read Attendance from Working Memory
    risk_level(Score, Attendance, Risk),    % STEP 2:  Match guards -> fire rule -> bind Risk
    recommendation(Risk, Advice),           % STEP 3a: Chain Risk -> derive Advice string
    explain(Risk, Explanation).             % STEP 3b: Chain Risk -> derive Explanation (XAI)

