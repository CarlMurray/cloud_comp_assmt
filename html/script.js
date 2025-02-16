const form = document.querySelector("form");
const fileInputField = document.querySelector('[name="file"]');

form.addEventListener("submit", async (e) => {
  e.preventDefault();
  const responseText = await uploadFile();
});

async function uploadFile() {
  const file = fileInputField.files[0];
  //TODO: Add key field
  console.log(file);

  const res = await fetch(
    "https://cloud-computing-bucket-17.s3.eu-west-1.amazonaws.com/test2?X-Amz-Expires=21600&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAQ3EGUE4T5AL6AXEW/20250215/eu-west-1/s3/aws4_request&X-Amz-Date=20250215T235322Z&X-Amz-SignedHeaders=content-type;host&X-Amz-Signature=d883a9e38e4f8b8f36ee6ab013e8c67738c5ca774a4d7171bbc16a07d42fc537",
    {
      method: "PUT",
      headers: {
        "Content-Type": file.type, //TODO: send file type to backend to ensure identical
      },
      body: file,
    }
  );

  return res.text();
}
