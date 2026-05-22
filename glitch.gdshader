shader_type spatial;
render_mode unshaded, fog_disabled;

uniform sampler2D screen_texture : hint_screen_texture;
uniform float pixel_size : hint_range(0.0, 100.0, 2.0) = 4.0;
uniform float offset : hint_range(0.0, 20.0, .00001) = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 texel_size = vec2(textureSize(screen_texture, 0));
	vec2 pixel_count = texel_size / pixel_size;
	
	vec2 pixel_uv = floor(SCREEN_UV * pixel_count) /  pixel_count;
	float color_r = texture(screen_texture, pixel_uv).r;
	float color_g = texture(screen_texture, (pixel_uv - offset)).g;
	float color_b = texture(screen_texture, (pixel_uv + offset)).b;
	
	ALBEDO = vec3(color_r,color_g,color_b);
}

void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
}
