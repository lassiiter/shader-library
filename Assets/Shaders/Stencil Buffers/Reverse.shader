Shader "Unlit/Reverse"
{
    Properties
    {
        [IntRange] _StencilID ("Stencil ID",Range(0,255)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Cull Front
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
            };


            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return fixed4(1,1,1,1);
            }
            ENDCG
        }
        
    }
}