#ifndef SDF01_INCLUDED
#define SDF01_INCLUDED
#include "Assets/YObjectSpaceRaymarching/core/utility.hlsl"

float roundBox(float3 pos, float3 size, float round)
{
    return length(max(abs(pos) - size * 0.5, 0.0)) - round;
}

float distanceFunction(float3 pos)
{
    pos = fmod(abs(pos),0.8) - 0.4;
    return roundBox(pos, 0.3, 0.01);
}
            
float SDF(float3 pos)
{
    return  distanceFunction(worldToLocal(pos));
}
#include "Assets/YObjectSpaceRaymarching/core/RaymarchingCore.hlsl"

void roundBoxSDF_float(float3 worldPos, float3 worldNormal,float3 worldCameraPos, uint n,float4 scale,
                         out bool hit ,out float distance, out float3 rayPos, out float3 normal)
{
   hit =  Raymarching_float(worldPos, worldNormal,worldCameraPos, n, scale, distance, rayPos, normal);
}




#endif //RAYMARCHING_INCLUDED