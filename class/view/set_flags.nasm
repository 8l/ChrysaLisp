%include 'inc/func.inc'
%include 'class/class_view.inc'

	fn_function class/view/set_flags
		;inputs
		;r0 = view object
		;r1 = flags

		vp_cpy r1, [r0 + view_flags]
		vp_ret

	fn_function_end