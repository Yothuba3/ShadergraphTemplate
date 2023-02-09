using UnityEngine;

[ExecuteInEditMode, RequireComponent(typeof(Renderer))]
public class RaymarchingObject : MonoBehaviour
{

    private Material material_;
    private int scaleId_;

    void Awake()
    {
        material_ = GetComponent<Renderer>().material;
        scaleId_ = Shader.PropertyToID("Scale");
    }
    
    void Update()
    {
        material_.SetVector(scaleId_, transform.localScale);
    }
}