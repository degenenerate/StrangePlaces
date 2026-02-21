shader_type canvas_item;

uniform vec4 _color : source_color;

uniform sampler2D _main_tex;
uniform sampler2D _buffer_tex;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 mainCol = texture(_main_tex, UV);
	vec4 bufferCol = texture(_buffer_tex, UV);
	vec4 outCol = mix(mainCol, _color, floor(bufferCol.r));
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
