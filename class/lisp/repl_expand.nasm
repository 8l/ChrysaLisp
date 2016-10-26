%include 'inc/func.inc'
%include 'class/class_unordered_map.inc'
%include 'class/class_pair.inc'
%include 'class/class_vector.inc'
%include 'class/class_lisp.inc'

	def_func class/lisp/repl_expand
		;inputs
		;r0 = lisp object
		;r1 = iter to form
		;outputs
		;r0 = lisp object
		;r1 = 0 if expanded

		pptr iter, miter
		ptr this, form, macro, args
		ulong length

		push_scope
		retire {r0, r1}, {this, iter}

		assign {*iter}, {form}
		if {form->obj_vtable == @class/class_vector}
			devirt_call vector, get_length, {form}, {length}
			if {length}
				func_call vector, get_element, {form, 0}, {macro}
				breakif {macro == this->lisp_sym_qquote}
				breakif {macro == this->lisp_sym_quote}
				if {macro->obj_vtable == @class/class_symbol}
					func_call unordered_map, find, {this->lisp_macros, macro}, {miter, _}
					if {miter}
						func_call pair, get_second, {*miter}, {macro}
						func_call lisp, env_push, {this}
						func_call vector, get_element, {macro, 0}, {args}
						func_call lisp, env_bind, {this, args, form, 1}, {form}
						if {form->obj_vtable != @class/class_error}
							func_call ref, deref, {form}
							func_call vector, get_element, {macro, 1}, {form}
							func_call lisp, repl_eval, {this, form}, {form}
						endif
						func_call lisp, env_pop, {this}
						func_call ref, deref, {*iter}
						assign {form}, {*iter}
						eval {this, form->obj_vtable == @class/class_error}, {r0, r1}
						return
					endif
				endif
				func_path lisp, repl_expand
				func_call vector, for_each, {form, 0, length, @_function_, this}, {iter}
				assign {!iter}, {iter}
			endif
		endif

		eval {this, iter}, {r0, r1}
		pop_scope
		return

	def_func_end