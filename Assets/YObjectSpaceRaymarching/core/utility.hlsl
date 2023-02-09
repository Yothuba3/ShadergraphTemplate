float4 _Scale;

float3 worldToLocal(float3 p)
{
    return mul(unity_WorldToObject, float4(p,1.0)).xyz * abs(_Scale);	
}

bool isInnerBox(float3 pos, float3 scale)
{
    return all(max(scale * 0.5 - abs(pos), 0.0));
}
            
