(** Returns a test case with a name *)
let test name f = (name, f)

(** Run all tests *)
let run ?(print_func = Printer.print_test_results) tests =
  let rec inner = function
    | [] -> []
    | (name, func) :: rest -> (
        let res = func () in
        match res with
        | TestResult.Success -> (name, res) :: inner rest
        (* abort on failure *)
        | TestResult.Failure _ -> [ (name, res) ])
  in
  inner tests |> print_func

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
