(import 'class/ref/ref.inc)

(def-class 'sequence 'ref)
(def-method 'get_length 'class/obj/null 'virtual '(r0) '(r0 r1))
(def-method 'ref_element 'class/obj/null 'virtual '(r0 r1) '(r0 r1))

(def-struct 'sequence 'ref)
(def-struct-end)
