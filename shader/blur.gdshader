shader_type canvas_item;

uniform float blur_amount = 2.5;
uniform vec4 blur_color = vec4(0.5, 0.5, 0.5, 0.5); // Graue, durchsichtige Schicht
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap; // Technische Magie

void fragment() {
	// Pro Pixel machen wir nun folgendes
	vec4 screen_color = textureLod(SCREEN_TEXTURE, SCREEN_UV, blur_amount); // SCREEN_UV gibt uns die Pixelfarbe
	// Neue Farbe
	COLOR = mix(screen_color, blur_color, blur_color.a);
}
