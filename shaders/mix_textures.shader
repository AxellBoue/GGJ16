shader_type canvas_item ;

uniform vec2 rect_size = vec2(500,500);
uniform sampler2D textureFond : hint_albedo ;
uniform vec2 texture_fond_size = vec2(300,300);
uniform sampler2D texture1 : hint_albedo ;
uniform vec2 texture1_size = vec2(300,300);
uniform sampler2D texture2 : hint_albedo ;
uniform vec2 texture2_size = vec2(300,300);
uniform sampler2D texture3 : hint_albedo ;
uniform vec2 texture3_size = vec2(300,300);
uniform sampler2D mixTexture : hint_albedo ;


void fragment(){
	vec4 couleurFond = texture(textureFond,UV*vec2(rect_size/texture_fond_size));
	vec4 couleur1 = texture(texture1,UV*vec2(rect_size/texture1_size));
	vec4 couleur2 = texture(texture2,UV*vec2(rect_size/texture2_size));
	vec4 couleur3 = texture(texture3,UV*vec2(rect_size/texture3_size));
	vec4 mixCouleur = texture(mixTexture,UV);
	
	COLOR = mix(couleurFond, couleur1, mixCouleur.r);
	COLOR = mix(COLOR, couleur2, mixCouleur.g);
	COLOR = mix(COLOR, couleur3, mixCouleur.b);
	}