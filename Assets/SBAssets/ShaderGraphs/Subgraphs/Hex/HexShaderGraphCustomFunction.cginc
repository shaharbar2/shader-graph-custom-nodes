#ifndef VF_CUSTOM_SHADERGRAPH_FUNCTIONS
#define VF_CUSTOM_SHADERGRAPH_FUNCTIONS
#define MOD(x,y) x - y*floor(x/y)


void Hex_float(float2 uv, float thickness, out float4 fragColor)
{
    uv.x *= 0.57735 * 2.0;
    
    float fl = floor(uv.x);
    float mod = MOD(fl, 2.0);
    uv.y +=  mod * 0.5;
    uv = abs((MOD(uv, 1.0) - 0.5));
    float sm = thickness * 0.5;
    fragColor =  smoothstep(thickness + sm, thickness - sm, abs(max(uv.x * 1.5 + uv.y, uv.y * 2.0) - 1.0));
}

#endif
