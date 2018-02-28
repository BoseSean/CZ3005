:-['doctor_core.pl'].
:-['human_print.pl'].

replay_question:-
    % get Gesture
    gesture(Gesture),
    human_gesture(Gesture, Human_gesture),      % get Gesture
    opening(OP),                                % get Opening
    question_start(QS),                         % get question start
    nextQuestion(Question),
    human_symptom(Question, Human_question),    % get next question
    write('<   '),write(Human_gesture),write('   >'),nl,
    write(OP),write(QS), write(Human_question),write('?'),nl,write('(response with response('), write(Question),write(',yes). or '),
    write('response('), write(Question),write(',no). )'),!.

%% reply the clint diagnos result page
replay_diagnos:-
    gesture(Gesture),
    human_gesture(Gesture, Human_gesture),  % get Gesture
    opening(OP),                            % get Opening
    diagnos(Result),
    human_diagnos(Result, Human_result),    % get diagnos Result
    write('<   '),write(Human_gesture),write('   >'),nl,
    write(OP),write('you might have '), write(Human_result),write('.'),!.

start:-
    (current_predicate(ready_to_diagnos/1) -> replay_diagnos;replay_question).

response(Q, A):-
    answer(Q,A),
    (
        current_predicate(ready_to_diagnos/1) -> replay_diagnos;replay_question
    ).
