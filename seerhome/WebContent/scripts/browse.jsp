<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rank Web Page</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	//Minified version of Matilda :- https://github.com/JDvorak/Matilda.js
    var Matilda={};Matilda.Model=function(){function i(i){var s=[],o=5,u=[],a=[],f=0,l=0,c=0,h=0,p=0,d={};var v=function(){h=o/50};var m=function(){p=c/200};var g=function(){s=[];u=[];for(var e=0;e<o;e++){u[e]=1/o;s[e]={id:e,withWord:{},wordTotal:0}}for(w in d){y(d[w])}};var y=function(e){var t=Math.floor(Math.random()*o);e.isTopic=t;if(!s[t].withWord[e.id])s[t].withWord[e.id]=0;s[t].withWord[e.id]++;s[t].wordTotal++};var b=function(e,t,n){if(!e)return;var r={topics:s,vocab:d,documents:a};e.call(t,r,n)};this.setNumberOfTopics=function(e){o=e;v();g();return this};this.addDocument=function(e,n,r){if(e instanceof Array){if(e[0]instanceof Array){for(var i=0,o=e.length;i<o;i++){this.addDocument(e[i])}}else{var u,h={bagOfWords:[],wordCount:0,topicsCounts:[]};for(t in s){h.topicsCounts[t]=0}for(w in e){u=e[w];if(!d[u]){d[u]={id:u,isTopic:0,total:0};for(t in s){s[t].withWord[u]=0}c++;m()}y(d[u]);if(!h.topicsCounts[d[u].isTopic])h.topicsCounts[d[u].isTopic]=0;h.topicsCounts[d[u].isTopic]++;h.wordCount++;d[u].total++;l++;h.bagOfWords.push(d[u])}a.push(h);f++;b(n,r,e)}}else{throw new Error("Pre-process Your Data and Try Again.")}return this};this.train=function(e,t,n){var i,f;for(var l=0;l<e;l++){a.forEach(function(e,t){for(var n=0;n<e.wordCount;n++){f=e.bagOfWords[n];s[f.isTopic].withWord[f.id]--;s[f.isTopic].wordTotal--;i=0;for(var a=0;a<o;a++){u[a]=h+e.topicsCounts[a];u[a]*=p+s[a].withWord[f.id];u[a]/=c*h+s[a].wordTotal;i+=u[a]}f.isTopic=r(u,i);s[f.isTopic].withWord[f.id]++;s[f.isTopic].wordTotal++}for(var a=0;a<o;a++){u[a]/=i;e.topicsCounts[a]=0}e.bagOfWords.forEach(function(t){e.topicsCounts[t.isTopic]+=1})});b(t,n)}return this};this.topicCorrelations=function(){var t=e(o),r=[],i=[],s=1/(f-1),u=[];for(var l=0;l<o;l++){r[l]=0}a.forEach(function(e,t){var n=e.bagOfWords.length;i[t]=[];for(var s=0;s<o;s++){i[t][s]=Math.log((e.topicsCounts[s]+h)/(n+o*h));r[s]+=i[t][s]}});for(var l=0;l<o;l++){r[l]/=f}for(var c=0;c<f;c++){n(t,function(e,n){t[e][n]+=(i[c][e]-r[e])*(i[c][n]-r[n])},this)}console.log(r,t);n(t,function(e,n){t[e][n]*=s},this);for(var l=0;l<o;l++){u[l]=Math.sqrt(t[l][l])}n(t,function(e,n){t[e][n]/=u[e]*u[n]},this);return t};this.getWordsByTopics=function(){var e=[],t=[];for(var n=0;n<o;n++){newArray=[];for(var r in s[n].withWord){e.push([r,s[n].withWord[r]]);e.sort(function(e,t){return e[1]<t[1]?1:e[1]>t[1]?-1:0})}t[n]=e;e=[]}return t};this.getSimilarDocuments=function(e){var t=a[e].topicsCounts,n=[],r=0,i={},s;for(var o=0;o<f;o++){s=a[o].topicsCounts;for(var u=0;u<s.length;u++){r+=1/(Math.abs(t[u]-s[u])+1)}i[o]=r/s.length;r=0}for(o in i){n.push([o,i[o]]);console.log(n);n.sort(function(e,t){return e[1]<t[1]?1:e[1]>t[1]?-1:0})}return n};this.getDocuments=function(){return a};this.getTopics=function(){return s};this.getVocabulary=function(){return d};g()}var e=function(e,t){var e=e,t=t||e,n=[];for(var r=0;r<e;r++){n[r]=[];for(var i=0;i<t;i++){n[r][i]=0}}return n};var n=function(e,t,n){var r=e.length;for(var i=0;i<r;i++){for(var s=0;s<r;s++){t.call(n,i,s,e)}}};var r=function(e,t){var n=t*Math.random(),r=0;n-=e[r];while(n>0){r++;n-=e[r]}return r};return i}()
