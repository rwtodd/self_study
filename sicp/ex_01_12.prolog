% SICP 1.12 -- elements of pascal's triangle

pasc_elem(N,N,1) :- !.
pasc_elem(_,1,1) :- !.
pasc_elem(Row, Col, Elem) :-
  RowMin1 is Row - 1,
  ColMin1 is Col - 1,
  pasc_elem(RowMin1, ColMin1, Parent1),
  pasc_elem(RowMin1, Col,     Parent2),
  Elem is Parent1 + Parent2.

