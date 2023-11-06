Shader "Unlit/StencilBufferHoleWRITE"
{
    Properties
    {
        [IntRange] _StencilID ("Stencil ID",Range(0,255)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry+1"}
        ZWrite Off
        Blend Zero One
        Pass
        {
            Stencil
            {
                Ref 2
                Comp Always
                Pass Replace
            }
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
