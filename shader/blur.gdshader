shader_type canvas_item;

uniform float blur_amount = 2.5;
uniform vec4 blur_color = vec4(0.5, 0.5, 0.5, 0.5); // Graue, durchsichtige Schicht
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap; // Technische Magie

void fragment() {
	// Mehr technische Magie: Wir nehmen uns den durchschnittlichen Farbpixelwert auf dem Bildschirm
	vec4 screen_color = textureLod(SCREEN_TEXTURE, SCREEN_UV, blur_amount); 
	// Neue Farbe
	COLOR = mix(screen_color, blur_color, blur_color.a);
}