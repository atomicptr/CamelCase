include TestRunner
include TestResult

module IntValue = Values.MakeComparableValue (Values.IntComparable)
(** Provides expect_* functions for integers *)

module StringValue = Values.MakeComparableValue (Values.StringComparable)
(** Provides expect_* functions for strings *)
