shader_type canvas_item;

uniform sampler2D brumeTex : source_color;
uniform sampler2D brumeIntensiteTex : source_color;
uniform float distancePlayer ;
varying vec2 world_pos;
uniform mat4 global_transform;

void vertex(){
	world_pos = (global_transform * vec4(VERTEX,0.0,1.0)).xy;
}

void fragment(){
	vec4 tex = texture(TEXTURE,UV);
	vec4 brume_tex = texture(brumeTex,world_pos/500.0);
	vec4 brume_intensite_tex = texture(brumeIntensiteTex,world_pos/4000.0);
	
	float mixQuotient = clamp(distancePlayer/400.0,0.0,1.0)*brume_intensite_tex.a;
	vec4 colorWithFog =  mix(tex,brume_tex,mixQuotient*clamp(1.0,0.0,UV.y*3.0-0.4));
	COLOR = vec4 (colorWithFog.rgb,tex.a);
}