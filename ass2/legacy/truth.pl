%% :-dynamic pain([nothin]).
%% :-dynamic temperature(false).

%% init :- setval(counter, 0).
%% increment :- incval(counter).
%% get_counter(V) :- getval(counter, V).
pain.
mood.
have_symptom.

human_print(S):- 
    S==unbearable_pain  ->  write('unbearable pain ');
    S==lot_of_pain      ->  write('lot of pain ');
    S==manageable_pain  ->  write('manageable pain ');
    S==mild_pain        ->  write('mild pain ');
    S==no_pain          ->  write('not pain ');
    S==calm             ->  write('calm ');
    S==angry            ->  write('angry ');
    S==weepy            ->  write('weepy ');
    S==stressed         ->  write('stressed ');
    S==temperature      ->  write('temperature ');
    S==sweat            ->  write('sweat ');
    S==ache             ->  write('ache ');
    S==sneeze           ->  write('sneeze ');
    S==cough            ->  write('cough ');
    S==blood            ->  write('blood ').

openings('Well, ').
openings('My friend, ').
openings('My dear friend, ').
openings('My favorite patient, ').
openings('No worries, but ').
openings('I will save you, but ').
openings('Take your time, but ').
opening:-
    findall(A, openings(A), OpeningsList),
    random_member(X, OpeningsList),
    write(X).

question_starts('are you feeling ').
question_starts('do you feel like ').
question_start:-
    findall(A, question_starts(A), Question_startsList),
    random_member(X, Question_startsList),
    write(X).


pain_library([unbearable_pain, lot_of_pain, manageable_pain, mild_pain, no_pain]).
mood_library([calm, angry, weepy, stressed]).

symptom_library([temperature, sweat, ache, sneeze, cough, blood]).

%% polite_gesture([look_concerned,mellow_voice,light_touch,faint_smile]).
%% calming_gesture([greet, look_composed, look_attentive]).
%% normal_gesture([broad_smile, joke, beaming_voice]).


illness(fever,  [temperature, sweat, ache, weepy]).
illness(cold,   [sneeze, cough, temperature]).
illness(injury, [blood, lot_of_pain, weepy, angry]).

ask_pain:-
    pain_library(Pain_library), member(Pain, Pain_library), 
        write('Are you feeling '), human_print(Pain), write('? (y./n.) '),nl, read(C),
        C==y -> (
            assert(pain(Pain)),
            assert(have_symptom(Pain))
                ).
ask_mood:-
    mood_library(Mood_library), member(Mood, Mood_library), 
        write('Are you feeling '), human_print(Mood), write('? (y./n.) '),nl, read(C), 
        (
        C==y -> (
            assert(mood(Mood)),
            assert(have_symptom(Mood))
                )
        ).

ask_symptom_h(X):-
    opening, question_start, human_print(X), write('? (y./n.) '),nl , read(C), 
        (
        C==y -> assert(have_symptom(X));
        true
        ).

foreach_ask([]).
foreach_ask([H|T]):- ask_symptom_h(H), foreach_ask(T).

ask_symptom:-
    symptom_library(Symptom_library),
    random_permutation(Symptom_library, Shuffled_symptom_library),
    foreach_ask(Shuffled_symptom_library).

is_subset([], L).
is_subset([H|T], L):-
    member(H,L), is_subset(T,L).

diagnos_h(X):-
    findall(A, have_symptom(A), Symptom_list),
    illness(X, L), 
    is_subset(L,Symptom_list).

diagnos(L):-
    findall(A, diagnos_h(A), L).
