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
    | QsEmptyBaseCase
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
       
  let _ =
    let _ = qs "root" [4;1;3;2;5] in
    ()
end
