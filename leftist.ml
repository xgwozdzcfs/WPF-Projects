(************************************************)
(**********  Zadanie Drzewa Lewicowe. ***********)
(************************************************)
(********* Autor pracy: Grzegorz Gwóźdź *********)
(********* Code Reviewer:   **********)

type 'a queue = Puste | Wezel of 'a queue * 'a * 'a queue * int;;
(*Kolejka jako typ wariantowy - Pusta lub Wezel zlozony z lewego poddrzewa, wierzchołka, prawego poddrzewa i wysokości*)

(*Zdefiniowanie pustej kolejki*)
let empty = Puste;;

(*sprawdzenie czy kolejka jest pusta*)
let is_empty tree1 =
  match tree1 with
    Puste -> true |
    Wezel (_, _, _, _) -> false;;
 
exception Empty;; (*wyjątek*)

(*procedura pomocnicza do łączenia dwóch kolejek*)
let rec polacz tree1 tree2 =
    match tree1, tree2 with
    Puste, Puste -> empty |
    Wezel (_, _, _, _), Puste -> tree1 |
    Puste, Wezel (_, _, _, _) -> tree2 |
    Wezel (l1, w1, r1, h1), Wezel (l2, w2, r2, h2) -> 
        if w1 < w2 then let tree3 = polacz r1 tree2 in
            match tree3 with
            | Wezel (l3, w3, r3, h3) ->  
                (match l1 with
                | Puste -> Wezel (tree3, w1, empty, 0) 
                | Wezel (l11, w11, r11, h11) ->
                  if h11 <= h3 then Wezel(tree3, w1, l1, h11+1)
                  else  Wezel(l1, w1, tree3, h3+1))
            |Puste -> raise Empty  (*nigdy nie zajdzie, bo tree3 nigdy puste*)
        else let tree3 = polacz r2 tree1 in
            match tree3 with
            | Wezel (l3, w3, r3, h3) ->  
                (match l2 with
                | Puste -> Wezel (tree3, w2, empty, 0) 
                | Wezel (l11, w11, r11, h11) -> 
                  if h11 <= h3 then Wezel(tree3, w2, l2, h11+1)
                  else  Wezel(l2, w2, tree3, h3+1))
            | Puste -> raise Empty (*jak wyzej*);;
      
(*łączenie dwóch kolejek*)
let join q1 q2 = polacz q1 q2;;

(*kolejka składająca się z jednego elementu*)
let singletree e = Wezel (Puste, e, Puste, 0);;

(*wstawianie elementu do kolejki*)
let add e q = polacz (singletree e) q;;

(*usunięcie elementu minimalnego*)
let delete_min q = 
    match q with 
    | Puste -> raise Empty 
    | Wezel(l, e, r, h) -> (e, join l r);;


 (*******************************************)
 (*******************************************)
