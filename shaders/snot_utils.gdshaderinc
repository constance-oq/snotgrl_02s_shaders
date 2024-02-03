// Math utilities by snotgrl_02

float soft_greater( float a, float b, float softness ) {
	float difference = a - b;
	float result = clamp( difference / softness, -1.0, 1.0 );
	result = ( result + 1.0 ) / 2.0;
	return result;
}

float soft_lesser( float a, float b, float softness ) {
	float difference = b - a;
	float result = clamp( difference / softness, -1.0, 1.0 );
	result = ( result + 1.0 ) / 2.0;
	return result;
}

vec2 rotate(vec2 vector, vec2 pivot, float angle)
{
	vec2 result;
	float sine = sin( angle );
	float cosine = cos( angle );
	vector -= pivot;
	result.x = ( vector.x * cosine ) - ( vector.y * sine );
	result.y = ( vector.x * sine ) + ( vector.y * cosine );
	vector += pivot;
	return result;
}
