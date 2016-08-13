<html>
  <head>
  	
    <script>
    var Matilda={};Matilda.Model=function(){function i(i){var s=[],o=5,u=[],a=[],f=0,l=0,c=0,h=0,p=0,d={};var v=function(){h=o/50};var m=function(){p=c/200};var g=function(){s=[];u=[];for(var e=0;e<o;e++){u[e]=1/o;s[e]={id:e,withWord:{},wordTotal:0}}for(w in d){y(d[w])}};var y=function(e){var t=Math.floor(Math.random()*o);e.isTopic=t;if(!s[t].withWord[e.id])s[t].withWord[e.id]=0;s[t].withWord[e.id]++;s[t].wordTotal++};var b=function(e,t,n){if(!e)return;var r={topics:s,vocab:d,documents:a};e.call(t,r,n)};this.setNumberOfTopics=function(e){o=e;v();g();return this};this.addDocument=function(e,n,r){if(e instanceof Array){if(e[0]instanceof Array){for(var i=0,o=e.length;i<o;i++){this.addDocument(e[i])}}else{var u,h={bagOfWords:[],wordCount:0,topicsCounts:[]};for(t in s){h.topicsCounts[t]=0}for(w in e){u=e[w];if(!d[u]){d[u]={id:u,isTopic:0,total:0};for(t in s){s[t].withWord[u]=0}c++;m()}y(d[u]);if(!h.topicsCounts[d[u].isTopic])h.topicsCounts[d[u].isTopic]=0;h.topicsCounts[d[u].isTopic]++;h.wordCount++;d[u].total++;l++;h.bagOfWords.push(d[u])}a.push(h);f++;b(n,r,e)}}else{throw new Error("Pre-process Your Data and Try Again.")}return this};this.train=function(e,t,n){var i,f;for(var l=0;l<e;l++){a.forEach(function(e,t){for(var n=0;n<e.wordCount;n++){f=e.bagOfWords[n];s[f.isTopic].withWord[f.id]--;s[f.isTopic].wordTotal--;i=0;for(var a=0;a<o;a++){u[a]=h+e.topicsCounts[a];u[a]*=p+s[a].withWord[f.id];u[a]/=c*h+s[a].wordTotal;i+=u[a]}f.isTopic=r(u,i);s[f.isTopic].withWord[f.id]++;s[f.isTopic].wordTotal++}for(var a=0;a<o;a++){u[a]/=i;e.topicsCounts[a]=0}e.bagOfWords.forEach(function(t){e.topicsCounts[t.isTopic]+=1})});b(t,n)}return this};this.topicCorrelations=function(){var t=e(o),r=[],i=[],s=1/(f-1),u=[];for(var l=0;l<o;l++){r[l]=0}a.forEach(function(e,t){var n=e.bagOfWords.length;i[t]=[];for(var s=0;s<o;s++){i[t][s]=Math.log((e.topicsCounts[s]+h)/(n+o*h));r[s]+=i[t][s]}});for(var l=0;l<o;l++){r[l]/=f}for(var c=0;c<f;c++){n(t,function(e,n){t[e][n]+=(i[c][e]-r[e])*(i[c][n]-r[n])},this)}console.log(r,t);n(t,function(e,n){t[e][n]*=s},this);for(var l=0;l<o;l++){u[l]=Math.sqrt(t[l][l])}n(t,function(e,n){t[e][n]/=u[e]*u[n]},this);return t};this.getWordsByTopics=function(){var e=[],t=[];for(var n=0;n<o;n++){newArray=[];for(var r in s[n].withWord){e.push([r,s[n].withWord[r]]);e.sort(function(e,t){return e[1]<t[1]?1:e[1]>t[1]?-1:0})}t[n]=e;e=[]}return t};this.getSimilarDocuments=function(e){var t=a[e].topicsCounts,n=[],r=0,i={},s;for(var o=0;o<f;o++){s=a[o].topicsCounts;for(var u=0;u<s.length;u++){r+=1/(Math.abs(t[u]-s[u])+1)}i[o]=r/s.length;r=0}for(o in i){n.push([o,i[o]]);console.log(n);n.sort(function(e,t){return e[1]<t[1]?1:e[1]>t[1]?-1:0})}return n};this.getDocuments=function(){return a};this.getTopics=function(){return s};this.getVocabulary=function(){return d};g()}var e=function(e,t){var e=e,t=t||e,n=[];for(var r=0;r<e;r++){n[r]=[];for(var i=0;i<t;i++){n[r][i]=0}}return n};var n=function(e,t,n){var r=e.length;for(var i=0;i<r;i++){for(var s=0;s<r;s++){t.call(n,i,s,e)}}};var r=function(e,t){var n=t*Math.random(),r=0;n-=e[r];while(n>0){r++;n-=e[r]}return r};return i}()
    </script>
    <script type="text/javascript">
    var stopword=["the", "and", "of", "for", "in", "a", "on", "is", "an", "this", "to", "by", "abstract", "paper", "based", "with", "or", "are", "from", "upon", "we", "us", "our", "can", "be", "using", "which", "that", "d", "n", "as", "it", "show", "these", "such", "s", "t", "i", "j", "have", "one", "new", "one", "has", "learning", "model", "data", "models", "two", "used", "results"];

      // Client ID retrieved from the Google
      // Developer Console, https://console.developers.google.com
      var CLIENT_ID = '254954454339-8d655vcm7gf2oc3lkqtff8m3ba38d480.apps.googleusercontent.com';
      var SCOPES = ['https://www.googleapis.com/auth/gmail.readonly'];
      var globallabelcount=0;
      /**
       * Check if current user has authorized this application.
       */
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

      /**
       * Load Gmail API client library. List labels once client library
       * is loaded.
       */
      function loadGmailApi() {
    	  gapi.client.load('gmail', 'v1', listLabels);
      }
    function displayMessage() {
    	var labelId="after:2014/01/01 OR ";
    	
    	var container=document.getElementById('labeloutput');
    	var cboxes=container.getElementsByTagName('input');
    	
    	
    	for(var i=0; i<cboxes.length; i++){
    		if (cboxes[i].type=='checkbox'){
    			if(cboxes[i].checked){
    				labelId+="in:"+cboxes[i].value;
    				
    				if (i<cboxes.length-1){
    	    			labelId+=" OR ";
    	    		}
    			}
    		}
    		
    	}
    	  
    	  gapi.client.load('gmail', 'v1', function listMessages() { 
    		  var getPageOfMessages = function(request, result) {
    		    request.execute(function(resp) {
    		      result = result.concat(resp.messages);
    		      var nextPageToken = resp.nextPageToken;
    		      
    		      if (nextPageToken) {
    		        request = gapi.client.gmail.users.messages.list({
    		          'userId': 'me',
    		          'pageToken': nextPageToken,
    		          'q': labelId
    		        });
    		        getPageOfMessages(request, result);
    		      } else {
    		        msgObj(result);
    		      }
    		    }); 
    		  };
    		  var initialRequest = gapi.client.gmail.users.messages.list({
    		    'userId': 'me',
    		    'q': labelId
    		  });
    		  getPageOfMessages(initialRequest, []);
    		});
    	
    	  appendPre("Fetching messages! Please wait some time and click on 'Check My Topics'' ");
      }
      function msgObj(result){
    	  for (var i = 0; i < result.length; i++) {
              var message = result[i];
              getMessage(message.id);
              document.getElementById('msgcount').innerHTML="Messages fetched:"+i;
            }
    	  document.getElementById('token-button').disabled=false;
    	  
    	  
    	 }

    //-------------code for cleaning an array-------------------------/
    function cleanText(value) {
        var temp, tarray = arguments, L = tarray.length, ax;
        while (L > 1 && value.length) {
            temp = tarray[--L];
            while ((ax= value.indexOf(temp)) !== -1) {
                value.splice(ax, 1);
            }
        }
        return value;
    }
      function getMessage(messageId) {
    	  var request = gapi.client.gmail.users.messages.get({
    	    'userId': 'me',
    	    'id': messageId
    	  });
    	  	var result = request.execute(function(resp) {
    	  	var text = resp.snippet;
    	  	text= text.replace(/\W/g," ");
    	  	text= text.replace(/\d/g,"");
    	  	text=text.toLowerCase();
    	  	appendMsg(text);
    	  	
    		 
    	  });
    	  }
      
      function getTokens(){
    	  var data = document.getElementById('msgoutput');
    	  var text= data.textContent.split(" ");
    	 
    	  var cleantext=[];
    	  var stopword=["hi", "dear", "regards", "edit", "view", "reply", "forward","the", "and", "of", "for", "in", "a", "on", "is", "an", "this", "to", "by", "abstract", "paper", "based", "with", "or", "are", "from", "upon", "we", "us", "our", "can", "be", "using", "which", "that", "d", "n", "as", "it", "show", "these", "such", "s", "t", "i", "j", "have", "one", "new", "one", "has", "learning", "model", "data", "models", "two", "used", "results"];
    		var cleantext=[]; 
    		var cleantext2=[];
    		
    		for (var st=0; st<stopword.length;st++){
    			cleantext2=cleanText(text,stopword[st]);
    		}
    		for(var x=0;x<cleantext2.length;x++){
    			if(cleantext2[x].length>3){
    				cleantext.push(cleantext2[x]);
    			}
    		}
    		
    	  var mM = new Matilda.Model();
    	  mM.addDocument(cleantext);
    	  
    	  mM.train(10);
    	  //appendPre(mM.topicCorrelations());
    	  //appendPre(mM.getDocuments());
    	  var topic = mM.getTopics();
    	 
    	  var wlist=mM.getWordsByTopics();
    	  var jobj={};
    	  for (numTopic in wlist) {
    	        
    	        jobj[numTopic] = {
    	                    topic:       numTopic,
    	                    words: {} 
    	                    };
    	      };
    	      
    	  for (var i=0; i<wlist.length; i++){
    		  var selected=[];
    		 // appendPre("");
    		  //appendPre("Topic "+i+":");
    		  jobj[i].topic=i;
    		  for(var x = 0; x< wlist[i].length;x++){
    			  var topwords = wlist[i][x];
    			  if (topwords[1]>1){
    				  
    				  //appendPre(topwords);
    				  selected.push(topwords);
    				  
    			  }
    			  
    		  }
    		  jobj[i].words=selected;  
    	  }
    	  //appendPre(jobj);
    	  var stoj=JSON.stringify(jobj);
    	  //appendPre(stoj);
    	  localStorage.setItem('userProfile',stoj);
    
    	  var JSONobj = JSON.parse(localStorage.getItem('userProfile'));
    	  appendPre("The topics for your profile are: ");
    	  
    	  for (som in JSONobj){
    		  appendPre(" ");
    		  appendPre("Topic "+JSONobj[som].topic+" :");
    		  appendPre("Word "+" How many times it occurs in your email");
    		  var wd=JSONobj[som].words;
    		  for(var w=0;w<wd.length;w++)
    		  	appendPre(wd[w][0]+"  "+wd[w][1]);
    	  }
    	  
    	  document.getElementById('toBrowse').disabled=false;
    	  
      }
      /**
       * Print all Labels in the authorized user's inbox. If no labels
       * are found an appropriate message is printed.
       */
      function listLabels() {
        var request = gapi.client.gmail.users.labels.list({
          'userId': 'me'
        });

        request.execute(function(resp) {
          var labels = resp.labels;
          var ll = [];
          labelList('Following are your Labels:-');
          labelList('Please select any and click on Fetch Messages');

          if (labels && labels.length > 0) {
            for (i = 0; i < labels.length; i++) {
              var label = labels[i];
              
              ll.push(label.name);
              
            }
            labelMenu(ll);
            globallabelcount=labels.length;
          } else {
            labelList('No Labels found.');
          }
        });
      }
      function labelMenu(listofL){
    	  
    	  for (var i=0; i< listofL.length; i++){
    		  var label= document.createElement("label");
    		  var br = document.createElement("br");
    		  
    		  var description = document.createTextNode(listofL[i]);
    		  var checkbox = document.createElement("input");

    		  checkbox.type = "checkbox";    // make the element a checkbox
    		  checkbox.name = "slct";      // give it a name we can check on the server side
    		  checkbox.value = listofL[i];    // make its value "pair"
				//appendPre(checkbox.name);
    		  label.appendChild(checkbox);   // add the box to the element
    		  label.appendChild(description);// add the description to the element

    		  // add the label element to your div
    		  document.getElementById('labeloutput').appendChild(label);
    		  document.getElementById('labeloutput').appendChild(br);
    	  }
    	  document.getElementById('labeloutput').appendChild(document.createTextNode("Please select at least one of the above folders."+'\n'));
    	  document.getElementById('labeloutput').appendChild(document.createTextNode("(For best results, we recommend including Inbox and Sent folders.)"));
    	  
      }
      function appendPre(message) {
    	  var pre = document.getElementById('output');
    	  var textContent = document.createTextNode(message + '\n');
    	  pre.appendChild(textContent);
    	}
      function appendMsg(message) {
    	  var pre = document.getElementById('msgoutput');
    	  var textContent = document.createTextNode(message + '\n');
    	  pre.appendChild(textContent);
    	}
      function labelList(message) {
    	  var pre = document.getElementById('labeloutput');
    	  var textContent = document.createTextNode(message + '\n');
    	  pre.appendChild(textContent);
    	}

    </script>
    <script src="https://apis.google.com/js/client.js?onload=checkAuth">
    </script>

  </head>
  <body>
    <div id="authorize-div" style="display: none">
      <span>Authorize access to Gmail API</span>
      <!--Button for the user to click to initiate auth sequence -->
      <button id="authorize-button" onclick="handleAuthClick(event)">
        Authorize
      </button>
    </div>
    <a href="https://accounts.google.com/logout"><button id="logoutbutton">Log out</button></a>
    <pre id="labeloutput"></pre>
    <pre id="msgoutput" style="display: none"></pre>
    <pre id="msgcount"></pre>
    <button id="message-button" onclick="displayMessage()">
    	Fetch My Messages
    </button>
    <button id="token-button" onclick="getTokens()" disabled>
    	Check My Topics
    </button>
    <button id="toBrowse" onclick="location.href='browse.jsp';" disabled>Continue</button>
    <pre id="output"></pre>
    
    
  </body>
</html>