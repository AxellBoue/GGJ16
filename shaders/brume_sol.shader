shader_type canvas_item;

uniform sampler2D brume_tex : hint_albedo;
uniform vec2 player_pos;
varying vec2 world_pos;
uniform mat4 global_transform;

void vertex(){
	//world_pos = (WORLD_MATRIX * vec4(VERTEX,1.0,1.0)).xy;
	world_pos = (global_transform * vec4(VERTEX,0.0,1.0)).xy;
}

void fragment(){
	vec4 tex_sol = texture(TEXTURE,UV);
	vec4 tex_brume = texture(brume_tex,world_pos/500.0);
	vec2 distance_perso_vec = player_pos - world_pos;
	float distance_perso = sqrt(pow(distance_perso_vec.x,2.0)+ pow(distance_perso_vec.y,2));
	COLOR = mix(tex_sol, tex_brume, clamp(1.0,0.0,distance_perso/400.0));
	
}