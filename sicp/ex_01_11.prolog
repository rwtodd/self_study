% SICP ex 1.11 .. recursive version

f(X,X) :- X < 3, !.
f(X,Ans) :- 
  Xm1 is X - 1,
  Xm2 is X - 2,
  Xm3 is X - 3,
  f(Xm1,A1),
  f(Xm2,A2),
  f(Xm3,A3),
  Ans is A1 + 2*A2 + 3*A3.


% SICP ex 1.11 .. iterative version

f2_iter(X,Cur,prev(A1,A2,A3),Ans) :-
  Cur =< X, !,
  Cur1 is Cur + 1,
  A0 is A1 + 2*A2 + 3*A3,
  f2_iter(X,Cur1,prev(A0,A1,A2),Ans).
f2_iter(X,Cur,prev(A1,_,_),A1) :-
  Cur is X + 1, !.
  
f2(X,X) :- X < 3, !.
f2(X,Ans) :- f2_iter(X,3,prev(2,1,0),Ans).
