include TestRunner
include TestResult

module IntValue = Values.MakeComparableValue (Values.IntComparable)
(** Provides expect_* functions for integers *)

module StringValue = Values.MakeComparableValue (Values.StringComparable)
(** Provides expect_* functions for strings *)

module FloatValue = Values.MakeComparableValue (Values.FloatComparable)
(** Provides expect_* functions for floats *)

module CharValue = Values.MakeComparableValue (Values.CharComparable)
(** Provides expect_* functions for chars *)
