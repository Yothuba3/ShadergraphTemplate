#ifndef RAYMARCHINGCORE_INCLUDED
#define RAYMARCHINGCORE_INCLUDED
#define MINLENGTH 0.0001


//なんでこれで法線が計算できるのかは偏微分を検索ぅ
float3 getNormal(float3 pos)
{
    float delta = 0.001;
    float fx = SDF(pos + float3(delta, 0.0, 0.0)) - SDF(pos + float3(-delta, 0.0, 0.0));
    float fy = SDF(pos + float3(0.0, delta, 0.0)) - SDF(pos + float3(0.0,-delta, 0.0));
    float fz = SDF(pos + float3(0.0, 0.0,delta)) - SDF(pos + float3(0.0,0.0,-delta));
    return normalize(float3(fx, fy, fz));
}

bool Raymarching_float(float3 worldPos, float3 worldNormal,float3 worldCameraPos, uint n,float4 scale ,out float distance, out float3 rayPos, out float3 normal)
{
    bool hit = false;
    _Scale = scale;
    normal = worldNormal;
    rayPos = worldPos;
    float3 ray = normalize(worldPos - worldCameraPos);
    distance = 0.0;
    float r = 0.0;

    for(int i = 0; i < n; i++)
    {
        distance = SDF(rayPos);
        r += distance;
        rayPos = worldPos + ray * r;
        if(!isInnerBox(worldToLocal(rayPos), abs(scale))) break;
        if(distance < MINLENGTH) {
            hit = true;
            break;
        }
    }
    if(distance < MINLENGTH) {
        hit = true;
    }
    
    if(distance > 0.0)
    {
        normal = getNormal(rayPos);
    }
    return hit;
}

#endif //RAYMARCHINGCORE_INCLUDED