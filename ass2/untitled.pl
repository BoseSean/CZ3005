

%% ask symptom
nextQuestion(Next):-
    current_predicate(pain/1),current_predicate(mood/1),!,
    findall(X, asked(X), History),
    symptom_library(Symptom_library),
    list_to_set(Symptom_library, P),
    list_to_set(History, S),
    subtract(P, S, ValidChoice),
    random_member(Next, ValidChoice).

%% ask mood
nextQuestion(Next):-
    current_predicate(pain/1),!,
    findall(X, asked(X), History),
    mood_library(Mood_library),
    list_to_set(Mood_library, P),
    list_to_set(History, S),
    subtract(P, S, ValidChoice),
    random_member(Next, ValidChoice).

%% ask pain
nextQuestion(Next):-
    !,
    findall(X, asked(X), History),
    pain_library(Pain_library),
    list_to_set(Pain_library, P),
    list_to_set(History, S),
    subtract(P, S, ValidChoice),
    random_member(Next, ValidChoice).

