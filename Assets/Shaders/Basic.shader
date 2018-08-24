Shader "Unlit/Basic"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Tint("Color Tint",Color)= (1,1,1,1)
	}
	SubShader
	{

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct Input
			{
				float4 vertex : POSITION;
				float4 uv : TEXCOORD0;


			};

			struct v2f
			{
				float4 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float3 wpos : TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _Tint;
			
			
			v2f vert (Input v)
			{
				v2f o;
				v.vertex = float4(v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w);
				o.vertex = UnityObjectToClipPos(v.vertex);
				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.wpos = worldPos;
				o.uv = v.uv;
				
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{

				fixed4 col = tex2D(_MainTex, i.uv);
			
			if (abs(i.wpos.y) % 0.2<=0.01)
			{
				col = col * float4(1, 0, 0, 1);
				}
			else
			{
				col = col * float4(0, 0, 1, 1);
			}
				
				return col;
			}
			ENDCG
		}
	}
}
