# CamelCase

A simple OCaml test framework

## Install

```scheme
(package
    (name my_package)
    (depends CamelCase))

; The package is not available on OPAM yet:
(pin (package (name CamelCase)) (url "git+https://github.com/atomicptr/CamelCase"))
```

## Usage

```ocaml
open CamelCase

let safeDiv a = function
  | 0 -> None
  | b -> a / b

let () = run [
        test "test if 2 + 2 = 4" (fun () -> IntValue.expect_equals 4 (2 + 2));
        test "test safeDiv: 2 / 0 = None" (fun () -> expect_none (safeDiv 2 0);
        test "test safeDiv: several cases" (fun () ->
            expect_some (safeDiv 10 2) >>
            IntValue.expect_equals 5 (10 / 2) >>
            expect_some (safeDiv 5 1) >>
            IntValue.expect_equals 1 (5 / 1));
    ]
```

## License

MIT
