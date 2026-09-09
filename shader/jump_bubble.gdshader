shader_type spatial;

uniform float hit_intensity = 0.02;

void vertex() {
	// Mehr Mathe Magie
	float jiggle = cos(TIME * 15.0 + VERTEX.y * 10.0) * hit_intensity;
	VERTEX += NORMAL * jiggle;
}

void fragment() {
	ALBEDO = vec3(1.0, 1.0, 0.0);
}
