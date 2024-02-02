/* Cross-hatching shader by snotgrl_02 */

#include "res://shaders/snot_utils.gdshaderinc"

group_uniforms cross_hatch_settings;
uniform float line_size = 0.0125;	//In screen widths
uniform float lineyness = 0.7;
uniform float line_softness = 0.02;
uniform float rotation = 0.3;
uniform sampler2D line_gradient;	//Brighter spots are more line-y.
uniform sampler2D randomness;
group_uniforms;

float cross_hatch(
	vec4 fragcoord,
	vec2 viewport_size,
	vec3 light,
	vec3 normal,
	float attenuation,
) {
		vec2 no_aspect_fragcoord = ( fragcoord.xy / viewport_size );
	no_aspect_fragcoord.y /= viewport_size.x / viewport_size.y;
	vec2 scaled_fragcoord = no_aspect_fragcoord * ( 1.0 / line_size );
	
	float vertical_distance = texture( 
		line_gradient, rotate( scaled_fragcoord, vec2( 0.0 ), rotation )
	).r;
	vertical_distance *= lineyness;
	
	float horizontal_distance = texture( 
		line_gradient, rotate( scaled_fragcoord, vec2( 0.0 ), rotation + TAU / 4.0 )
	).r;
	horizontal_distance *= lineyness * 0.9;
	
	float combined_distance = max( horizontal_distance, vertical_distance );
	combined_distance *= texture( randomness, no_aspect_fragcoord ).r;
	
	float litness = dot( light, normal );
	//litness *= attenuation;
	
	float current_line_width = litness;
	
	float line_mask = soft_greater( combined_distance, current_line_width,  line_softness );
	line_mask = clamp( line_mask, 0.0, 1.0 );
	return line_mask;
}
