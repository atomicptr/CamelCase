(lang dune 3.17)

(name CamelCase)

(generate_opam_files true)

(source
 (github atomicptr/CamelCase))

(authors "Christopher Kaster <me@atomicptr.de>")

(maintainers "Christopher Kaster <me@atomicptr.de>")

(license MIT)

(documentation https://github.com/atomicptr/CamelCase)

(package
 (name CamelCase)
 (synopsis "A simple OCaml test framework")
 (description "A simple OCaml test framework")
 (depends
  (ocaml
   (>= 5.0))
  ocamlformat)
 (tags
  ("tests" "test" "unit" "unit tests")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
