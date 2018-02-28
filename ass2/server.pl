:- debug.
:-['doctor_core.pl'].
:-['human_print.pl'].
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_files)).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_error)).


%% rule for ststic files handler
:- multifile http:location/3.
:- dynamic   http:location/3.
http:location(files, '/img', []).
:- http_handler(files(.), http_reply_from_files('img', []), [prefix]).

%% rule for main handler
:- http_handler(/, index, []).

%% initiate the server
server(Port) :-
        http_server(http_dispatch, [port(Port)]).

%% reply the clint next question page.
replay_question_page:-
    % get Gesture
    gesture(Gesture),
    human_gesture(Gesture, Human_gesture),      % get Gesture
    opening(OP),                                % get Opening
    question_start(QS),                         % get question start
    nextQuestion(Question),
    human_symptom(Question, Human_question),    % get next question
    %% html defination
    %% the html form is equvalent to the following html

%% <form action="/answer" method="post">
    
%%      <input type="radio" id="yes"
%%      name="answer" value="yes">
%%     <label for="yes">Yes</label>

%%     <input type="radio" id="no"
%%      name="answer" value="no">
%%     <label for="yes">No</label>

%%   <button type="submit">Submit</button>
%% </form>
    reply_html_page(
       [title('Professional Talking Box Doctor')],
       [center([style='font-size: 36pt', title='tooltip text'],'Professional Talking Box Doctor'),
       center([
            img([src='img/doctor.jpg', width=128], []),br([]),
            '<   ',Human_gesture,'   >',br([]),
            OP,QS, Human_question,'?',
            br([]),
            form([action='/', method='post'],
                [
                input([type='hidden', name='question', value=Question],[]),
                input([type='radio', id='yes', name='answer', value='yes'],[]),
                label([for='yes'], ['yes']),
                input([type='radio', id='no', name='answer', value='no', checked],[]),
                label([for='no'], ['no']),
                button([type='submit'],['Submit'])
                ])
        ])]
        ).

%% reply the clint diagnos result page
replay_diagnos_page:-
    gesture(Gesture),
    human_gesture(Gesture, Human_gesture),  % get Gesture
    opening(OP),                            % get Opening
    diagnos(Result),
    human_diagnos(Result, Human_result),    % get diagnos Result
    %% html defination
    reply_html_page(
       [title('Professional Talking Box Doctor')],
       [center([style='font-size: 36pt', title='tooltip text'],'Professional Talking Box Doctor'),
       center([
            img([src='img/doctor.jpg', width=128], []),br([]),
            '<   ',Human_gesture,'   >',br([]),
            OP,'You might have ', Human_result,'.'
        ]),
       'To start over, please restart the server.']
        ).

% handlling answers, and return next question.
index(Request):-
    member(method(post), Request), !,
    http_read_data(Request, [question=Q, answer=A|_], []),
    answer(Q,A),
    (
        current_predicate(ready_to_diagnos/1) -> replay_diagnos_page;replay_question_page
    ).

% handlling the first request, following request will be handled by another rule of index/1
index(_Request) :-
    (current_predicate(ready_to_diagnos/1) -> replay_diagnos_page;replay_question_page).

% start the server
:- server(5000).
