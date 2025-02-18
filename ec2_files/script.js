const form = document.querySelector("form");
const keyInputField = document.querySelector('[name="key"]');
const fileInputField = document.querySelector('[name="file"]');
const bucketInputField = document.querySelector('[name="bucket"]');

form.addEventListener("submit", async (e) => {
  e.preventDefault();
  const responseText = await uploadFile();
});

async function uploadFile() {
  const file = fileInputField.files[0];
  const key = keyInputField.value;
  const bucket = bucketInputField.value;

  const preSignedUrl = await getPresignedUrl(file, key, bucket);

  const res = await fetch(preSignedUrl, {
    method: "PUT",
    headers: {
      "Content-Type": file.type,
    },
    body: { file: file, key: key, bucket: bucket },
  });

  return res.text();
}

async function getPresignedUrl(file, key, bucket) {
  ENV_DEV_URL = "http://localhost:5191/GenerateSignedUrl"; // for local dev
  ENV_DEV_PRD = "http://server:5191/GenerateSignedUrl"; // production server hostname
  const res = await fetch(ENV_DEV_PRD, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      contentType: file.type,
      key: key,
      bucket: bucket,
    }),
  });
  return res.text();
}

async function getMetadata() {
  const res = await fetch(`${window.location.origin}/metadata.html`);
  const data = res.text();
  return data;
}

async function main() {
  const metadata = (document.createElement("div").innerHTML =
    await getMetadata());
  const metadataContainer = document.getElementById("metadata");
  metadataContainer.innerHTML = metadata;
}
main();
