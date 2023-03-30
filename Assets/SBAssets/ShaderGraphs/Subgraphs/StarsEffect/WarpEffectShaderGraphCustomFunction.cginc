#ifndef VF_CUSTOM_SHADERGRAPH_FUNCTIONS
#define VF_CUSTOM_SHADERGRAPH_FUNCTIONS

void WarpEffect_float(float2 fragCoord, float2 uv, float time, float3 color1, float3 color2, out float4 fragColor)
{
    float s = 0.0, v = 0.0;
    time *= 0.05;
    uv = (-uv.xy + 2.0 * fragCoord ) / uv.y;

    uv.x += sin(time) * .3;
    float si = sin(time*1.5);
    float co = cos(time);
    float2x2 mat = float2x2(co, si, -si, co);
    uv *= mul(uv,mat);
    
    float3 init = float3(0.25, 0.25 + sin(time * 0.001) * .1, time * 0.0008);
    
    for (int r = 0; r < 100; r++) 
    {
        float3 p = init + s * float3(uv, 0.143);
        p.z = fmod(p.z, 2.0);
        for (int i=0; i < 10; i++)	p = abs(p * 2.04) / dot(p, p) - 0.75;
        v += length(p * p) * smoothstep(0.0, 0.5, 0.9 - s) * .002;

        color1 +=  float3(v * color2.r, s * color2.g, v * color2.b) * v * 0.013;
        s += .01;
    }
    
    fragColor = float4(color1, 1.0);
}

#endif
