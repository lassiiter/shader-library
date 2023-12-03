using UnityEngine;
using System.Collections;
using System.Collections.Generic;
[ExecuteInEditMode]
public class EdgeDetectionCamera : MonoBehaviour {
 
    public Material material;
    void OnEnable()
    {
        Camera.main.depthTextureMode = DepthTextureMode.DepthNormals;
    }

    void OnRenderImage(RenderTexture src, RenderTexture dest) {
        Graphics.Blit(src, dest, material);
    }
}