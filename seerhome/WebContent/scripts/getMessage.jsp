<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
function checkAuth() {
    gapi.auth.authorize(
      {
        'client_id': CLIENT_ID,
        'scope': SCOPES.join(' '),
        'immediate': false
      }, handleAuthResult);
  }

  /**
   * Handle response from authorization server.
   *
   * @param {Object} authResult Authorization result.
   */
  function handleAuthResult(authResult) {
    var authorizeDiv = document.getElementById('authorize-div');
    if (authResult && !authResult.error) {
      // Hide auth UI, then load client library.
      authorizeDiv.style.display = 'none';
      loadGmailApi();
    } else {
      // Show auth UI, allowing the user to initiate authorization by
      // clicking authorize button.
      authorizeDiv.style.display = 'inline';
    }
  }
   
  /**
   * Initiate auth flow in response to user clicking authorize button.
   *
   * @param {Event} event Button click event.
   */
  function handleAuthClick(event) {
    gapi.auth.authorize(
      {client_id: CLIENT_ID, scope: SCOPES, immediate: false},
      handleAuthResult);
    return false;
  }
   function loadGmailApi() {
	   gapi.client.load('gmail', 'v1', function listMessages() {
		   
	   
	  var getPageOfMessages = function(request, result) {
	    request.execute(function(resp) {
	      result = result.concat(resp.messages);
	      var nextPageToken = resp.nextPageToken;
	      if (nextPageToken) {
	        request = gapi.client.gmail.users.messages.list({
	          'userId': 'me',
	          'pageToken': nextPageToken,
	          'q': 'after:2014/01/01'
	        });
	        appendPre(getPageOfMessages(request, result));
	      } else {
	        callback(result);
	      }
	    });
	  };
	  var initialRequest = gapi.client.gmail.users.messages.list({
	    'userId': 'me',
	    'q': 'after:2014/01/01'
	  });
	  appendPre(getPageOfMessages(initialRequest, []));
	});
   }
    
/**
 * Append a pre element to the body containing the given message
 * as its text node.
 *
 * @param {string} message Text to be placed in pre element.
 */
 
function msgObj(uId,mId){
	 appendPre(uId);
	 appendPre(mId);
 }
function appendPre(message) {
  var pre = document.getElementById('output');
  var textContent = document.createTextNode(message + '\n');
  pre.appendChild(textContent);
}
</script>
</head>
<body>
<pre id="output"></pre>
</body>
</html>