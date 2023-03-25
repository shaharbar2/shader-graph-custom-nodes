#ifndef VF_CUSTOM_SHADERGRAPH_FUNCTIONS
#define VF_CUSTOM_SHADERGRAPH_FUNCTIONS

float3 palette(float d)
{
    return lerp(float3(0.2, 0.7, 0.9), float3(1., 0., 1.), d);
}

float2 rotate(float2 p, float a)
{
    float c = cos(a);
    float s = sin(a);
    float mat = float2x2(c, s, -s, c);
    return p * mat;
}

float map(float3 p, float time)
{
    for (int i = 0; i < 8; ++i)
    {
        float t = time * 0.2;
        p.xz = rotate(p.xz, t);
        p.xy = rotate(p.xy, t * 1.89);
        p.xz = abs(p.xz);
        p.xz -= .5;
    }
    return dot(sign(p), p) / 5.;
}

float4 rm(float3 ro, float3 rd, float time)
{
    float t = 0.;
    float3 col = float3(0, 0, 0);
    float d;
    for (float i = 0.; i < 64.; i++)
    {
        float3 p = ro + rd * t;
        d = map(p, time) * .5;
        if (d < 0.02)
        {
            break;
        }
        if (d > 100.)
        {
            break;
        }
        //col+=float3(0.6,0.8,0.8)/(400.*(d));
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

    float4 col = rm(ro, rd, time);


    fragColor = col;
}

#endif
