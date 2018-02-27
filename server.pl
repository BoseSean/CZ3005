:- debug.
:-['doctor_core.pl'].
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_files)).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_error)).

:- multifile http:location/3.
:- dynamic   http:location/3.

http:location(files, '/img', []).

:- http_handler(files(.), http_reply_from_files('img', []), [prefix]).
:- http_handler(/, index, []).

server(Port) :-
        http_server(http_dispatch, [port(Port)]).

replay_question_page:-
    nextQuestion(Question),
    reply_html_page(
       [title('Professional Talking Box Doctor')],
       [center([style='font-size: 36pt', title='tooltip text'],'Professional Talking Box Doctor'),
       center([
            img([src='img/doctor.jpg', width=128], []),br([]),
            'Are you ', Question,
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

replay_diagnos_page:-
    diagnos(Result),
    atomic_list_concat(Result, ',', ResultString),
    reply_html_page(
       [title('Professional Talking Box Doctor')],
       [center([style='font-size: 36pt', title='tooltip text'],'Professional Talking Box Doctor'),
       center([
            img([src='img/doctor.jpg', width=128], []),br([]),
            'You might have ', ResultString,'.'
        ])]
        ).

index(Request):-
    member(method(post), Request), !,
    http_read_data(Request, [question=Q, answer=A|_], []),
    answer(Q,A),
    (
        current_predicate(ready_to_diagnos/1) -> replay_diagnos_page;replay_question_page
    ).

index(_Request) :-
    (current_predicate(ready_to_diagnos/1) -> replay_diagnos_page;replay_question_page).

:- server(5000).

%% <form action="/answer" method="post">
    
%%      <input type="radio" id="yes"
%%      name="answer" value="yes">
%%     <label for="yes">Yes</label>

%%     <input type="radio" id="no"
%%      name="answer" value="no">
%%     <label for="yes">No</label>

%%   <button type="submit">Submit</button>
%% </form>