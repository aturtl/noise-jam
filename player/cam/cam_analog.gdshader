shader_type spatial;
render_mode unshaded, fog_disabled;

uniform sampler2D screen_texture : hint_screen_texture;

uniform float pixel_size : hint_range(0.0, 100.0, 2.0) = 2.0;

uniform float vignette_radius : hint_range(0.0, 1.0, 0.01) = .2;
uniform float vignette_smoothness: hint_range(0.0, 1.0, 0.01) = .45;

uniform float noise_intensity : hint_range(0.0, 1.0, 0.01) = .25;

void vertex() {
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

float noise_hash(vec2 uv) {
	return fract(sin(dot(uv,uv)*319.)*115.327);
}

float vignette(vec2 uv) {
	vec2 centered_uv = uv-.5;
	float mag = sqrt(dot(centered_uv,centered_uv));
	float vig = 1.0-smoothstep(vignette_radius,vignette_radius + vignette_smoothness,mag);
	return vig;
}

vec2 rotate_uv(vec2 uv, float t)
{	
	uv -= .5;
	
	mat2 rot_mat = mat2(
		vec2(cos(t),-sin(t)),
		vec2(sin(t),cos(t))
	);
	
	uv = rot_mat*uv;
	
	uv += .5;
	return uv;
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 texture_size = VIEWPORT_SIZE;
	vec2 pixel_count = (texture_size)/(pixel_size);
	
	vec2 texel_uv = (ceil(SCREEN_UV*pixel_count))/(pixel_count+1.0);
	
	//texel_uv = rotate_uv(texel_uv,cos(TIME)*PI/128.0);
	
	vec4 pixel_texture = texture(screen_texture, texel_uv);
	
	// Excluded for clarity. Might add back later as a parameter to be controlled.
	//vec2 chrom_direction = vec2(cos(TIME*12.0)-sin(TIME*12.0),sin(TIME*12.0)+cos(TIME*12.0))*12.0;
	//	
	//vec4 pixel_texture_l = texture(screen_texture, texel_uv - chrom_direction);
	//vec4 pixel_texture_r = texture(screen_texture, texel_uv + chrom_direction);
	//
	//vec3 chromatic_abberation = vec3(pixel_texture_l.r,pixel_texture.g,pixel_texture_r.b);
	
	vec3 noise = vec3(noise_hash(texel_uv*(sin(TIME)+4.)))*noise_intensity;
	vec3 vignette = vec3(vignette(texel_uv));
	
	vec3 applied = (pixel_texture.rgb-noise)*vignette;
	
	ALBEDO = applied;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
