
var testManager;
var startDate;
var testingTime;
var curNum=0;
var curScore = 0;
var complThreshold;
var startTime = new Date();
var startHour = startTime.getHours();
var startMinutes = startTime.getMinutes();
var startSeconds = startTime.getSeconds();

var Tests = function () {

    this.exitPageStatus;
    this.gnPage = 0;
    this.rightCount = 0;
    this.gnMaxTests = 5; // Change this if you add more pages 	

    this.curTests = new Array();
    this.curTest;
    this.formView = document.getElementById("testForm");

    Tests.prototype.initTests = function () {
        var allTests = new GetAllTests();        
        this.gnMaxTests = allTests.length;

        this.curTests = this.getShuffleTests(allTests, this.gnMaxTests);
        if (this.curTests.length <= 0) {
            alert("В тесте отсутствуют вопросы!");
            return;
        }
        onLoaded();
        complThreshold=GetCompleteThreshold();
       
        this.GoToPage(1);
        
    }

    Tests.prototype.getShuffleTests = function (tests, tCnt) {
        var count = tests.length;
        var j = 0;
        var curTests = new Array();
        for (var i = count - 1; i >= 0; i--) {
            var num = Math.floor(Math.random() * (i + 1));
            var d = tests[num];
            tests[num] = tests[i];
            tests[i] = d;

            curTests[j] = d;

            if (j > (tCnt - 1)) {
                break;
            }
            else {
                j++;
            }
        }
        return curTests;
    }


    Tests.prototype.GoToPage = function (n) {

        if (this.gnPage == n)
            return;

        if (n > this.gnMaxTests) {
            console.log("Çàïðàøèâàåìûé èíäåêñ ñòðàíèöû ïðåâûøàåò êîëè÷åñòâî ñòðàíèö");
            return;
        }
        this.gnPage = n;

        var newTest = this.curTests[n - 1];
        newTest.initTest(this.formView);
        this.curTest = newTest;      
        hideForvrdBtn();
        


    }

    Tests.prototype.checkAnswer = function () {
        if (!this.curTest) {
            console.log("Test is null");
            return;
        } 
     
        var res = this.curTest.checkAnswer();
        if (res) {
            this.rightCount++;
           
        }
        
        viewForvrdBtn();
        return false;
    }

    Tests.prototype.goNextPage = function () {
        if (this.curTest)
            this.curTest.onExit();
        var n = this.gnPage;
        if (n >= this.gnMaxTests)
            this.doTestedEnd();
        else
            this.GoToPage(n + 1);
    }

    Tests.prototype.doTestedEnd = function () {
        hideForvrdBtn();
      
        while (this.formView.firstChild)
            this.formView.removeChild(this.formView.firstChild);

        

        viewResult(this.rightCount, this.gnMaxTests);
        testFinish();
    }

}



function hideForvrdBtn()
{
	document.getElementById("btnForvd").style.display='none';
}
function viewForvrdBtn()
{
	document.getElementById("btnForvd").style.display='block';
}

//function hideAnswerBtn() {
  
//    document.getElementById("resBtn").style.display = 'none';
 
//}
//function viewAnswerBtn() {
//    document.getElementById("resBtn").style.display = 'block';
//}


function loadPage()
{   
 
  testManager = new Tests();
 
   testManager.initTests();
   exitPageStatus = false;
   startTimer();
   
}



function viewResult(corrCount,maxCount)
{
    
	var testingTime=getTestingTime();
	var div = document.getElementById('resDiv');
	div.style.display = 'block';	
 	div.innerHTML="<p>Количество правильных ответов " +corrCount+" из " + maxCount+"</p>";
 	div.innerHTML+="<p>Время выполнения "+testingTime+"</p>";
 	 	
 	div.innerHTML += "<p>Количество баллов " + corrCount + "</p>";
 	curScore = corrCount / maxCount;
 	if (curScore >= complThreshold)
		div.innerHTML+="<p>Вы успешно прошли тест!</p>";
	else
		div.innerHTML+="<p>Вы не прошли тест!</p>";

 	



}

function startTimer()
{
   startDate = new Date().getTime();
}

function getTestingTime()
{ 
   if ( startDate != 0 )
   {
      var currentDate = new Date().getTime();
      var elapsedSeconds = ( (currentDate - startDate) / 1000 );
      var timeArr = convertTotalSeconds( elapsedSeconds );
      return timeArr[0]+":"+timeArr[1] +":"+timeArr[2];
		
   }
   else
   {
      return "00:00:00";
   }
   
}

function testFinish()
{
    SetWorkTime(startDate);
    SetResult(curScore, complThreshold);
    
   
}

function doQuit()
{
    
    
   exitPageStatus = true; 
  
   
  
}

function unloadPage()
{
    onFinish();
}

function convertTotalSeconds(ts)
{
   var sec = (ts % 60);

   ts -= sec;
   var tmp = (ts % 3600);  //# of seconds in the total # of minutes
   ts -= tmp;              //# of seconds in the total # of hours

   // convert seconds to conform to CMITimespan type (e.g. SS.00)
   sec = Math.round(sec*100)/100;
   
   var strSec = new String(sec);
   var strWholeSec = strSec;
   var strFractionSec = "";

   if (strSec.indexOf(".") != -1)
   {
      strWholeSec =  strSec.substring(0, strSec.indexOf("."));
      strFractionSec = strSec.substring(strSec.indexOf(".")+1, strSec.length);
   }
   
   if (strWholeSec.length < 2)
   {
      strWholeSec = "0" + strWholeSec;
   }
   strSec = strWholeSec;
   
   if ((ts % 3600) != 0 )
      var hour = 0;
   else var hour = (ts / 3600);
   if ( (tmp % 60) != 0 )
      var min = 0;
   else var min = (tmp / 60);

   if ((new String(hour)).length < 2)
      hour = "0"+hour;
   if ((new String(min)).length < 2)
      min = "0"+min;

   var rtnVal = new Array(hour,min,strSec);

   return rtnVal;
}
function GoNextPage() 
{ 
	testManager.goNextPage();
} 





