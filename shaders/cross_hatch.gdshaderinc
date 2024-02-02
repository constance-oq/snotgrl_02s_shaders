/* Cross-hatching shader by snotgrl_02 */

#include "res://shaders/snot_utils.gdshaderinc"

group_uniforms cross_hatch_settings;
uniform float line_size = 0.0125;	//In screen widths
uniform float lineyness = 0.6;
uniform float line_softness = 0.07;
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
	
	float vertical_lines = texture( 
		line_gradient, rotate( scaled_fragcoord, vec2( 0.0 ), rotation )
	).r;
	
	float horizontal_lines = texture( 
		line_gradient, rotate( scaled_fragcoord, vec2( 0.0 ), rotation + TAU / 4.0 )
	).r;
	horizontal_lines *= 0.9;
	
	float combined_lines = max( horizontal_lines, vertical_lines );
	combined_lines *= texture( randomness, no_aspect_fragcoord ).r;
	
	float litness = clamp( dot( light, normal ), 0.0, 1.0 );
	litness *= attenuation;
	litness *= 1.0 / lineyness;
	
	float current_line_width = litness;
	
	float line_mask = soft_greater( combined_lines, current_line_width,  line_softness );
	line_mask = clamp( line_mask, 0.0, 1.0 );
	
	// Make shadows fully black
	line_mask = max( line_mask, soft_greater( 0.02, litness, 0.01 ) );

	//return line_mask;
	return line_mask;
}
