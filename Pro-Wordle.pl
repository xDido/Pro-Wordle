     build_kb:-
		write('Please enter a word and its category on separate lines:'),
		nl,
		read(X),
		X\=done,
		nl,
		read(Y),
		assert(word(X,Y)),
		build_kb.
    
    build_kb:-
		 write("Done building the database. "),nl,
		 X=done.
		 
		 
	correct_letters(X,Y,C):-
		atom_chars(X,F),atom_chars(Y,K),
			setof(W,(member(W,F),member(W,K)),C).
    
    correct_position(X,Y,C):-
			atom_chars(X,L),
			atom_chars(Y,W),
			correct_positions(L,W,C).

    correct_positions([H|T],[H2|T2],C):-  
        H=H2,write(H),C=[H|W],correct_positions(T,T2,W).
 
    correct_positions([H|T],[H2|T2],C):-
         H\=H2,correct_positions(T,T2,C).
		 correct_positions([],[],_,[]).

    
    is_category(X):-
        word(_,X).
    
    categories(L):-
         setof(C,X^word(X,C),L).
    available_length(L,C):-
         word(W,C),
         atom_length(W,L).
    
    pick_word(W,L,C):-
         word(W,C),atom_length(W,L).
    categorycheck:-
         write('Choose a category:'),
         read(X),
         \+ is_category(X),
         write('This category does not exist.'),
         categorycheck.
    
    categorycheck:-
        is_category(X),lengthcheck(X).
    
    lengthcheck(X):-write('Enter a length of your choice '),nl,
    read(L),available_length(L,X),pick_word(W,L,X),G is L+1 ,main(G,W).
    
     check_word(Z,W,G):-
        atom_chars(Z,T),
        length(T,L),
        atom_chars(W,T2),
        length(T2,Length),
        L = Length.
    check_word(Z,W,G):-
        atom_chars(Z,T),
        length(T,L),
        atom_chars(W,T2),
        length(T2,Length),
        L \= Length,
        write('The word is not composed of '),
        write(Length),
        write(' letters. Try again.'),nl,nl,
        main(G,W).
     main(0,_):-
        write(' You Lost!'),!.

    main(G,W):-
		 G>0,
		 G1 is G - 1 , nl,
		 write(' you have '),
		 write(G),
		 write(' guesses') ,nl,nl,
		 write('  Enter word with correct number of letters '),
		 read(Z),
		 check_word(Z,W,G),
		 atom_length(W,L),
		 atom_length(Z,P),
		 (L=P,(W=Z,write(' You Won! '));(write(' Correct letters '),
		 correct_letters(W,Z,X), 
		 nl,
		 write(X),
		 write(' Correct positon  '),
		 (correct_position(W,Z,K),nl);main(G1,W))).
     wordle:-
         build_kb,
         write('The available categories are :'),categories(C),
         write(C),
		 nl,
         categorycheck.