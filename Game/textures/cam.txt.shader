shader_type canvas_item;

uniform float brightness = 1.0;
uniform float contrast = 1.0;
uniform float saturation = 0.8;
uniform vec4 color: hint_color = vec4(0.5, 0.5, 0.5, 1.0);
uniform float shade_tweak = 0.7;
uniform float light_tweak = 1.3;
uniform float sharpness = 0.0;
uniform float scales = 1.0;
const mat4 dither = mat4(
	vec4(0.0, 0.5333333333, 0.1333333333,  0.6666666667),
	vec4(0.8, 0.2666666667, 0.9333333333,  0.4),
	vec4(0.2, 0.7333333333, 0.06666666667, 0.6),
	vec4(1.0, 0.4666666667, 0.8666666667,  0.3333333333)
);
float sample(vec2 coord, float alpha, float shade, float lit) {
	int x = int(mod(coord.x, 1));
	int y = int(mod(coord.y, 1));
	if (y == 0) {
		if (x == 0 && dither[0][0] >= alpha) {
			return shade;
		} else if (x == 1 && dither[0][1] >= alpha) {
			return shade;
		} else if (x == 2 && dither[0][2] >= alpha) {
			return shade;
		} else if (x == 3 && dither[0][3] >= alpha) {
			return shade;
		}
	} else if (y == 1) {
		if (x == 0 && dither[1][0] >= alpha) {
			return shade;
		} else if (x == 1 && dither[1][1] >= alpha) {
			return shade;
		} else if (x == 2 && dither[1][2] >= alpha) {
			return shade;
		} else if (x == 3 && dither[1][3] >= alpha) {
			return shade;
		}
	} else if (y == 2) {
		if (x == 0 && dither[2][0] >= alpha) {
			return shade;
		} else if (x == 1 && dither[2][1] >= alpha) {
			return shade;
		} else if (x == 2 && dither[2][2] >= alpha) {
			return shade;
		} else if (x == 3 && dither[2][3] >= alpha) {
			return shade;
		}
	} else if (y == 3) {
		if (x == 0 && dither[3][0] >= alpha) {
			return shade;
		} else if (x == 1 && dither[3][1] >= alpha) {
			return shade;
		} else if (x == 2 && dither[3][2] >= alpha) {
			return shade;
		} else if (x == 3 && dither[3][3] >= alpha) {
			return shade;
		}
	}
	return lit;
}
void fragment() {
    vec3 c = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).rgb;
	c.rgb = mix(vec3(0.0), c.rgb, brightness);
    c.rgb = mix(vec3(0.5), c.rgb, contrast);
    c.rgb = mix(vec3(dot(vec3(1.0), c.rgb) * 0.33333), c.rgb, saturation);
	vec3 c1 = mix(vec3(0.0),c.rgb,0.0625);
	c1.rgb = vec3(float(int(c1.r*230.0))/230.0,float(int(c1.g*230.0))/230.0,float(int(c1.b*230.0))/230.0);
	c.rgb = mix(vec3(0.0),c1.rgb,16.0);
	float f = min(c.r, min(c.g, c.b));
	float a = sample(
		FRAGCOORD.xy,
		clamp(dot(NORMAL, COLOR.rgb) + sharpness, 0.0, 1.0 + sharpness) * f,
		shade_tweak,
		light_tweak);
    COLOR.rgb = c*a;
}