module Reference = struct                          
  let (++) = List.append

  let rec split p t = match t with
    | [] -> ([], [])
    | h::t' ->
       let (l,r) = split p t' in
       if h < p
       then (h::l, r)
       else (l, h::r)

  let rec qs l = match l with
    | [] -> []
    | h::t ->
       let (l,r) = split h t in
       let ls = qs l in
       let rs = qs r in
       ls ++ [h] ++ rs
       
  let _ =
    let _ = qs [4;1;3;2;5] in
    ()
end

module WithHoles = struct

  type env = (string * value) list
  and hole = (string * env * hole_tm)
  and hole_tm =
    | QsAppendStep of value * value * value
                    
  (* value term in an environment *)
  and value =
    | Hole of hole
    | Num of int
    | List of int list
               
  let (++) = List.append

  let rec split p t = match t with
    | [] -> ([], [])
    | h::t' ->
       let (l,r) = split p t' in
       if h < p
       then (h::l, r)
       else (l, h::r)

       
  let rec qs nm l = match l with
    | [] -> List []
    | h::t ->
       let (l,r) = split h t in
       let ls = qs (nm^"-1") l in
       let rs = qs (nm^"-2") r in
       let env = [("l", List l);
                  ("r", List r);
                  ("ls", ls);
                  ("rs", rs) ] in
       let tm : hole_tm = QsAppendStep(ls, Num h, rs) in
       let v : value = Hole (nm, env, tm) in
       v

  let rec print_term t = match t with
    | QsAppendStep(v1, v2, v3) ->
       Printf.sprintf "%s ++ [%s] ++ %s"
         (print_value v1)
         (print_value v2)
         (print_value v3)
  and print_value v = match v with
    | Hole (nm, env, tm) ->
       Printf.sprintf "%s:{%s; %s}" nm (
           List.fold_left (fun rest (x,v) ->
               Printf.sprintf "%s=%s %s" x (print_value v) rest
             ) "" env         
         ) (print_term tm)      
    | Num n -> string_of_int n
    | List _ -> "[..]"

  let rec print_term_short t = match t with
    | QsAppendStep(v1, v2, v3) ->
       Printf.sprintf "%s ++ [%s] ++ %s"
         (print_value_short v1)
         (print_value_short v2)
         (print_value_short v3)
  and print_value_short v = match v with
    | Hole (nm, env, tm) ->
       Printf.sprintf "%s:{...; %s}" nm (print_term_short tm)
    | Num n -> string_of_int n
    | List _ -> "[..]"

  let _ =
    let res = qs "root" [4;1;3;2;5;0] in
    print_string "\n\nThe Hole-Env DAG, printed out (as a tree):\n";
    print_string ( print_value res );
    print_string "\n\nShort version: Just hole tree (no envs):\n";
    print_string ( print_value_short res );
    print_string "\n";
    ()
end
