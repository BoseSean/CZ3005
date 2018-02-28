:-['doctor_core.pl'].

%% mapping atoms in libraries to human string.
human_symptom(unbearable_pain   ,'unbearable pain ').
human_symptom(lot_of_pain       ,'lot of pain ').
human_symptom(manageable_pain   ,'manageable pain ').
human_symptom(mild_pain         ,'mild pain ').
human_symptom(no_pain           ,'not pain ').

human_symptom(calm              ,'calm ').
human_symptom(angry             ,'angry ').
human_symptom(weepy             ,'weepy ').
human_symptom(stressed          ,'stressed ').
human_symptom(sad               ,'sad ').

human_symptom(temperature       ,'temperature ').
human_symptom(sweat             ,'sweat ').
human_symptom(ache              ,'ache ').
human_symptom(sneeze            ,'sneeze ').
human_symptom(cough             ,'cough ').
human_symptom(blood             ,'blood ').
human_symptom(chill             ,'chill ').
human_symptom(rash              ,'rash ').
human_symptom(headache          ,'headache ').

human_illness(fever             ,'fever').
human_illness(cold              ,'cold').
human_illness(injury            ,'injury').
human_illness(cancer            ,'cancer').
human_illness(no_illness        ,'no illness').
human_illness(food_poisoning    ,'food poisoning').

human_gesture(look_concerned   ,'look concerned').
human_gesture(mellow_voice     ,'mellow voice').
human_gesture(light_touch      ,'light touch').
human_gesture(faint_smile      ,'faint smile').
human_gesture(greet            ,'greet').
human_gesture(look_composed    ,'look composed').
human_gesture(look_attentive   ,'look attentive').
human_gesture(broad_smile      ,'broad smile').
human_gesture(joke             ,'joke').
human_gesture(beaming_voice    ,'beaming voice').

% greeting part of a interrogative sentence
openings('Well, ').
openings('My friend, ').
openings('My dear friend, ').
openings('My favorite patient, ').
openings('No worries, but ').
openings('I will help you, but ').
openings('Take your time, but ').
% get a random one from openings
opening(OP):-
    findall(A, openings(A), OpeningsList),
    random_member(OP, OpeningsList).

% asking part of a interrogative sentence
question_starts('are you feeling ').
question_starts('do you feel like ').
question_start(QS):-
    findall(A, question_starts(A), Question_startsList),
    random_member(QS, Question_startsList).

% map diagnos result list to human string
human_diagnos(L, H):-
    length(L, Len),
    (
        Len==0 -> human_illness(no_illness,H);
        (
            convlist([X,Y]>>human_illness(X,Y), L, HL),
            atomic_list_concat(HL, ',', H)
        )
    ).





