#ifndef VF_CUSTOM_SHADERGRAPH_FUNCTIONS
#define VF_CUSTOM_SHADERGRAPH_FUNCTIONS

void HashRandom_float(float input, out float Out)
{
    Out = frac(sin(input * 12.9898) * 13758.5453);
}

#endif
