shader_type canvas_item;

void fragment(){
	vec4 text = texture(TEXTURE,UV);
	COLOR = vec4(text.xyz, text.a * UV.y);
}