shader_type spatial;

void fragment(){
	ROUGHNESS = 0.2;
	RIM = 1.0;
	
	vec3 color;
	color.r = sin(TIME * 0.100 + VERTEX.x * 2.0) + 1.0;
	color.g = sin(TIME * 0.050 + VERTEX.x * 1.0) + 1.0;
	color.b = sin(TIME * 0.005 + VERTEX.x * 0.5) + 1.0;
	ALBEDO = color;
}