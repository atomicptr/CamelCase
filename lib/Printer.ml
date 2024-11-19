let green text = "\027[1;32m" ^ text ^ "\027[0m"
let red text = "\027[1;31m" ^ text ^ "\027[0m"

(** Pretty print the test results *)
let print_test_results results =
  print_endline ("running " ^ (List.length results |> string_of_int) ^ " tests.");
  print_endline "";
  List.iter
    (function
      | name, TestResult.Success -> print_endline ("test " ^ name ^ "... " ^ green "ok")
      | name, TestResult.Failure reason ->
          print_endline ("test " ^ name ^ "... " ^ red "error");
          print_endline ("\t" ^ red "Reason: " ^ reason);
          print_endline "")
    results
