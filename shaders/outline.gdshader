shader_type spatial;
render_mode unshaded, cull_front;

group_uniforms outline_settings;
uniform vec3 outline_color:source_color = vec3( 0.0 );
uniform float outline_width:hint_range( 0.0, 0.1 );
group_uniforms;

void vertex() {
	float outline_width_scaled = outline_width / VIEWPORT_SIZE.x;
	// VERTEX += NORMAL * outline_width_scaled;
	VERTEX += NORMAL * outline_width;
}

void fragment() {
	ALBEDO = outline_color;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
