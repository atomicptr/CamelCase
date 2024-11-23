let green text = "\027[1;32m" ^ text ^ "\027[0m"
let red text = "\027[1;31m" ^ text ^ "\027[0m"
let bold text = "\027[1m" ^ text ^ "\027[0m"

let print_head ?(title = "") () =
  print_endline "";
  print_endline (bold (if title = "" then "=======> Test Case" else "=======> Test Case: " ^ title));
  print_endline ""

let indent string with_string =
  String.split_on_char '\n' string |> List.fold_left (fun acc s -> acc ^ "\n" ^ with_string ^ s) ""

(** Pretty print the test results *)
let print_test_results results =
  let print_result = function
    | name, TestResult.Success -> print_endline (bold "test" ^ " " ^ name ^ "... " ^ green "ok")
    | name, TestResult.Failure reason ->
        print_endline (bold "test" ^ " " ^ name ^ "... " ^ red "error");
        print_endline (red (indent reason "\t"))
  in
  let successes, failures =
    List.partition
      (function
        | _, TestResult.Success -> true
        | _, TestResult.Failure _ -> false)
      results
  in
  List.iter print_result successes;
  if List.length failures > 0 then List.iter print_result failures;
  print_endline "";
  Printf.printf "%d out of %d tests passed!\n" (List.length successes) (List.length results)
