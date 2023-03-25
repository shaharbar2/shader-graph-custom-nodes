#ifndef VF_CUSTOM_SHADERGRAPH_FUNCTIONS
#define VF_CUSTOM_SHADERGRAPH_FUNCTIONS


void VanishGrid_float(float2 uv, float battery, float time, out float4 fragColor)
{
    uv.y = 3.0 / (abs(uv.y + 0.2) + 0.05);
    uv.x *= uv.y * 1.0;
    
    float2 size = float2(uv.y, uv.y * uv.y * 0.2) * 0.01;
    uv += float2(0.0, time * 4.0 * (battery + 0.05));
    uv = abs(frac(uv) - 0.5);
    float2 lines = smoothstep(size, float2(0,0), uv);
    lines += smoothstep(size * 5.0, float2(0,0), uv) * 0.4 * battery;
    fragColor = clamp(lines.x + lines.y, 0.0, 3.0);
}

#endif
