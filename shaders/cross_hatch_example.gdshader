shader_type spatial;
render_mode specular_toon;

#include "res://shaders/cross_hatch.gdshaderinc"

void light() {
	float mask = cross_hatch(
		FRAGCOORD, VIEWPORT_SIZE, LIGHT, 
		NORMAL, ATTENUATION 
	);
	
	// Makes the lines vantablack
	float luminance = 1.0 - ( mask * 1.2 );
	
	DIFFUSE_LIGHT += luminance;
}
