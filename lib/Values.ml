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

module MakeComparableValue (T : ComparableValue) = struct
  (** Asserts that two values for the given type are equal *)
  let expect_equals expected input =
    if T.compare expected input = 0 then TestResult.Success
    else TestResult.Failure ("expected: " ^ T.to_string input ^ " to be: " ^ T.to_string expected)
end
