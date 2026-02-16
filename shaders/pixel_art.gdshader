shader_type canvas_item;

#include "res://shaders/manual_pixel_filter.gdshaderinc"

const float alpha_cutoff = 0.9;
const vec4 outline_color = vec4(1.0, 1.0, 1.0, 1.0);

void vertex() {
	FILTER_SETUP_VERTEX(0);
}

void fragment() {
	COLOR = texture(TEXTURE, filtered_uv(SCREEN_PIXEL_SIZE)) * orig_color;
}