// Math utilities by snotgrl_02

float soft_greater( float a, float b, float softness ) {
	float difference = a - b;
	float result = ( ( difference / softness ) + 1.0 ) / 2.0;
	return result;
}

vec2 rotate(vec2 vector, vec2 pivot, float angle)
{
	float sine = sin( angle );
	float cosine = cos( angle );
	vector -= pivot;
	
	vec2 result;
	result.x = vector.x * cosine - vector.y * sine;
	result.y = vector.y * sine + vector.y * cosine;
	vector += pivot;
	return result;
}
