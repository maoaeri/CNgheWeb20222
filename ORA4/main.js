const CLIENT_ID =
  "45635664999-63aoemlc7t0klnr338rn9ut3pvf6vivn.apps.googleusercontent.com";
const API_KEY = "AIzaSyAJ7M9F9VurXGGZVUF4jwNHlFSwCHckKiI";

// Discovery doc URL for APIs used by the quickstart
const DISCOVERY_DOC =
  "https://www.googleapis.com/discovery/v1/apis/gmail/v1/rest";

// Authorization scopes required by the API; multiple scopes can be
// included, separated by spaces.
const SCOPES = "https://www.googleapis.com/auth/gmail.readonly";

let tokenClient;
let gapiInited = false;
let gisInited = false;
let nextPageToken = undefined;
document.getElementById("loading").style.display = "flex";
document.getElementById("app").style.display = "none";
document.getElementById("mailCompose").style.display = "none";

function showCreateMailForm() {
  document.getElementById("mailCompose").style.display = "block";
}
function closeCreateMailForm() {
  document.getElementById("mailCompose").style.display = "none";
}
/**
 * Callback after api.js is loaded.
 */
function gapiLoaded() {
  gapi.load("client", initializeGapiClient);
}

/**
 * Callback after the API client is loaded. Loads the
 * discovery doc to initialize the API.
 */
async function initializeGapiClient() {
  await gapi.client.init({
    apiKey: API_KEY,
    discoveryDocs: [DISCOVERY_DOC],
  });
  gapiInited = true;
  maybeEnableButtons();
}

/**
 * Callback after Google Identity Services are loaded.
 */
function gisLoaded() {
  tokenClient = google.accounts.oauth2.initTokenClient({
    client_id: CLIENT_ID,
    scope: SCOPES,
    callback: "", // defined later
  });
  gisInited = true;
  maybeEnableButtons();
}

/**
 * Enables user interaction after all libraries are loaded.
 */
function maybeEnableButtons() {
  if (gapiInited && gisInited) {
    document.getElementById("loading").classList.add = "hidden";
  }
}

/**
 *  Sign in the user upon button click.
 */
function handleAuthClick() {
  tokenClient.callback = async (resp) => {
    if (resp.error !== undefined) {
      throw resp;
    }
    console.log(resp);
    document.getElementById("loading").style.display = "none";
    document.getElementById("app").style.display = "flex";
    await getData();
  };

  if (gapi.client.getToken() === null) {
    // Prompt the user to select a Google Account and ask for consent to share their data
    // when establishing a new session.
    tokenClient.requestAccessToken({ prompt: "consent" });
  } else {
    // Skip display of account chooser and consent dialog for an existing session.
    tokenClient.requestAccessToken({ prompt: "" });
  }
}

/**
 *  Sign out the user upon button click.
 */
function handleSignoutClick() {
  const token = gapi.client.getToken();
  if (token !== null) {
    google.accounts.oauth2.revoke(token.access_token);
    gapi.client.setToken("");
    document.getElementById("content").innerText = "";
    document.getElementById("authorize_button").innerText = "Authorize";
    document.getElementById("signout_button").style.visibility = "hidden";
  }
}
async function reload() {
  let table = document.getElementById("mailTable");
  table.innerHTML = "";
  await getData();
}
async function getData(pageToken) {
  let response;
  try {
    response = await gapi.client.gmail.users.messages.list({
      userId: "me",
      maxResults: 10,
      pageToken: pageToken,
    });
  } catch (err) {
    document.getElementById("content").innerText = err.message;
    return;
  }
  const messages = response.result.messages;
  nextPageToken = response.result?.nextPageToken;
  if (!messages || messages.length == 0) {
    document.getElementById("content").innerText = "No massages found.";
    return;
  }
  for (var i = 0; i < messages.length; i++) {
    await gapi.client.gmail.users.messages
      .get({
        userId: "me",
        id: messages[i].id,
      })
      .then(function (resp) {
        var headers = resp.result.payload.headers;
        var id = resp.result.id;
        var subject = "";
        var from = "";
        var date = "";
        for (var j = 0; j < headers.length; j++) {
          if (headers[j].name === "From") {
            from = headers[j].value;
          }
          if (headers[j].name === "Date") {
            date = headers[j].value;
          }
          if (headers[j].name === "Subject") {
            subject = headers[j].value;
          }
        }
        addRowToMailTable(id, from, subject, date);
      });
  }
}
async function fetchMorePost() {
  if (nextPageToken) {
    await getData(nextPageToken);
  }
}
async function addRowToMailTable(id, from, subject, date) {
  let table = document.getElementById("mailTable");

  const item = document.createElement("div");
  item.innerHTML = ` <div
  class="border-b border-gray-200 cursor-pointer bg-gray-200/80"
>
  <div
    class="flex flex-row items-center space-x-4 py-2 px-4 max-w-full"
  >
    <div>
      <input type="checkbox" />
    </div>
    <div>
      <div>
        <svg
          class="w-4 h-4 text-gray-500"
          viewBox="0 0 24 24"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            d="M11.0489 4.92705C11.3483 4.00574 12.6517 4.00574 12.9511 4.92705L14.2451 8.90983C14.379 9.32185 14.763 9.60081 15.1962 9.60081H19.3839C20.3527 9.60081 20.7554 10.8404 19.9717 11.4098L16.5838 13.8713C16.2333 14.126 16.0866 14.5773 16.2205 14.9894L17.5146 18.9721C17.8139 19.8934 16.7595 20.6596 15.9757 20.0902L12.5878 17.6287C12.2373 17.374 11.7627 17.374 11.4122 17.6287L8.02426 20.0902C7.24054 20.6596 6.18607 19.8934 6.48542 18.9721L7.7795 14.9894C7.91338 14.5773 7.76672 14.126 7.41623 13.8713L4.02827 11.4098C3.24456 10.8404 3.64734 9.60081 4.61606 9.60081H8.8038C9.23703 9.60081 9.62099 9.32185 9.75486 8.90983L11.0489 4.92705Z"
            stroke="currentColor"
            fill
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          />
        </svg>
      </div>
    </div>
    <div>
      <div class="w-36 max-w-36">
        <p
          class="line-clamp-1 text-sm"
        >${from}</p>
      </div>
    </div>
    <div class="flex-1">
      <p
        class="line-clamp-1 text-sm"
      >${subject}</p>
    </div>
    <div>
      <p
        class="text-sm"
      >${date}</p>
    </div>
  </div>
</div>`;
  item.onclick = () => {
    displayMailContent(id);
  };
  table.appendChild(item);
}

