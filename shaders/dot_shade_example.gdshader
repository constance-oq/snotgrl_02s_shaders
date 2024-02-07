shader_type spatial;
render_mode specular_toon;

#include "res://shaders/dot_shade.gdshaderinc"

group_uniforms dot_shade_settings;
uniform vec4 dot_color : source_color = vec4( -0.3, -0.3, -0.3, 1.0 );
uniform vec4 blank_color : source_color = vec4( 0.0 );
group_uniforms;

void light() {
	float mask = dot_shade(
		FRAGCOORD, VIEWPORT_SIZE, LIGHT, 
		NORMAL, ATTENUATION 
	);
	
	// Makes the dots vantablack
	float luminance = 1.0 - ( mask * 1.3 );
	
	DIFFUSE_LIGHT += vec3( luminance );
}