</script>
<script type="text/javascript"> 
var dislike = false;
var ulinks=[];
var linknum=0.0;
var jsubs=0.0;
var pagewords=0.0;
var supermult=0.0;
var stopword=["the", "and", "of", "for", "in", "a", "on", "is", "an", "this", "to", "by", "abstract", "paper", "based", "with", "or", "are", "from", "upon", "we", "us", "our", "can", "be", "using", "which", "that", "d", "n", "as", "it", "show", "these", "such", "s", "t", "i", "j", "have", "one", "new", "one", "has", "learning", "model", "data", "models", "two", "used", "results"];

//Following function by :- https://gist.github.com/orfeomorello/8182024
//It takes in a url and returns the html content of that url. Uses yahoo api.
jQuery.ajax = (function(_ajax){

    var protocol = location.protocol,
        hostname = location.hostname,
        exRegex = RegExp(protocol + '//' + hostname),
        YQL = 'http' + (/^https/.test(protocol)?'s':'') + '://query.yahooapis.com/v1/public/yql?callback=?',
        query = 'select * from html where url="{URL}" and xpath="*"';

    function isExternal(url) {
        return !exRegex.test(url) && /:\/\//.test(url);
    }

    return function(o) {

        var url = o.url;

        if ( /get/i.test(o.type) && !/json/i.test(o.dataType) && isExternal(url) ) {

            // Manipulate options so that JSONP-x request is made to YQL

            o.url = YQL;
            o.dataType = 'json';

            o.data = {
                q: query.replace(
                    '{URL}',
                    url + (o.data ?
                        (/\?/.test(url) ? '&' : '?') + jQuery.param(o.data)
                    : '')
                ),
                format: 'xml'
            };

            // Since it's a JSONP request
            // complete === success
            if (!o.success && o.complete) {
                o.success = o.complete;
                delete o.complete;
            }

            o.success = (function(_success){
                return function(data) {

                    if (_success) {
                        // Fake XHR callback.
                        _success.call(this, {
                            responseText: data.results[0]
                                // YQL screws with <script>s
                                // Get rid of them
                                .replace(/<script[^>]+?\/>|<script(.|\s)*?\/script>/gi, '')
                        }, 'success');
                    }

                };
            })(o.success);

        }

        return _ajax.apply(this, arguments);

    };

})(jQuery.ajax);

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
var alllinks=[];
//-------------code for fetching main url data-------------------------/
function createMainDiv(responsetext){
	var divbody = document.getElementById('urlmaintext');
    var div = document.createElement('div');
    
    div.innerHTML = responsetext; 
    
    divbody.appendChild(div);
    getMText();
    
    //Now we search for links in main url and fetch them ALL.
    
    var uelems=divbody.getElementsByTagName("a");
    //appendPre(uelems.length);
    var defaultext="http://localhost:8080/";
    //var defaultext="http://95.85.19.170:8080/";
    for(var i=0;i<uelems.length;i++){
    	var ltext=uelems[i].href;
    	if(ltext.indexOf(defaultext)>-1){
    		continue;
    	}
    	else{	
    		//appendPre(ltext);
        	if (ltext.length>10){
        		linknum+=1;
        		alllinks.push(ltext);
        		//save each hyperlink
        		//ulinks.push(ltext);
        	}
    	}
    	
    }
  //Normlize the number of links to use, depending on size of text in main url
    
    //appendPre("Links on page:"+linknum);
    linknum=(pagewords/linknum);
    //appendPre("Links considered:"+linknum);
    
    newUrl();
    //mainMult();
    
    
}
function newUrl(){
	document.getElementById('urlscore').innerHTML='';
	for(var i=0;i<linknum;i++){
    	var link=alllinks[Math.floor(Math.random()*alllinks.length)];
    	link=link.toString();
    	ulinks.push(link);
    	$.get(link, function(response) { 
    		var text= response;
    		for(sum in text){
    			createSubDiv(text[sum]);
    		}
    	});
    }
}

