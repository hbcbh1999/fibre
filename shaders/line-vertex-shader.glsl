precision highp float;

uniform sampler2D PosDataA;
uniform sampler2D PosDataB;
uniform sampler2D RgbDataA;
uniform sampler2D RgbDataB;
uniform mat4 u_projectionMatrix;
uniform mat4 u_modelViewMatrix;

in vec3 TexCoord;
out vec4 vColor;

void main()
{
	// Textures A and B contain line segment start and end points respectively
	// (i.e. the geometry defined by this vertex shader is stored in textures)
	vec4 posA   = texture(PosDataA, TexCoord.xy);
	vec4 posB   = texture(PosDataB, TexCoord.xy);
    vec4 colorA = texture(RgbDataA, TexCoord.xy);
    vec4 colorB = texture(RgbDataB, TexCoord.xy);

	// Line segment vertex position (either posA or posB)
	vec4 pos = mix(posA, posB, TexCoord.z);
	gl_Position = u_projectionMatrix * u_modelViewMatrix * vec4(pos.xyz, 1.0);
	vColor = mix(colorA, colorB, TexCoord.z);
}
