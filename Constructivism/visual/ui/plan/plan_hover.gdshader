shader_type canvas_item;

uniform vec4 hover_color = vec4(0, 0, 0, 1);

void fragment() {
	vec4 current_pixel = texture(TEXTURE, UV);
	
	if (true)
		COLOR = hover_color;
}
