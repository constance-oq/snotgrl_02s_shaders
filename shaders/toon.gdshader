shader_type spatial;
//render_mode unshaded;

uniform sampler2D outline_gradient;
uniform sampler2D toon_shading_gradient;
uniform vec3 toon_shading_color : source_color = vec3(1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Outline
	float luminance = clamp( dot(VIEW, NORMAL), 0.05, 0.95 );	// 0.05 margin to prevent repeating
	vec3 luminance_outline = texture(outline_gradient, vec2( luminance, 0.0 ) ).rgb;
	ALBEDO = luminance_outline;
}
void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
	float litness = (dot( LIGHT, NORMAL ) + 1.0 ) / 2.0;
	litness *= ATTENUATION;
	litness = litness * 0.9 + 0.05;	//Prevent texture repeating
	vec3 luminance = texture( toon_shading_gradient, vec2( litness, 0.0 ) ).rgb;
	
	vec3 lit_color = ( luminance * ALBEDO * LIGHT_COLOR * toon_shading_color);
	
	DIFFUSE_LIGHT += lit_color;
	
}
