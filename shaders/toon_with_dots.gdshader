shader_type spatial;
render_mode ambient_light_disabled;

#include "res://shaders/toon.gdshaderinc"
#include "res://shaders/dot_shade.gdshaderinc"

group_uniforms dot_shade_settings;
uniform vec3 dot_color : source_color = vec3( 0.0 );
group_uniforms;

group_uniforms textures;
uniform sampler2D albedo_texture;
group_uniforms;

void fragment() {
	ALBEDO = texture( albedo_texture, UV ).rgb;
}

void light() {
	float dot_mask = dot_shade(
		FRAGCOORD,
		VIEWPORT_SIZE,
		LIGHT,
		NORMAL,
		ATTENUATION
	);
	vec3 toon_color = toon(
		ALBEDO,
		NORMAL,
		LIGHT,
		ATTENUATION
	);
	
	vec3 dot_composite = dot_mask * dot_color;
	DIFFUSE_LIGHT += mix( toon_color, dot_composite, dot_mask );
}
