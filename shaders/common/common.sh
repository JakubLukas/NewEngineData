/*
 * Copyright 2011-2017 Branimir Karadzic. All rights reserved.
 * License: https://github.com/bkaradzic/bgfx#license-bsd-2-clause
 */

#include <bgfx_shader.sh>
#include "shaderlib.sh"

vec4 UnpackColor(float color)
{
	const float invByte = 1.0 / 256.0;
	unsigned int c = floatBitsToUint(color);
	return vec4(((c) & 0xFF) * invByte,
		((c >> 8) & 0xFF) * invByte,
		((c >> 16) & 0xFF) * invByte,
		((c >> 24) & 0xFF) * invByte);
}


vec4 ComputeBlinnPhong(vec4 normal, vec4 viewDir, vec4 lightDir, vec4 lightColorDiff, vec4 lightColorSpec, vec4 matColorDiff, vec4 matColorSpec, float shininess)
{
	vec4 halfwayDir = normalize(lightDir + viewDir);

	float diffuse = max(dot(lightDir, normal), 0.0);
	float specular = pow(max(dot(normal, halfwayDir), 0.0), shininess);
	
	return (0.1 + diffuse) * matColorDiff * lightColorDiff + specular * matColorSpec * lightColorSpec;
}