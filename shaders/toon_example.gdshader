shader_type spatial;
render_mode ambient_light_disabled;

#include "res://shaders/toon.gdshaderinc"

group_uniforms textures;
uniform sampler2D albedo_texture;
group_uniforms;

void fragment() {
	ALBEDO = texture( albedo_texture, UV ).rgb;
}

void light() {
	DIFFUSE_LIGHT += toon(
		ALBEDO,
		NORMAL,
		LIGHT,
		ATTENUATION
	);
}
