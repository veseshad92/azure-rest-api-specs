import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./common.tsp";
import "./deployment.tsp";
import "./file.tsp";
import "./finetune.tsp";
import "./model.routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> |
    OAuth2Auth<[{
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://cognitiveservices.azure.com/.default"]
    }]>)
@service({title: "Azure OpenAI API"})
@versioned(Azure.OpenAI.Versions)
@server(
  "{endpoint}/openai",
  "API for managing and utilizing Azure Open AI endpoints",
  {
    @doc("""
Supported Cognitive Services endpoints (protocol and hostname, for example:
https://westus.api.cognitive.microsoft.com).
""")
    endpoint: string,
  }
)
@doc("API for managing and utilizing Azure Open AI endpoints")
namespace Azure.OpenAI;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_06_01_preview: "2022-06-01-preview",
}