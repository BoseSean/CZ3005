# Talking Box

## Instruction

- Navigate to root directory of the projrct.
- To start the CLI version, run `swipl CLI.pl` or `['CLI.pl']` in Prolog.
- To start the GUI version, run `swipl server.pl` or `['server.pl']` in Prolog. Then, access http://localhost:5000 from any browser.

![image](report_img/ScreenShot1.png)
## Demo query in CLI

```Prolog
?- start.
<   broad smile   >
I will help you, but do you feel like manageable pain ?
(response with response(manageable_pain,yes). or response(manageable_pain,no). )
true.

?- response(manageable_pain,no).
<   broad smile   >
My friend, are you feeling unbearable pain ?
(response with response(unbearable_pain,yes). or response(unbearable_pain,no). )
true.

%%.....

```

See more in `CLI_log.txt`.

## Structure

- `doctor_core.pl`: the core knowledge and logic, including implementation of `nextQuestion/1`, `answer/2`, and `diagnose/1`, sets of pains, moods, and illnesses. 
- `human_print.pl`: humanize strings for output.
- `server.pl`: web server program, front-end
- `CLI.pl: CLI` program, front-end
- `util.pl`: utility functions used by different part, including `list_empty/2`
- `CLI_log.txt`: sample usage in CLI
