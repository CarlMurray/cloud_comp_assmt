using Microsoft.AspNetCore.Mvc;
using Amazon;
using Amazon.S3;
using Amazon.Runtime;
using System.Text.Json;

namespace server.Controllers;

[ApiController]
[Route("[controller]")]
public class GenerateSignedUrlController : ControllerBase
{
    [HttpPost]
    public async Task<string> GenerateSignedUrl()
    {
        AWSConfigsS3.UseSignatureVersion4 = true;

        Dictionary<string, string> body;
        using (var reader = new StreamReader(Request.Body))
        {
            body = JsonSerializer.Deserialize<Dictionary<string, string>>(await reader.ReadToEndAsync())!;
        }
        var client = new AmazonS3Client(RegionEndpoint.EUWest1);
        var request = new Amazon.S3.Model.GetPreSignedUrlRequest
        {
            BucketName = body["bucket"],
            Key = body["key"],
            // Key = Guid.NewGuid().ToString(),
            Expires = DateTime.Now.AddHours(6),
            Verb = HttpVerb.PUT,
            ContentType = body["contentType"]
        };
        return client.GetPreSignedURL(request);
    }
}
