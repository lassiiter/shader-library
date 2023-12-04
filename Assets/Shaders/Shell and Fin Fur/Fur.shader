Shader "Unlit/Fur"
{
   
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float4 _MainTex_ST;
            
              uint murmurHash12(uint2 src) {
                const uint M = 0x5bd1e995u;
                uint h = 1190494759u;
                src *= M; src ^= src>>24u; src *= M;
                h *= M; h ^= src.x; h *= M; h ^= src.y;
                h ^= h>>13u; h *= M; h ^= h>>15u;
                return h;
            } 

            float hash12(float2 src) {
                uint h = murmurHash12(asuint(src));
                return asfloat(h & 0x007fffffu | 0x3f800000u) - 1.0;
            }

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float _Density = 3;
                float2 uv = i.uv * _Density;
                float2 localUV = frac(uv) * 2 - 1;
                float distanceToCenter = length(localUV);
                //hashing function
                uint2 uvint = uv;
                int value = hash12(uvint)*2 ;
                int color = (distanceToCenter) > (value);
                if (color > 0) discard;
                return fixed4(color,color,color,1);
            }
            ENDCG
        }
    }
}
