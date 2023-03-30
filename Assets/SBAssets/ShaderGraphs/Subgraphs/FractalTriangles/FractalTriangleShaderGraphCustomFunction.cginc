#ifndef VF_CUSTOM_SHADERGRAPH_FUNCTIONS
#define VF_CUSTOM_SHADERGRAPH_FUNCTIONS

float3 palette(float d)
{
    return lerp(float3(0.2, 0.7, 0.9), float3(1., 0., 1.), d);
}

float2 rotate(float2 frag, float amount)
{
    float c = cos(amount);
    float s = sin(amount);
    float mat = float2x2(c, s, -s, c);
    return frag * mat;
}

float map(float3 pos, float time)
{
    for (int i = 0; i < 8; ++i)
    {
        float t = time * 0.2;
        pos.xz = rotate(pos.xz, t);
        pos.xy = rotate(pos.xy, t * 1.89);
        pos.xz = abs(pos.xz);
        pos.xz -= .5;
    }
    return dot(sign(pos), pos) / 5.;
}

float4 GetColor(float3 In1, float3 In2, float time)
{
    float t = 0.;
    float3 col = float3(0, 0, 0);
    float d;
    
    for (float i = 0.; i < 64.; i++)
    {
        float3 p = In1 + In2 * t;
        d = map(p, time) * .5;
        
        if (d < 0.02)
        {
            break;
        }
        
        if (d > 100.)
        {
            break;
        }

        col += palette(length(p) * .1) / (400. * (d));
        t += d;
    }
    
    return float4(col, 1. / (d * 100.));
}

void FracTriangles_float(float2 fragCoord, float2 iResolution, float time, out float4 fragColor)
{
    float2 uv = fragCoord - iResolution /2;
    float3 ro = float3(0., 0., -50.);
    ro.xz = rotate(ro.xz, time);
    
    float3 cf = normalize(-ro);
    float3 cs = normalize(cross(cf, float3(0., 1., 0.)));
    float3 cu = normalize(cross(cf, cs));

    float3 uuv = ro + cf * 3. + uv.x * cs + uv.y * cu;

    float3 rd = normalize(uuv - ro);

    float4 col = GetColor(ro, rd, time);


    fragColor = col;
}

#endif
