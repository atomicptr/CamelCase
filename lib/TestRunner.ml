(** Returns a test case with a name *)
let test name f = (name, f)

(** Run all tests and terminate the program with exit code 0 if all tests were successful or 1 if they weren't *)
let run ?(title = "") ?(success_func = (fun () -> exit 0)) ?(failure_func = (fun () -> exit 1)) tests =
  Printer.print_head ~title ();
  let rec inner = function
    | [] -> []
    | (name, func) :: rest ->
        let res = func () in
        (name, res) :: inner rest
  in
  let results = inner tests in
  Printer.print_test_results results;
  match
    List.find_opt
      (function
        | _, TestResult.Failure _ -> true
        | _, _ -> false)
      results
  with
  | Some _ -> failure_func ()
  | None -> success_func ()

(** Expect TestResult to Fail *)
let expect_failure = function
  | TestResult.Success -> TestResult.Failure "expected failure got success"
  | TestResult.Failure _ -> TestResult.Success

(** Expect input to be true *)
let expect_true input = if input then TestResult.Success else TestResult.Failure "expected true, but got false"

(** Expect input to be false *)
let expect_false input = if input then TestResult.Failure "expected false, but got true" else TestResult.Success

(** Expect option input to have some value *)
let expect_some input =
  if Option.is_some input then TestResult.Success else TestResult.Failure "expected Some(...), but got: None"

(** Expect option input to have no value *)
let expect_none input =
  if Option.is_none input then TestResult.Success else TestResult.Failure "expected None, but got: Some(...)"

(** Expect result input to be OK *)
let expect_ok input =
  if Result.is_ok input then TestResult.Success else TestResult.Failure "expected Ok(...), but got: Error(...)"

(** Expect result input to be an error *)
let expect_error input =
  if Result.is_error input then TestResult.Success else TestResult.Failure "expected Error(...), but got: Ok(...)"

(** Chain multiple test results *)
let ( >> ) a b =
  match a with
  | TestResult.Success -> b
  | TestResult.Failure _ -> a

(** Evaluate a list of results *)
let expect_every = List.fold_left (fun acc res -> acc >> res) TestResult.Success
