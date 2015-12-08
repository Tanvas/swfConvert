var testSize = { w: 960, h: 560 };
var ofset = 150;

function getPageSize() {
    var xScroll, yScroll;

    if (window.innerHeight && window.scrollMaxY) {
        xScroll = document.body.scrollWidth;
        yScroll = window.innerHeight + window.scrollMaxY;
    } else if (document.body.scrollHeight > document.body.offsetHeight) { // all but Explorer Mac
        xScroll = document.body.scrollWidth;
        yScroll = document.body.scrollHeight;
    } else if (document.documentElement && document.documentElement.scrollHeight > document.documentElement.offsetHeight) { // Explorer 6 strict mode
        xScroll = document.documentElement.scrollWidth;
        yScroll = document.documentElement.scrollHeight;
    } else { // Explorer Mac...would also work in Mozilla and Safari
        xScroll = document.body.offsetWidth;
        yScroll = document.body.offsetHeight;
    }

    var windowWidth, windowHeight;
    if (self.innerHeight) { // all except Explorer
        windowWidth = self.innerWidth;
        windowHeight = self.innerHeight;
    } else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
        windowWidth = document.documentElement.clientWidth;
        windowHeight = document.documentElement.clientHeight;
    } else if (document.body) { // other Explorers
        windowWidth = document.body.clientWidth;
        windowHeight = document.body.clientHeight;
    }

    // for small pages with total height less then height of the viewport
    if (yScroll < windowHeight) {
        pageHeight = windowHeight;
    } else {
        pageHeight = yScroll;
    }

    // for small pages with total width less then width of the viewport
    if (xScroll < windowWidth) {
        pageWidth = windowWidth;
    } else {
        pageWidth = xScroll;
    }

    return [pageWidth, pageHeight, windowWidth, windowHeight];
}


 var screenW = getPageSize()[0];
     var screenH = getPageSize()[1];
     var gadjetSize = function () {

         var wd = testSize.w;
         var hg = testSize.h;
         var newW = wd;
         var newH = hg;
         var koef = hg / wd;
         newW = screenW;
         newH = screenW * koef;
         if (newH > screenH) {
             var koef2 = screenH / newH;
             newH = screenH;
             newW = newW * koef2;
         }        
         this.w = newW-ofset;
         this.h = newH - ofset;

     }
var screenSize = new gadjetSize();

Vector4 = function (x, y, w, h) {
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;

    Vector4.prototype.AsGadjetPx = function () {
        var tx = SizeHorConvertor(this.x) + 'px';
        var ty = SizeVertConvertor(this.y) + 'px';
        var tw = SizeHorConvertor(this.width) + 'px';
        var th = SizeVertConvertor(this.height) + 'px';

        return new Vector4(tx, ty, tw, th);
    }

}

function SizeHorConvertor(_size) {
    if (!screenSize || !screenSize.w || !screenSize.h)
        return _size;

    return (screenSize.w * _size / testSize.w);
}

function SizeVertConvertor(_size) {
    if (!screenSize || !screenSize.w || !screenSize.h)
        return _size;
    return (screenSize.h * _size / testSize.h);
}

function Answer(aid, atext, aview) {
    this.id = aid;
    this.text = atext;
    this.qview = aview.AsGadjetPx();
    this.y = this.qview.y;   
    this.label;
    this.lableClass = "";
   
    ///отобразить вариант ответа
    this.view = function (tform) {

        var br = document.createElement("br");       
        this.viewInput(tform);       
        var lbl = document.createElement("label");

        lbl.setAttribute('for', this.id);
        lbl.innerHTML = this.text;    
        lbl.style.top = this.y;
        lbl.style.left = this.qview.x;
        lbl.style.width = this.qview.width;
        lbl.style.height = this.qview.height;
        lbl.setAttribute("class", this.lableClass);
        tform.appendChild(lbl);
        this.label = lbl;


    }
   
    
    
}

var _answer = new Answer(1, "", new Vector4(1, 1, 1, 1));

    /*ВАРИАНТ-ВЫБОР*/
function CheckedAns(aid, atext, aview)
{
    this.id = aid;
    this.text = atext;
    this.qview = aview.AsGadjetPx();
    this.y = this.qview.y;   
    this.label;
    this.hash = hex_md5(aid);
    this.input;
    this.isCorrect = false;
    this.lableClass = "checkLabel";
    this.viewInput = function (tform) {
       
        this.input = document.createElement("input");
        this.input.setAttribute('type', 'checkbox');
        this.input.setAttribute('id', this.id);
        this.input.setAttribute('name', "testAns");      
        this.input.style.top = this.y;
        this.input.style.left = this.qview.x;
        this.input.style.zIndex = 1;

        tform.appendChild(this.input);
    }
    ///установить правильный вариант
    this.SetCorrectChecked = function (_hash) {
        if (_hash == this.hash) {
            this.isCorrect = true;
        }

    }
    ///установить верное значение флага
    this.SetAsTry = function () {
        var ch = this.input.checked;
        if (ch && !this.isCorrect)
        {
            this.input.checked = false;
            this.label.setAttribute("class", "wrongCheck");
            return false;
        }
        else if (!ch && this.isCorrect)
        {
            this.input.checked = true;
            this.label.setAttribute("class", "trueCheck");
            return false;
        }
        return true;
    }

  
}
CheckedAns.prototype = _answer;


