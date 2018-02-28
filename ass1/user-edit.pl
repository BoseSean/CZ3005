user-edit(File) :-
   name(File, FileString), 
   name('notepad.exe ', TextEditString), %% Edit this line for your favorite editor
   append(TextEditString, FileString, EDIT),
   name(E,EDIT),
   shell(E).
