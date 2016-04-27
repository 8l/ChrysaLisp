%include 'inc/func.inc'
%include 'inc/font.inc'
%include 'class/class_text.inc'

	fn_function class/text/init
		;inputs
		;r0 = text object
		;r1 = vtable pointer
		;outputs
		;r1 = 0 if error, else ok

		;init parent
		super_call text, init, {r0, r1}, {r1}
		if r1, !=, 0
			vp_push r0

			;init myself
			static_call gui_font, open, {"fonts/OpenSans-Regular.ttf", 18}, {r0}
			assert r0, !=, 0
			vp_cpy [r4], r1
			vp_cpy r0, [r1 + text_font]
			vp_xor r0, r0
			vp_cpy r0, [r1 + text_string]
			vp_cpy r0, [r1 + text_text_color]

			vp_pop r0
		endif
		vp_ret

	fn_function_end