:-['utl.pl'].
pain.   % store selected pain, only one from library will be selected
mood.   % store selected mood, only one from library will be selected
ready_to_diagnos.   % flag setted when all questions are asked and answered
have_symptom(nothing).  % symptoms with positive answer, including symptoms, pain, and mood
answered(nothing).         % answered items, including symptoms, pain, and mood

%% Set of pains and moods
pain_library([unbearable_pain, lot_of_pain, manageable_pain, mild_pain, no_pain]).
mood_library([calm, angry, weepy, stressed, sad]).
%% Set of symptoms
symptom_library([temperature, sweat, ache, sneeze, cough, blood, chill, rash, headache]).
%% Set of gestures
gesture(polite_gesture, [look_concerned,mellow_voice,light_touch,faint_smile]).
gesture(calming_gesture, [greet, look_composed, look_attentive]).
gesture(normal_gesture, [broad_smile, joke, beaming_voice]).
%% Set of illness and its list of symptoms
illness(fever,  [temperature, sweat, ache, weepy, headache]).
illness(cold,   [sneeze, cough, temperature, chills, mild_pain]).
illness(cancer, [mild_pain, temperature, sweat, sneeze]).
illness(injury, [blood, lot_of_pain, weepy, angry, sweat]).
illness(food_poisoning, [temperature, rash, stressed, ache, sneeze]).

%% Select a random item from selected set of gesture
gesture(G):-
    (
        %% condition 1: havn't choose pain/mood, or no_pain or calm is selected
        %% Set GL to normal_gesture
        (not(current_predicate(pain/1)); not(current_predicate(mood/1)); 
            pain(no_pain); mood(calm)),
         gesture(normal_gesture, GL);
        %% condition 2: unbearable_pain, lot_of_pain or angry is selected
        %% Set GL to polite_gesture
        (pain(unbearable_pain); pain(lot_of_pain); mood(angry)), 
        gesture(polite_gesture, GL);
        %% condition 3: manageable_pain, mild_pain, weep or stressed is selected
        %% Set GL to calming_gesture
        (pain(manageable_pain); pain(mild_pain); mood(weepy); mood(stressed)),
        gesture(calming_gesture, GL)
    ),
    random_member(G, GL).   % get a random item from GL

%% determin thether all items form a library L have been answered. can be applied to pain_library, mood_library or symptom_library
list_finished(L, ValidChoices, If_finished):-
    findall(X, answered(X), History),
    list_to_set(L, P),
    list_to_set(History, S),
    subtract(P, S, ValidChoices),
    list_empty(ValidChoices, If_finished).

%% Following 3 rules are interface nextQuestion/1, query nextQuestion(Next) in prolog will return the next item to be asked.
%% Cut operator has been used.

%% ask symptom
nextQuestion(Next):-
    % pain and mood has finished, should ask Symptom
    pain_library(Pain_library),
    mood_library(Mood_library),
    symptom_library(Symptom_library),
    list_finished(Pain_library, _, If_pain_finished),   % determine Pain_library has all been answered 
    list_finished(Mood_library, _, If_mood_finished),   % determine Mood_library has all been answered 
    list_finished(Symptom_library, ValidChoices, _),    
    (
        (current_predicate(pain/1);If_pain_finished),   % if one of pain is selected or Pain_library is answered through
        (current_predicate(mood/1);If_mood_finished)    % if one of mood is selected or Mood_library is answered through
    ),!,
    random_member(Next, ValidChoices).

%% ask mood
nextQuestion(Next):-
    % pain has finished, should ask mood
    pain_library(Pain_library),
    mood_library(Mood_library),
    list_finished(Pain_library, _, If_pain_finished),   % determine Pain_library has all been answered 
    list_finished(Mood_library, ValidChoices, _),
    (
        current_predicate(pain/1); If_pain_finished     % if one of pain is selected or Pain_library is answered through
    ),!,
    random_member(Next, ValidChoices).

%% ask pain
nextQuestion(Next):-
    % pain have not been selected
    pain_library(Pain_library),
    list_finished(Pain_library, ValidChoices, _),!,     
    random_member(Next, ValidChoices).


%% helper function for positive answer of answer/2,  depending of answering a pain, mood or symptom, make different action
answer_h(Q):-
    pain_library(Pain_library),
    mood_library(Mood_library),
    symptom_library(Symptom_library),
    (
        member(Q, Pain_library)  -> assert(pain(Q));    % if Q is a pain
        member(Q, Mood_library)  -> assert(mood(Q));    % if Q is a mood
        member(Q, Symptom_library)->true                % otherwise Q is a symptom
    ),
    assert(have_symptom(Q)).                            % add Q to have_symptom

% Interface for answering question, eg. query answer(headache, yes) in prolog will tell the system you have headache
answer(Q, Answer):-
    assert(answered(Q)),
    (   
        Answer == yes -> answer_h(Q); true
    ),
    % check whether wvery thing has been answered, in other words whether ready to make diagnos
    symptom_library(Symptom_library),
    (
        list_finished(Symptom_library, _, If_symptom_finished),         % whether symptom finished
        (If_symptom_finished -> assert(ready_to_diagnos(true));true)
    ).

%% helper function for making diagnos, determin whether one illness is satisfied
diagnos_h(X):-
    findall(A, have_symptom(A), Symptom_list),
    illness(X, L), 
    is_subset(L,Symptom_list).

% Interface for making diagnos, collect all satisfied illnesses.
diagnos(L):-
    findall(A, diagnos_h(A), L).

