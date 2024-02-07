group_uniforms toon_settings;
uniform sampler2D shading_gradient;
group_uniforms;

vec3 toon( 
	vec3 albedo,
	vec3 normal,
	vec3 light,
	float attenuation
) {
	float litness = clamp( dot( light, normal ), 0.0, 1.0 );
	litness *= attenuation;

	float litness_normalized = ( litness + 1.0 ) / 2.0;
	//Prevent texture repeating:
	litness_normalized = litness_normalized * 0.9 + 0.05;
	vec3 toon_ramp = texture( 
		shading_gradient, 
		vec2( litness_normalized, 0.0 ) 
	).rgb;
	
	vec3 lit_color = ( toon_ramp * albedo );
	
	return lit_color;
}
/*  WIP spec shader

uniform float roughness : hint_range( 0.0, 1.0 );

// Phong.
//litness = smoothstep( 0.0, 0.02, litness );
vec3 half = - reflect( VIEW, NORMAL );
float spec = dot( LIGHT, half );
spec = clamp(spec, 0.0, 1.0 );
float spec_power = log2( roughness / 2.0 + 0.0001);
spec_power *= spec_power;
spec = pow( spec, spec_power );

spec = smoothstep( 0.05, 0.06, spec );
spec *= litness;

SPECULAR_LIGHT += spec;
*/