var Test = function (ans, tid, textQ, tview,pic) {

    this.answers = ans;
    this.txtQ = textQ;
    this.id = tid;
    this.correct;
    this.formView;
    this.oview = tview.AsGadjetPx();
    this.isShuffle = true; 
    this.isDoAns = false;
    this.button;
    this.qpic = pic;

    Test.prototype.viewAnswers = function (tform) {

        this.CheckShuffle();
        if (this.isShuffle)
            this.shuffleAnswers();

        this.formView = tform;
        var ansCnt = this.answers.length;
      
        //var textSpa = document.getElementById("txtQ");
        var textSpa = document.createElement("span");
        textSpa.setAttribute("id", "txtQ");
        textSpa.style.top = this.oview.y;
        textSpa.style.left = this.oview.x;
        textSpa.style.width = this.oview.width;
        textSpa.style.height = this.oview.height;
        tform.appendChild(textSpa);

        textSpa.innerHTML = this.txtQ;
        this.ViewPic(tform);
        for (var i = 0; i < ansCnt; i++) {

            this.answers[i].view(this.formView);
        }
        
        this.AddResButton(tform);
    }
    Test.prototype.ViewPic = function (tform)
    {
        if (!this.qpic)
            return;
        
        var picCnt = this.qpic.length;
        for (var i = 0; i < picCnt; i++)
        {
        var tmppic = { pic: this.qpic[i].pic, vec4: this.qpic[i].vec4.AsGadjetPx() };
            var img = document.createElement("img");
            img.src = tmppic.pic;
            var size = tmppic.vec4;
            img.style.top = size.y;
            img.style.left = size.x;
            img.style.width = size.width;
            img.style.height = size.height;
            tform.appendChild(img);
        }
    }
    Test.prototype.AddResButton = function (tform) {
        var btn = document.createElement("input");
        btn.setAttribute('type', 'submit');
        btn.setAttribute('id', "resBtn");
        btn.value = "Ответить";
        tform.appendChild(btn);
        this.button = btn;
    }

    Test.prototype.CheckShuffle = function () {
        var ansCnt = this.answers.length;
        this.isShuffle = this.qpic ? false : true; 
    }
    Test.prototype.initTest = function (tform) {
        this.viewAnswers(tform);
        var n = 0;

    }

    Test.prototype.onExit = function () {
        if (!this.isDoAns)
            doNotAns();
        this.clearHTML();


    }
    Test.prototype.clearHTML = function () {
        var textSpa = document.getElementById("txtQ");
        textSpa.innerHTML = "";

        destroyChildren(this.formView);
        destroyMessage();
    }

    Test.prototype.shuffleAnswers = function () {
        var count = this.answers.length;
        for (var i = count - 1; i > 0; i--) {
            var num = Math.floor(Math.random() * (i + 1));
            var d = this.answers[num].y;
            this.answers[num].y = this.answers[i].y;
            this.answers[i].y = d;
        }


    }

}

var _test = new Test(NaN, 1, "", new Vector4(1, 1, 1, 1),null);
/*ТЕСТ-ВЫБОР*/
function CheckedTest(ans, tid, textQ, tview,pic) {
    this.answers = ans;
    this.txtQ = textQ;
    this.id = tid;
    this.correct;
    this.formView;
    this.oview = tview.AsGadjetPx();
    this.isShuffle = true;
    this.button;
    this.isDoAns = false;
    this.qpic = pic;

   

    this.checkAnswer = function () {
        if (this.isDoAns)
            return false;

        this.isDoAns = true;

        var ansCnt = this.answers.length;
        var corCnt = this.correct.length;
        var cor = true;

        for (var i = 0; i < ansCnt; i++) {
            for (var j = 0; j < corCnt; j++) {
                this.answers[i].SetCorrectChecked(this.correct[j]);

            }

            if (!this.answers[i].SetAsTry())
                cor = false;

        }
        if(this.button)
            this.button.style.display = "none";
        ViewResult(cor);
        return cor;
    }
}

 CheckedTest.prototype = _test;


