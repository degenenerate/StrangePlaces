shader_type canvas_item;

varying vec4 orig_color;
varying vec2 texel_size;
varying vec2 scaled_uv;

void vertex() {
	orig_color = COLOR;
	texel_size = 1.0/TEXTURE_PIXEL_SIZE;
	scaled_uv = UV * texel_size;
}

void fragment() {
	float texels_per_pixel = SCREEN_PIXEL_SIZE.y * 180.0;

	vec2 location_within_texel = fract(scaled_uv);
	vec2 interpolation_amount = clamp(location_within_texel / texels_per_pixel, 0.0, 0.5) + clamp((location_within_texel - 1.0) / texels_per_pixel + 0.5, 0.0, 0.5);
	vec2 final_texture_coords = (floor(scaled_uv) + interpolation_amount) / texel_size;
	COLOR = texture(TEXTURE, final_texture_coords) * orig_color;
	//if (interpolation_amount.x != 0.5 || interpolation_amount.y != 0.5) {
		//COLOR = vec4(0.0, 0.0, 0.0, 1.0);
	//}

	// COLOR = texture(TEXTURE, UV/texel_size);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
