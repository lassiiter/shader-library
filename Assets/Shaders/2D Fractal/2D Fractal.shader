Shader "Unlit/2D Fractal"
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
                float4 fragCoord : POSITION;
            };

            struct v2f
            {
                float4 fragCoord : SV_POSITION;
            };

            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.fragCoord = UnityObjectToClipPos(v.fragCoord);
                return o;
            }

            float sdBox( in float2 p, in float2 b )
            {
                float2 d = abs(p)-b;
                return length(max(d,0.0)) + min(max(d.x,d.y),0.0);
            }   

            float dot2( in float2 v ) { return dot(v,v); }

            float sdHeart( in float2 p )
            {
                p.x = abs(p.x);

                if( p.y+p.x>1.0 )
                    return sqrt(dot2(p-float2(0.25,0.75))) - sqrt(2.0)/4.0;
                return sqrt(min(dot2(p-float2(0.00,1.00)),
                                dot2(p-0.5*max(p.x+p.y,0.0)))) * sign(p.x-p.y);
            }

            float3 palette( in float t)
            {
                float3 a = float3(0.5, 0.5, 0.5);
                float3 b = float3(0.5, 0.5, 0.5);
                float3 c = float3(1.0, 1.0, 0.5);
                float3 d = float3(0.80, 0.90, 0.3);

                return a + b*cos( 6.28318*(c*t+d) );
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = (i.fragCoord * 2 - _ScreenParams.xy ) / _ScreenParams.y;
                uv = float2(uv.x,uv.y); //offset vertically
                float2 uv0 = uv;
                float3 finalColor = float3(0,0,0);
                
                for(float i= 0.0; i< 4.0; i++){
                    uv *= 1.5;
                    uv = frac(uv);
                    uv -= .5;

                    float3 col = palette(sdBox(uv,float2(.5,.5)) +  _Time.y *.4 + i*.4);
                    float3 col2 = palette(sdBox(uv0,float2(.5,.5)) +  _Time.y *.1 + i*.1);

                    float d = sdBox(uv,float2(.1,.1));
                    d = d * exp(-sdBox(uv,float2(.5,.5)));
                    d = sin(d*5 + _Time.y + i*.8)/5;
                    d = abs(d);
                    d = pow((.02+i*.01)/d,1.1);

                    finalColor += col * d * col2;
                }


                return float4(finalColor,1);
            }
            ENDCG
        }
    }
}