///определяет текущее значение в последовательности
var SeqNum = 1;
/*Тесты-последовательности*/
function AnswerSeq(aid, atext, aview) {
    this.id = aid;
    this.text = atext;
    this.qview = aview.AsGadjetPx();
    this.y = this.qview.y;   
    this.curNum = 10;
    this.hash = hex_md5(aid);
    this.input;
    this.isCorrect = false;
    this.lableClass = "btnLabel";
    
    ///отобразить вариант ответа
    this.viewInput = function (tform) {        
        this.input = document.createElement("input");
        this.input.setAttribute('type', 'button');
        this.input.setAttribute('id', this.id);
        this.input.setAttribute('name', "testAns");
        this.input.setAttribute('class', "testBtn");
        this.input.style.top = this.y;
        this.input.style.left = this.qview.x;
        this.input.style.zIndex = 10;
       
        tform.appendChild(this.input);
     
    }
    

    
    
    ///установить правильный вариант
    this.SetCorrectChecked = function (_hash,num) {
        if (_hash == this.hash)
        {
            this.curNum = num;
        }


    }
    ///установить верное значение флага
    AnswerSeq.prototype.SetAsTry = function () {
        var val = this.input.value;
        if (val != this.curNum)
        {
            this.input.setAttribute("class", "btnFalse");
            this.input.value = this.input.value + " (" + this.curNum + ")";
            return false;
        }
       
        return true;
    }
}

AnswerSeq.prototype = _answer;



var TestSeq = function (ans, tid, textQ, tview,pic) {

    this.answers = ans;
    this.txtQ = textQ;
    this.id = tid;
    this.correct;
    this.formView;
    this.oview = tview.AsGadjetPx();
    this.isShuffle = true;
    this.button;
    this.qpic = pic;
    SeqNum = 1;

    this.isDoAns = false;

    this.viewAnswers = function (tform) {
        this.CheckShuffle();
        if (this.isShuffle)
            this.shuffleAnswers();

        this.formView = tform;
        tform.onclick = SetNumSeq;
        var ansCnt = this.answers.length;

        var textSpa = document.createElement("span");
        textSpa.setAttribute("id", "txtQ");
        textSpa.style.top = this.oview.y;
        textSpa.style.left = this.oview.x;
        textSpa.style.width = this.oview.width;
        textSpa.style.height = this.oview.height;
        tform.appendChild(textSpa);

        textSpa.innerHTML = this.txtQ;
      
        for (var i = 0; i < ansCnt; i++) {

            this.answers[i].view(tform);
        }
        this.ViewPic(tform);
        this.AddResButton(tform);
    }

    
   
    this.checkAnswer = function () {
        if (this.isDoAns)
            return false;

        this.isDoAns = true;
        var ansCnt = this.answers.length;
        var corCnt = this.correct.length;
        var cor = true;

        for (var i = 0; i < ansCnt; i++) {
            for (var j = 0; j < corCnt; j++) {
                this.answers[i].SetCorrectChecked(this.correct[j],j+1);

            }
            
            if (!this.answers[i].SetAsTry())
                cor = false;

        }
        if (this.button)
            this.button.style.display = "none";
        ViewResult(cor);
        return cor;

    }
 
}
TestSeq.prototype = _test;


function SetNumSeq(e)
{
   
    if (testManager.curTest.isDoAns)
        return;
    e = e || window.event;
    e = e.target || e.srcElement;
    var tag = e.tagName.toLowerCase();
    if (e.getAttribute("name") != "testAns")
        return;
    if (e.value == "")
    {
        
        e.value = SeqNum;
        SeqNum++;
            return;
    }
    var tmp = e.value;
    e.value = "";
    buttons = document.getElementsByTagName("input");
    for(var i=0; i<buttons.length;i++)
    {
        var btn = buttons[i];
        if (btn.name != "testAns")
            continue;        
        if (btn.value != "" && btn.value > tmp)
            btn.value = btn.value-1;
    }
    SeqNum--;
}

function destroyChildren(node)
{
    //var dontmove = document.getElementById("common");
  while (node.childNodes.length>0)
  {
      //if (dontmove != node.firstChild)
          node.removeChild(node.firstChild);
     // else
      //    break;
      
      
  }
}
function destroyMessage()
{
    var pos = document.getElementById("mess");
    if (pos.firstChild)
	    pos.removeChild(pos.firstChild);
  	


}

function ViewResult(cor)
{
    

    if (cor)
        doCorrect();
    else
        doWrong();
}
 function doCorrect()
 {
     
 	    viewMessage("correctMes","Вы ответили правильно!");  	
 }
 
 function doWrong()
 {     
 	viewMessage("wrongMes","Вы ответили не правильно!");
 }
 
 function viewMessage(idDiv,mText)
 {
 	var div=document.createElement('div');
 	div.setAttribute('id',idDiv);
 	div.innerHTML = "<p>" + mText + "</p>";
 	div.style.top = SizeVertConvertor(testSize.h) + 'px';
 	
 	var pos=document.getElementById("mess");
 	pos.appendChild(div);
 	
 }
 


 

