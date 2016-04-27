%include 'inc/func.inc'
%include 'inc/gui.inc'
%include 'class/class_text.inc'
%include 'class/class_string.inc'

	fn_function class/text/deinit
		;inputs
		;r0 = text object
		;trashes
		;all but r0, r4

		;save object
		vp_push r0

		;deref any string object
		static_call string, deref, {[r0 + text_string]}

		;deinit parent
		vp_pop r0
		super_jmp text, deinit, {r0}

	fn_function_end