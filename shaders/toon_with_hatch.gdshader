shader_type spatial;
render_mode ambient_light_disabled;

#include "res://shaders/toon.gdshaderinc"
#include "res://shaders/cross_hatch.gdshaderinc"

group_uniforms cross_hatch_settings;
uniform vec3 cross_hatch_color : source_color = vec3( 0.0 );
group_uniforms;

group_uniforms textures;
uniform sampler2D albedo_texture;
group_uniforms;

void fragment() {
	ALBEDO = texture( albedo_texture, UV ).rgb;
}

void light() {
	float hatch_mask = cross_hatch(
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
	
	vec3 hatch_composite = hatch_mask * cross_hatch_color;
	DIFFUSE_LIGHT += mix( toon_color, hatch_composite, hatch_mask );
}
