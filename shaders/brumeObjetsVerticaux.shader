shader_type canvas_item;

uniform sampler2D brumeTex : hint_albedo;
uniform float distancePlayer ;
varying vec2 world_pos;
uniform mat4 global_transform;

void vertex(){
	//world_pos = (WORLD_MATRIX * vec4(VERTEX,1.0,1.0)).xy;
	world_pos = (global_transform * vec4(VERTEX,0.0,1.0)).xy;
}

void fragment (){
	vec4 tex = texture(TEXTURE, UV);
	vec4 fog = texture(brumeTex, world_pos/500.0);
	
	float mixQuotient = clamp(distancePlayer/400.0,0.0,1.0);
	vec4 colorWithFog =  mix(tex,fog,mixQuotient);
	COLOR = vec4 (colorWithFog.rgb,tex.a);
	
	//qCOLOR = vec4(world_pos.x/400.0, world_pos.y/400.0, 0.0,tex.a);
}