//-------------code for fetching individual url data-------------------------/
function createSubDiv(responsetext)
{
	var divbody = document.getElementById('urlsubtext');
    var div = document.createElement('div');
    
    div.innerHTML = responsetext; 
    divbody.appendChild(div);
    
    //appendPre("PostLink number:"+linknum);
    if(jsubs<linknum){
    	getSText(jsubs++);
    }
    //appendPre("Jsub"+jsubs);
    
}
//-------------code for main url topic modelling-------------------------/
//clean the text
function getMText(){
	var divtext = document.getElementById('urlmaintext').textContent.toLowerCase();
	divtext=divtext.replace(/\W/g," ");
	divtext=divtext.replace(/\d/g,"");
	var text = divtext.split(" ");
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
	getmainurltopics(cleantext);
	document.getElementById('urlmaintext').value="";
	
}
//get the topics
function getmainurltopics(urltext){
	  var mM = new Matilda.Model();
	  mM.addDocument(urltext);
	  mM.train(10);
	  var wlist=mM.getWordsByTopics();
	  var jobj={};
	  //Create a JSON object
	  for (numTopic in wlist) {
		  
	        jobj[numTopic] = {
	                    topic:       numTopic,
	                    words: {} 
	                    };
	      };
	      
	  for (var i=0; i<wlist.length; i++){
		  var selected=[];
		  
		  jobj[i].topic=i;
		  for(var x = 0; x< wlist[i].length;x++){
			  var topwords = wlist[i][x];
			  if (topwords[1]>1){
				  
				  selected.push(topwords);
				  pagewords+=1;
			  }
		  }
		  jobj[i].words=selected;
		  
	  }
	 // appendPre("JSON Object:");
	  //pagewords=jobj.toString().length;
	  //appendPre("Pagewords"+pagewords);
	  //Save topics as JSON
	  var stoj=JSON.stringify(jobj);
	 // appendPre(stoj);
	  localStorage.setItem('urlProfile',stoj);
	  appendPre("We have analyzed the above URL successfully! Click on buttons below to see recommendation results: ");
}
//-------------code for sub url topic modelling-------------------------/
//Clean the text
function getSText(jval){
	var divtext = document.getElementById('urlsubtext').textContent.toLowerCase();
	divtext=divtext.replace(/\W/g," ");
	divtext=divtext.replace(/\d/g,"");
	var text = divtext.split(" ");
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
	getsuburltopics(cleantext,jval);
	
	document.getElementById('urlsubtext').value="";
	
}
//get the topics
function getsuburltopics(urltext,unum){
	  var mM = new Matilda.Model();
	  mM.addDocument(urltext);
	  mM.train(10);
	  var wlist=mM.getWordsByTopics();
	  var jobj={};
	  //Create JSON Object
	  for (numTopic in wlist) {
	        
	        jobj[numTopic] = {
	                    topic:       numTopic,
	                    words: {} 
	                    };
	      };
	      
	  for (var i=0; i<wlist.length; i++){
		  var selected=[];
		  
		  jobj[i].topic=i;
		  for(var x = 0; x< wlist[i].length;x++){
			  var topwords = wlist[i][x];
			  if (topwords[1]>1){
				  
				  selected.push(topwords);
			  }
		  }
		  jobj[i].words=selected;
		  
	  }
	  //appendPre("SubJSON "+unum+" Object:");
	  var jname='suburlProfile'+unum;
	  //Save topics as JSON
	  var stoj=JSON.stringify(jobj);
	 // appendPre(stoj);
	  localStorage.setItem(jname,stoj);
	  if(dislike){
		  showUrls();
		  if(unum==(linknum-1)){
			  dislike=false;
		  }
	  }
}

//-------------code for reading main url-------------------------/

function readurl(){
	var url = document.getElementById('textinput').value;
	
	$.get(url, function(response) { 
		var text= response;
		
		for(sum in text){
			
			createMainDiv(text[sum]);
		}
	
	});
	document.getElementById('token-button').disabled=false;
	
	
	}
	
//Dummy function to print to screen, for testing purposes only.
function appendPre(message) {
	  var pre = document.getElementById('output');
	  var textContent = document.createTextNode(message + '\n');
	  pre.appendChild(textContent);
	}
	
//function to read JSONs.
function readJSON(filename){
	var file=filename;
	
	var JSONobj = JSON.parse(localStorage.getItem(file));	
	return JSONobj;
}