// Hiển thị nội dung mail
function displayMailContent(id) {
  gapi.client.gmail.users.messages
    .get({
      userId: "me",
      id: id,
    })
    .then(function (resp) {
      try {
        console.log(resp);
        var message = resp.result;
        var body = message.payload.parts[0].body.data;
        parsedMessage = parseMessage(resp.result);
        console.log(parsedMessage);
        var mailHeader = document.getElementById("mailHeader");
        var mailContent = document.getElementById("mailContent");
        mailHeader.innerHTML = "";
        mailHeader.innerHTML = `<div class="px-8">
        <h1 class="text-xl">${parsedMessage.headers.subject}</h1>
        <div>
          <div
            class="px-[0.25rem] rounded bg-neutral-200 text-gray-800 text-xs w-fit"
          >
            Inbox
          </div>
        </div>
        <div class="flex flex-row space-x-4 items-center">
          <div class="flex flex-col justify-between py-2">
            <div>
              <p
                class="font-medium text-sm"
              >${parsedMessage.headers.from}</p>
            </div>
            <div>
              <p class="text-xs text-gray-700">to me</p>
            </div>
          </div>
          <div
            class="flex-1 flex flex-col justify-between items-end py-2"
          >
            <div class="flex flex-row items-center space-x-2">
              <div>
                <p
                  class="text-gray-500 text-xs"
                  
                >${parsedMessage.headers.date}</p>
              </div>
              <div>
                <div
                  class="w-4 h-4 bg-no-repeat bg-contain"
                  style="
                    background-image: url('https://www.gstatic.com/images/icons/material/system_gm/1x/star_border_black_20dp.png');
                  "
                ></div>
              </div>

              <div>
                <div
                  class="w-4 h-4 bg-no-repeat bg-contain"
                  style="
                    background-image: url('//ssl.gstatic.com/ui/v1/icons/mail/gm3/1x/reply_baseline_nv700_20dp.png');
                  "
                ></div>
              </div>

              <div>
                <div
                  class="w-4 h-4 bg-no-repeat bg-contain"
                  style="
                    background-image: url('//ssl.gstatic.com/ui/v1/icons/mail/gm3/1x/more_vert_baseline_nv700_20dp.png');
                  "
                ></div>
              </div>
            </div>
            <div>
              <p
                class="font-medium text-sm opacity-0"
                x-text="postContent.author"
              ></p>
            </div>
          </div>
        </div>
        <a
          :href="postContent.url"
          target="_blank"
          class="text-sm text-blue-500 underline pl-14 line-clamp-1"
          x-text="postContent.url"
        ></a>
      </div>`;
        mailContent.innerHTML = parsedMessage?.textHtml
          ? parsedMessage.textHtml
          : parsedMessage.textPlain;
      } catch (error) {}
    });
}

function getHeader(headers, index) {
  var header = "";

  $.each(headers, function () {
    if (this.name === index) {
      header = this.value;
    }
  });
  return header;
}

function getBody(message) {
  var encodedBody = "";
  if (typeof message.parts === "undefined") {
    encodedBody = message.body.data;
  } else {
    encodedBody = getHTMLPart(message.parts);
  }
  encodedBody = encodedBody
    .replace(/-/g, "+")
    .replace(/_/g, "/")
    .replace(/\s/g, "");
  return decodeURIComponent(escape(window.atob(encodedBody)));
}

