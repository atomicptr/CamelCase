open CamelCase

let () =
  run ~title:__FILE__
    [
      test "simple: expect true works" (fun () -> expect_true true);
      test "simple: expect false works" (fun () -> expect_false false);
      test "simple: chaining expects" (fun () -> expect_true true >> expect_true true >> expect_false false);
      test "expect_true returns failure with false" (fun () -> expect_failure @@ expect_true false);
      test "expect: 2 + 2 = 4" (fun () -> IntValue.expect_equals 4 (2 + 2));
      test "expect: 'Hello' != 'World'" (fun () -> StringValue.expect_not_equals "Hello" "World");
      test "expect failure: 2 + 2 = 5" (fun () -> expect_failure @@ IntValue.expect_equals 5 (2 + 2));
      test "expect Option is some" (fun () -> expect_some (Some 1337));
      test "expect Option is none" (fun () -> expect_none None);
      test "expect Result is ok" (fun () -> expect_ok (Ok 42));
      test "expect Result is error" (fun () -> expect_error (Error "Nope"));
      test "expect: 2 < 4" (fun () -> IntValue.expect_smaller 4 2);
      test "expect: 4 <= 4" (fun () -> IntValue.expect_smaller_or_equal 4 4);
      test "expect: 5 > 1" (fun () -> IntValue.expect_bigger 1 5);
      test "expect: 5 >= 5" (fun () -> IntValue.expect_bigger_or_equal 5 5);
      test "expect: expect_equals with input wrapped in Option" (fun () ->
          IntValue.expect_option_equals (2 + 2) (Some 4));
      test "expect: expect_not_equals with input wrapped in Option" (fun () ->
          IntValue.expect_option_not_equals (2 + 2) (Some 5));
      test "expect: expect_equals with input wrapped in Option but its none" (fun () ->
          expect_failure @@ IntValue.expect_option_equals 4 None);
      test "expect: expect_equals with input wrapped in Result" (fun () -> IntValue.expect_result_equals (2 + 2) (Ok 4));
      test "expect: expect_not_equals with input wrapped in Result" (fun () ->
          IntValue.expect_result_not_equals (2 + 2) (Ok 5));
      test "expect: expect_equals with input wrapped in Result but its Error" (fun () ->
          expect_failure @@ IntValue.expect_result_equals 4 (Error "Something went wrong"));
      test "expect: every assumption in a list to be true" (fun () ->
          expect_every
            (List.init 10 (fun i -> i)
            |> List.filter (fun i -> i mod 2 = 0)
            |> List.map (fun i -> expect_true (i mod 2 = 0))));
    ]
