shader_type spatial;
render_mode unshaded, fog_disabled;

uniform sampler2D screen_texture : hint_screen_texture;

uniform float pixel_size : hint_range(0,100,2) = 4;
uniform float noise_amount : hint_range(0, 100) = 0;

void vertex() {
	// Called for every vertex the material is visible on.
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

float checker_hash(float f) {
	int i = int(f*217.9);
	int max_i = 2;
	i%=max_i;
	return float(i);
}

float noise_hash(float f) {
	int i = int(f*222.0);
	int factor = int(f)%3;
	
	int max_i = 3;
	i%=max_i;
	
	return float(i);
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 texel_size = vec2(textureSize(screen_texture, 0));
	vec2 pixel_count = texel_size/pixel_size;
	
	vec2 texel_uv = ceil(SCREEN_UV*pixel_count)/(pixel_count);
	
	vec4 regular_texture = texture(screen_texture, texel_uv);
	
	vec3 checker_texture = regular_texture.rgb * fract(sin(TIME*dot(texel_uv,regular_texture.rg))/2222.0);
	
	//float noise_r = float(noise_hash(checker_texture.r*TIME))/127.0;
	//float noise_g = float(noise_hash(checker_texture.g))/127.0;
	//float noise_b = float(noise_hash(checker_texture.b))/127.0;
	
	//vec3 noise_texture = vec3(noise_r,noise_g,noise_b);
	
	float noise = fract(noise_hash(checker_texture.r));
	
	ALBEDO = mix(regular_texture.rgb*noise,checker_texture,noise_amount);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