function getHTMLPart(arr) {
  for (var x = 0; x <= arr.length; x++) {
    if (typeof arr[x].parts === "undefined") {
      if (arr[x].mimeType === "text/html") {
        return arr[x].body.data;
      }
    } else {
      return getHTMLPart(arr[x].parts);
    }
  }
  return "";
}

function urlB64Decode(string) {
  return string
    ? decodeURIComponent(
        escape(window.atob(string.replace(/\-/g, "+").replace(/\_/g, "/")))
      )
    : "";
}

function indexHeaders(headers) {
  if (!headers) {
    return {};
  } else {
    return headers.reduce(function (result, header) {
      result[header.name.toLowerCase()] = header.value;
      return result;
    }, {});
  }
}

function parseMessage(response) {
  var result = {
    id: response.id,
    threadId: response.threadId,
    labelIds: response.labelIds,
    snippet: response.snippet,
    historyId: response.historyId,
  };
  if (response.internalDate) {
    result.internalDate = parseInt(response.internalDate);
  }

  var payload = response.payload;
  if (!payload) {
    return result;
  }

  var headers = indexHeaders(payload.headers);
  result.headers = headers;

  var parts = [payload];
  var firstPartProcessed = false;

  while (parts.length !== 0) {
    var part = parts.shift();
    if (part.parts) {
      parts = parts.concat(part.parts);
    }
    if (firstPartProcessed) {
      headers = indexHeaders(part.headers);
    }

    if (!part.body) {
      continue;
    }

    var isHtml = part.mimeType && part.mimeType.indexOf("text/html") !== -1;
    var isPlain = part.mimeType && part.mimeType.indexOf("text/plain") !== -1;
    var isAttachment = Boolean(
      part.body.attachmentId ||
        (headers["content-disposition"] &&
          headers["content-disposition"].toLowerCase().indexOf("attachment") !==
            -1)
    );
    var isInline =
      headers["content-disposition"] &&
      headers["content-disposition"].toLowerCase().indexOf("inline") !== -1;

    if (isHtml && !isAttachment) {
      result.textHtml = urlB64Decode(part.body.data);
    } else if (isPlain && !isAttachment) {
      result.textPlain = urlB64Decode(part.body.data);
    } else if (isAttachment) {
      var body = part.body;
      if (!result.attachments) {
        result.attachments = [];
      }
      result.attachments.push({
        filename: part.filename,
        mimeType: part.mimeType,
        size: body.size,
        attachmentId: body.attachmentId,
        headers: indexHeaders(part.headers),
      });
    } else if (isInline) {
      var body = part.body;
      if (!result.inline) {
        result.inline = [];
      }
      result.inline.push({
        filename: part.filename,
        mimeType: part.mimeType,
        size: body.size,
        attachmentId: body.attachmentId,
        headers: indexHeaders(part.headers),
      });
    }

    firstPartProcessed = true;
  }

  return result;
}

async function sendMail() {
  var to = document.getElementById("to").value;
  var subject = document.getElementById("subject").value;
  var message = document.getElementById("content").value;
  var file = document.getElementById("attachment").files[0];
  if (!to || !subject || !message) {
    alert("Nhập đủ các trường bắt buộc");
    return;
  } else {
    const messageParts = [
      "MIME-Version: 1.0",
      "To: " + to,
      "Subject: " + subject,
      'Content-Type: multipart/mixed; boundary="my_boundary"',
      "",
      "--my_boundary",
      'Content-Type: text/plain; charset="UTF-8"',
      "",
      message + "\r\n",
      "",
      // Attachments
    ];
    if (file) {
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = async function () {
        var attachment = reader.result.split(",")[1];
        var attachmentName = file.name;
        var attachmentType = file.type;
        messageParts.push(
          "--my_boundary",
          "Content-Type: " + attachmentType + '; name="' + attachmentName + '"',
          'Content-Disposition: attachment; filename="' + attachmentName + '"',
          "Content-Transfer-Encoding: base64",
          "",
          attachment,
          ""
        );
        messageParts.push("--my_boundary--");
        const encodedMessage = btoa(messageParts.join("\r\n"));

        await gapi.client.gmail.users.messages
          .send({
            userId: "me",
            resource: {
              raw: encodedMessage,
            },
          })
          .then((message) => {
            alert("Đã gửi mail thành công!");
            document.getElementById("to").value = "";
            document.getElementById("subject").value = "";
            document.getElementById("message").value = "";
            document.getElementById("attachment").value = "";
          });
      };
    } else {
      messageParts.push("--my_boundary--");
      const encodedMessage = btoa(messageParts.join("\r\n"));

      await gapi.client.gmail.users.messages
        .send({
          userId: "me",
          resource: {
            raw: encodedMessage,
          },
        })
        .then((message) => {
          alert("Đã gửi mail thành công!");
          document.getElementById("to").value = "";
          document.getElementById("subject").value = "";
          document.getElementById("message").value = "";
          document.getElementById("attachment").value = "";
        });
    }
  }
}
