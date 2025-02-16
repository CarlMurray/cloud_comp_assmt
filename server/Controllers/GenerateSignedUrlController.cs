using Microsoft.AspNetCore.Mvc;
using Amazon;
using Amazon.S3;
using Amazon.Runtime;

namespace server.Controllers;

[ApiController]
[Route("[controller]")]
public class GenerateSignedUrlController : ControllerBase
{

    // TODO: get key, bucket name, other request details from client first to ensure consistent

    [HttpPost]
    public string GenerateSignedUrl()
    {
        AWSConfigsS3.UseSignatureVersion4 = true;
        var client = new AmazonS3Client(RegionEndpoint.EUWest1);
        var request = new Amazon.S3.Model.GetPreSignedUrlRequest
        {
            BucketName = "cloud-computing-bucket-17",
            Key = "test2",
            // Key = Guid.NewGuid().ToString(),
            Expires = DateTime.Now.AddHours(6),
            Verb = HttpVerb.PUT,
            ContentType = "text/rtf"
        };
        return client.GetPreSignedURL(request);
    }
}
