// JavaScript source codejke
var initScorm;
var is2004 = true;
var startTime;
///минимальный проходной балл по умолчанию
var defoultPassedScore = 0.8;
window.onload = function () { onLoaded(); };
window.onunload = function () { onUnload(); };
///СКО загрузился
function onLoaded()
{
   
    pipwerks.SCORM.version = "2004";
    initScorm = pipwerks.SCORM.init();
    if (!initScorm)
    {
        is2004 = false;
        pipwerks.SCORM.version = "1.2";
        initScorm = pipwerks.SCORM.init();

        if(!initScorm)
        {
            if(window.console)
                window.console.log("ScormApi not found");
            return;
        }
    }
    startTime = new Date().getTime();
    var status = pipwerks.SCORM.status("get", null);
    if (status != "completed")
    {
        pipwerks.SCORM.status("set", "incomplete");
    }
}



///установить время работы с СКО
///startTime - время начала работы 
function SetWorkTime(startTime)
{
    if(!initScorm)
        return;

    if (!startTime || startTime == 0) { return; }
    if(is2004)
    {
        var currentDate = new Date().getTime();
        var elapsedSeconds = ((currentDate - startTime) / 1000);
        var timeArr = convertTotalSeconds(elapsedSeconds);
        var formattedTime = "PT" + timeArr[0] + "H" + timeArr[1] + "M" + timeArr[2] + "S";
        pipwerks.SCORM.set("cmi.session_time", formattedTime);
    }
    else
    {
        var currentDate = new Date().getTime();
        var elapsedSeconds = ((currentDate - startTime) / 1000);
        var timeArr = convertTotalSeconds(elapsedSeconds);
        var formattedTime = "00" + timeArr[0] + ":" + timeArr[1] + ":" + timeArr[2];
        pipwerks.SCORM.set("cmi.core.session_time", formattedTime);
    }
    pipwerks.SCORM.save();
}




///работа с СКО завершена
function onUnload()
{
  
    if (!initScorm)
        return;

    SetWorkTime(startTime);
    if (is2004) {       
            pipwerks.SCORM.set("cmi.completion_status", "completed");
            pipwerks.SCORM.set("cmi.success_status", "passed");
            pipwerks.SCORM.set("cmi.exit", "suspend");

    }
    else {       
       
            pipwerks.SCORM.set("cmi.core.lesson_status", "completed");
            pipwerks.SCORM.set("cmi.core.exit", "suspend");

    }
    pipwerks.SCORM.save();
   
        

    pipwerks.SCORM.quit();
}