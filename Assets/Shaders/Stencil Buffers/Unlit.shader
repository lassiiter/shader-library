Shader "Unlit/Unlit"
{
    
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGINCLUDE
            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 screenPostion: TEXCOORD0;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.screenPostion = o.vertex;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return i.screenPostion;
            }
            ENDCG
        }
    }
}
