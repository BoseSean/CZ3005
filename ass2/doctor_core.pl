:-['utl.pl'].
pain.
mood.
ready_to_diagnos.
have_symptom(nothing).
asked(nothing).

pain_library([unbearable_pain, lot_of_pain, manageable_pain, mild_pain, no_pain]).
mood_library([calm, angry, weepy, stressed]).

symptom_library([temperature, sweat, ache, sneeze, cough, blood]).

gesture(polite_gesture, [look_concerned,mellow_voice,light_touch,faint_smile]).
gesture(calming_gesture, [greet, look_composed, look_attentive]).
gesture(normal_gesture, [broad_smile, joke, beaming_voice]).

illness(fever,  [temperature, sweat, ache, weepy]).
illness(cold,   [sneeze, cough, temperature]).
illness(cancer, [mild_pain, temperature, sweat, sneeze]).
illness(injury, [blood, lot_of_pain, weepy, angry]).

gesture(G):-
    (
        (not(current_predicate(pain/1)); not(current_predicate(mood/1))),
         gesture(normal_gesture, GL);
        (pain(unbearable_pain); pain(lot_of_pain); mood(angry)), 
        gesture(polite_gesture, GL);
        (pain(manageable_pain); pain(mild_pain); mood(weepy); mood(stressed)),
        gesture(calming_gesture, GL)
    ),
    random_member(G, GL).

list_finished(L, ValidChoices, If_finished):-
    findall(X, asked(X), History),
    list_to_set(L, P),
    list_to_set(History, S),
    subtract(P, S, ValidChoices),
    list_empty(ValidChoices, If_finished).
    

%% ask symptom
nextQuestion(Next):-
    pain_library(Pain_library),
    mood_library(Mood_library),
    symptom_library(Symptom_library),
    list_finished(Pain_library, _, If_pain_finished),
    list_finished(Mood_library, _, If_mood_finished),
    list_finished(Symptom_library, ValidChoices, _),
    (
        (current_predicate(pain/1);If_pain_finished),
        (current_predicate(mood/1);If_mood_finished)
    ),!,
    random_member(Next, ValidChoices).

%% ask mood
nextQuestion(Next):-
    pain_library(Pain_library),
    mood_library(Mood_library),
    list_finished(Pain_library, _, If_pain_finished),
    list_finished(Mood_library, ValidChoices, _),
    (
        current_predicate(pain/1); If_pain_finished
    ),!,
    random_member(Next, ValidChoices).

%% ask pain
nextQuestion(Next):-
    pain_library(Pain_library),
    list_finished(Pain_library, ValidChoices, _),!,
    
    random_member(Next, ValidChoices).



answer_h(Q):-
    pain_library(Pain_library),
    mood_library(Mood_library),
    symptom_library(Symptom_library),
    (
        member(Q, Pain_library)  -> assert(pain(Q));
        member(Q, Mood_library)  -> assert(mood(Q));
        member(Q, Symptom_library)->true
    ),
    assert(have_symptom(Q)).

answer(Q, Answer):-
    assert(asked(Q)),
    (   
        Answer == yes -> answer_h(Q); true
    ),
    symptom_library(Symptom_library),
    (
        list_finished(Symptom_library, _, If_symptom_finished),
        (If_symptom_finished -> assert(ready_to_diagnos(true));true)
    )
    .


diagnos_h(X):-
    findall(A, have_symptom(A), Symptom_list),
    illness(X, L), 
    is_subset(L,Symptom_list).

diagnos(L):-
    findall(A, diagnos_h(A), L).