//function to calculate score of main url
function mainMult(){
	var userfile="userProfile";
	var urlfile="urlProfile";
	var userTopics=readJSON(userfile);
	var urlTopics=readJSON(urlfile);
	var usertopicflat=[];
	var urlmatchword=[];
	var urlmatchwordfreq={};
	var totalurl=0;
	var multiplier=0.0;
	
	for(topic in userTopics){
		for(var i=0;i<userTopics[topic].words.length;i++){
			usertopicflat.push(userTopics[topic].words[i][0]);
		}
		
	}
	//appendPre(usertopicflat);
	for (topic in urlTopics){
		var words=urlTopics[topic].words;
		for (var i=0; i<words.length;i++){
			totalurl+=1;
			//appendPre(words[i][0]);
			if(usertopicflat.indexOf(words[i][0]) > -1){
				urlmatchword.push(words[i][0]);
				if(!urlmatchwordfreq[words[i][0]]){
					urlmatchwordfreq[words[i][0]]=words[i][1];
				}
				else
					{
					urlmatchwordfreq[words[i][0]]+=words[i][1];
					}
				
			}
		}
		
	}
	//we now have a list of words from main url that match the user profile words.
	var temparr=[];
	
	
	//appendPre("Matched words: "+urlmatchword);
	//appendPre("Total topic words for this page "+totalurl);
	multiplier=(urlmatchword.length/totalurl);
	supermult=multiplier;
	appendPre("Score of the page: This site is "+(multiplier*100)+ " percent relevant to you");
	var check=document.getElementById("toggle");
	if (check.checked){
		appendPre("This score is based on following words that match with the topics of this page:");
		appendPre("Matched words: "+" Frequency of occurence on this page: "); 
		for (words in urlmatchword){
			if(temparr.indexOf(urlmatchword[words])<0){
				temparr.push(urlmatchword[words]);
				
				appendPre(urlmatchword[words]+"  "+urlmatchwordfreq[urlmatchword[words]]);
			}
			
		}
	}
	document.getElementById('url-button').disabled=false;
}
//-------------code for displaying recommended content-------------------------/

