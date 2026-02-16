#define FILTER_SETUP_VERTEX(arg) { orig_color = COLOR; div_texel_size = TEXTURE_PIXEL_SIZE; scaled_uv = UV / div_texel_size; }

varying vec4 orig_color;
varying vec2 div_texel_size;
varying vec2 scaled_uv;

vec4 nearest_texture(sampler2D _texture, vec2 _uv) {
	return texture(_texture, (floor(_uv/div_texel_size)+0.5)*div_texel_size);
}

vec2 filtered_uv(vec2 _screen_pixel_size) {
	float texels_per_pixel = _screen_pixel_size.y * 180.0;

	vec2 location_within_texel = fract(scaled_uv);
	vec2 interpolation_amount = clamp(location_within_texel / texels_per_pixel, 0.0, 0.5) + clamp((location_within_texel - 1.0) / texels_per_pixel + 0.5, 0.0, 0.5);
	vec2 final_texture_coords = (floor(scaled_uv) + interpolation_amount) * div_texel_size;
	
	return final_texture_coords;
}
