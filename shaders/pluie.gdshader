shader_type canvas_item;
render_mode blend_mul;

uniform float hueChange : hint_range(0.0,6.5);
uniform float alpha : hint_range(0.0,1.0) = 0.4;

vec3 hueShift(vec3 color, float hue) {
    const vec3 k = vec3(0.57735, 0.57735, 0.57735);
    float cosAngle = cos(hue);
    return vec3(color * cosAngle + cross(k, color) * sin(hue) + k * dot(k, color) * (1.0 - cosAngle));
}

void fragment(){
	vec4 tex = texture(TEXTURE,UV);
	COLOR = mix(tex,vec4(1.0),alpha);
	COLOR.rgb = hueShift(COLOR.rgb,hueChange);
}