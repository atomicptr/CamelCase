module type ComparableValue = sig
  type t

  val compare : t -> t -> int
  val to_string : t -> string
end

module IntComparable : ComparableValue with type t = int = struct
  type t = int

  let compare = compare
  let to_string = string_of_int
end

module StringComparable : ComparableValue with type t = string = struct
  type t = string

  let compare = compare
  let to_string s = s
end

module FloatComparable : ComparableValue with type t = float = struct
  type t = float

  let compare = compare
  let to_string = string_of_float
end

module CharComparable : ComparableValue with type t = char = struct
  type t = char

  let compare = compare
  let to_string = String.make 1
end

let check_result check error_msg = if check then TestResult.Success else TestResult.Failure error_msg

module MakeComparableValue (T : ComparableValue) = struct
  (** Asserts that two values for the given type are equal *)
  let expect_equals expected input =
    check_result (T.compare input expected = 0) ("expected: " ^ T.to_string input ^ " to be: " ^ T.to_string expected)

  (** Asserts that the option input has a value and that these two values for the given type are equal *)
  let expect_option_equals expected input =
    match input with
    | Some input -> expect_equals expected input
    | None -> TestResult.Failure ("expected: None to be: " ^ T.to_string expected)

  (** Asserts that the result input has a value and that these two values for the given type are equal *)
  let expect_result_equals expected input =
    match input with
    | Ok input -> expect_equals expected input
    | Error _ -> TestResult.Failure ("expected: Error (...) to be: " ^ T.to_string expected)

  (** Asserts that two values aren't equal *)
  let expect_not_equals expected input =
    check_result (T.compare input expected != 0) ("expected: " ^ T.to_string input ^ " to be: " ^ T.to_string expected)

  (** Asserts that the option input has a value and that these two values for the given type are equal *)
  let expect_option_not_equals expected input =
    match input with
    | Some input -> expect_not_equals expected input
    | None -> TestResult.Failure ("expected: None to be: " ^ T.to_string expected)

  (** Asserts that the option input has a value and that these two values for the given type are equal *)
  let expect_result_not_equals expected input =
    match input with
    | Ok input -> expect_not_equals expected input
    | Error _ -> TestResult.Failure ("expected: Error (...) to be: " ^ T.to_string expected)

  (** Asserts that expected input to be smaller than expected *)
  let expect_smaller expected input =
    check_result
      (T.compare input expected < 0)
      ("expected: " ^ T.to_string input ^ " to be smaller than " ^ T.to_string expected)

  (** Asserts that expected input to be smaller than expected or the same *)
  let expect_smaller_or_equal expected input =
    check_result
      (T.compare input expected <= 0)
      ("expected: " ^ T.to_string input ^ " to be smaller or equal than " ^ T.to_string expected)

  (** Asserts that expected input to be bigger than expected *)
  let expect_bigger expected input =
    check_result
      (T.compare input expected > 0)
      ("expected: " ^ T.to_string input ^ " to be bigger than " ^ T.to_string expected)

  (** Asserts that expected input to be bigger than expected or the same *)
  let expect_bigger_or_equal expected input =
    check_result
      (T.compare input expected >= 0)
      ("expected: " ^ T.to_string input ^ " to be bigger or equal than " ^ T.to_string expected)
end
