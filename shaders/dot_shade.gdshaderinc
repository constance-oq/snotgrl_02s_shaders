/* Dot shading by snotgrl_02 */

#include "res://shaders/snot_utils.gdshaderinc"

group_uniforms dot_shade_settings;
uniform float dottiness = 0.6;
uniform float dot_softness = 0.2;
uniform float dot_radius = 0.005;	//In screen widths
uniform float rotation = 0.3;
group_uniforms;

float dot_shade(
	vec4 fragcoord,
	vec2 viewport_size,
	vec3 light,
	vec3 normal,
	float attenuation
) {
	// Dot shading
	vec2 scaled_fragcoord = ( fragcoord.xy / viewport_size ) * ( 1.0 / dot_radius );
	scaled_fragcoord.y /= viewport_size.x / viewport_size.y;
	scaled_fragcoord = rotate( scaled_fragcoord, vec2( 5.0, 5.0 ), rotation );
	
	vec2 nearest_centre = round( scaled_fragcoord );
	float dot_distance = distance( scaled_fragcoord, nearest_centre );
	
	float litness = clamp( dot( light, normal ), 0.0, 1.0 );
	litness *= attenuation;
	litness *= 1.0 / dottiness;
	
	float current_radius = 1.0 - litness;
	
	float dot_mask = soft_lesser( dot_distance, current_radius, dot_softness );
	dot_mask = clamp( dot_mask, 0.0, 1.0 );
	
	return dot_mask;
}
