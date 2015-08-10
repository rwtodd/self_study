good_enough(A,B) :- 
  abs( (A-B)/A ) < 0.0001.

cube_root_iter(Num,Guess,Root) :-
  Guess2 is (Num/(Guess*Guess) + 2*Guess)/3,
  (good_enough(Guess,Guess2) -> Root = Guess2 
                             ;  cube_root_iter(Num,Guess2,Root)).

cube_root(Num,Root) :- 
  Guess is Num / 10,
  cube_root_iter(Num, Guess, Root).
