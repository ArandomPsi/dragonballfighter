shader_type canvas_item;

uniform vec4 target_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 replacement_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);

uniform float tolerance = 0.01;
uniform float transparency : hint_range(0.0, 1.0, 0.02) = 1.0;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);

	if (
		abs(tex.r - target_color.r) < tolerance &&
		abs(tex.g - target_color.g) < tolerance &&
		abs(tex.b - target_color.b) < tolerance
	) {
		tex.rgb = replacement_color.rgb;
	}

	COLOR = tex * transparency;
}