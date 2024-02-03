shader_type spatial;
render_mode specular_toon;

#include "res://shaders/dot_shade.gdshaderinc"

void light() {
	float mask = dot_shade(
		FRAGCOORD, VIEWPORT_SIZE, LIGHT, 
		NORMAL, ATTENUATION 
	);
	
	// Makes the dots vantablack
	float luminance = 1.0 - ( mask * 1.3 );
	
	DIFFUSE_LIGHT += luminance;
}