function showUrls1(){
	var superlink={};
	for (var i=0;i<ulinks.length;i++) {
        
        superlink[ulinks[i]] = {
                    score:  0.0,
                    mwords: {} 
                    };
      };
      
      
	var userfile="userProfile";
	var userTopics=readJSON(userfile);
	var usertopicflat=[];
	
	
	for(topic in userTopics){
		for(var i=0;i<userTopics[topic].words.length;i++){
			usertopicflat.push(userTopics[topic].words[i][0]);
		}
		
	}
	//appendPre("user topic flat"+usertopicflat);
	//appendPre(ulinks.length);
	
	//Go through all links in ulinks, get their JSONs and get score of each with matching words
	for(var i=0;i<ulinks.length;i++){
		var urlmatchword=[];
		var urlmatchwordfreq={};
		var totalurl=0;
		var multiplier=0.0;
		
		var jname='suburlProfile'+i;
		if(localStorage.getItem(jname)){
			var urlTopics=readJSON(jname);
			
			for (topic in urlTopics){
				var words=urlTopics[topic].words;
				for (var x=0; x<words.length;x++){
					totalurl+=1;
					//appendPre(words[i][0]);
					if(usertopicflat.indexOf(words[x][0]) > -1){
						urlmatchword.push(words[x][0]);
						//appendPre(words[i][0]);
						if(!urlmatchwordfreq[words[x][0]]){
							urlmatchwordfreq[words[x][0]]=words[x][1];
						}
						else
							{
							urlmatchwordfreq[words[x][0]]+=words[x][1];
							}
						
					}
				}
				
			}
		}
		
		multiplier=(urlmatchword.length/totalurl)*supermult;
		//appendPre("Link "+ulinks[i]+" total words"+urlmatchword.length);
		//appendPre("score"+multiplier*100);
		superlink[ulinks[i]].score= multiplier;
		superlink[ulinks[i]].mwords=urlmatchword;
		
	}
	
	for(slink in superlink){
		var a = document.createElement('pre');
		var pre = document.getElementById('urlscore');
		var message = "Following URL is recommended to you:";
		var textContent3 = document.createTextNode(slink+ '\n');
		var message2 = "Score of the link: This URL is "+(superlink[slink].score*100)+ " percent relevant to you";
		var message4 = "Matched words are "+(superlink[slink].mwords);
		var textContent = document.createTextNode(message+ '\n');
		var textContent2 = document.createTextNode(message2+ '\n');
		
		a.appendChild(document.createTextNode("------------------------------------------------------"+ '\n'));
		
		a.appendChild(textContent);
		a.appendChild(textContent3);
		//a.href = superlink[slink]+ "";
		a.appendChild(textContent2);
		a.appendChild(document.createTextNode('\n'+"This recommendation is based on topics that mached your profile."+ '\n'));
		a.appendChild(document.createTextNode(message4+ '\n'));
		a.appendChild(document.createTextNode("------------------------------------------------------"+ '\n'));
		pre.appendChild(a);
	}
	
}
function showUrls2(){
	var superlink={};
	for (var i=0;i<ulinks.length;i++) {
        
        superlink[ulinks[i]] = {
                    score:  0.0,
                    mwords: {} 
                    };
      };
      
      
	var userfile="userProfile";
	var userTopics=readJSON(userfile);
	var usertopicflat=[];
	
	
	for(topic in userTopics){
		for(var i=0;i<userTopics[topic].words.length;i++){
			usertopicflat.push(userTopics[topic].words[i][0]);
		}
		
	}
	//appendPre("user topic flat"+usertopicflat);
	//appendPre(ulinks.length);
	
	//Go through all links in ulinks, get their JSONs and get score of each with matching words
	for(var i=0;i<ulinks.length;i++){
		var urlmatchword=[];
		var urlmatchwordfreq={};
		var totalurl=0;
		var multiplier=0.0;
		
		var jname='suburlProfile'+i;
		if(localStorage.getItem(jname)){
			var urlTopics=readJSON(jname);
			
			for (topic in urlTopics){
				var words=urlTopics[topic].words;
				for (var x=0; x<words.length;x++){
					totalurl+=1;
					//appendPre(words[i][0]);
					if(usertopicflat.indexOf(words[x][0]) > -1){
						urlmatchword.push(words[x][0]);
						//appendPre(words[i][0]);
						if(!urlmatchwordfreq[words[x][0]]){
							urlmatchwordfreq[words[x][0]]=words[x][1];
						}
						else
							{
							urlmatchwordfreq[words[x][0]]+=words[x][1];
							}
						
					}
				}
				
			}
		}
		
		multiplier=(urlmatchword.length/totalurl)*supermult;
		superlink[ulinks[i]].score= multiplier;
		superlink[ulinks[i]].mwords=urlmatchword;
		
	}
	
	for(slink in superlink){
		var a = document.createElement('pre');
		var pre = document.getElementById('urlscore');
		var message = "Following URL is recommended to you:";
		var textContent3 = document.createTextNode(slink+ '\n');
		var message2 = "Score of the link: This URL is "+(superlink[slink].score*100)+ " percent relevant to you";
		var message4 = "Matched words are "+(superlink[slink].mwords);
		var textContent = document.createTextNode(message+ '\n');
		var textContent2 = document.createTextNode(message2+ '\n');
		
		a.appendChild(document.createTextNode("------------------------------------------------------"+ '\n'));
		
		a.appendChild(textContent);
		a.appendChild(textContent3);
		//a.href = superlink[slink]+ "";
		a.appendChild(textContent2);
		
		pre.appendChild(a);
	}
	
}
function showUrls(){
	
	document.getElementById('like-button').disabled=false;
	document.getElementById('dislike-button').disabled=false;
	
	
	document.getElementById('urlscore').innerHTML='';
	var check=document.getElementById("toggle");
	if (check.checked){showUrls1();} //with explanations
	else
		showUrls2(); //without explanations
	
}
function disliked(x){
	if(x>0){
		var pre = document.getElementById('like-dislike');
		pre.innerHTML='';
		
		pre.appendChild(document.createTextNode("We are sorry you didn't like the recommendations. We will try to update them now."+ '\n'));
		dislike=true;
		newUrl();
	}
	if(x==0){
		var pre = document.getElementById('like-dislike');
		pre.innerHTML='';
		pre.appendChild(document.createTextNode("We are glad you liked the recommendations! Thank you!"+ '\n'));
	}
}

</script>
</head>
<body>
<h2> Enter the webpage you wish to check: </h2>
<p>(Try: https://en.wikipedia.org/wiki/Special:Random )</p>
<input type="text" id="textinput"></input>
<button type="submit" onclick="readurl()">SUBMIT</button>
<br>Default System is Alpha.(No explanations)<br>
<input type="checkbox" id="toggle" value="System Mode: Alpha">Click here to use System Omega.(With explanations)
<div id="urlmaintext" style="display: none"></div>
<div id="urlsubtext" style="display: none"></div>
<pre id="output"></pre>
<button id="token-button" onclick="mainMult()" disabled>
    	Score
</button>
<button id="url-button" onclick="showUrls()" disabled>
    	Show URLs
</button>
<pre id="urlscore"></pre>
<button id="like-button" onclick="disliked(0)" disabled>
    	Like
</button>
<button id="dislike-button" onclick="disliked(1)" disabled>
    	Dislike
</button>
<pre id="like-dislike"></pre>
</body>
</html>