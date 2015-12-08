// JavaScript source codejke
var initScorm;
var is2004 = true;
///минимальный проходной балл по умолчанию
var defoultPassedScore = 0.8;
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

    var status = pipwerks.SCORM.status("get", null);
    if (status != "completed")
    {
        pipwerks.SCORM.status("set", "incomplete");
    }
}



///получить нормализованный проходной балл
function GetCompleteThreshold()
{
    if(!initScorm)
        return defoultPassedScore;

    if(is2004)
    {
        var completion_threshold = pipwerks.SCORM.get("cmi.completion_threshold");
        var complThreshold = pipwerks.SCORM.get("cmi.scaled_passing_score");

        if (isNaN(completion_threshold) || !completion_threshold)
            completion_threshold = defoultPassedScore;

        if (isNaN(complThreshold) || !complThreshold)
            complThreshold = completion_threshold;

        return complThreshold;
    }
    else
    {
        
       
        var complThreshold = pipwerks.SCORM.get("cmi.student_data.mastery_score");       

        if (isNaN(complThreshold) || !complThreshold)
            complThreshold = defoultPassedScore;

        return complThreshold;
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

///установить результат
///curScore - текущий результат (нормализованный)
///minScore - минимальный проходной балл (нормализованный)
function SetResult(curScore, minScore)
{
    if (!initScorm)
        return;

    if (isNaN(curScore) || !curScore || isNaN(minScore) || !minScore)
        return;

    var ps = Math.round(curScore * 100) / 100;
    if(is2004)
    {
        pipwerks.SCORM.set("cmi.score.raw", ps * 100);
        pipwerks.SCORM.set("cmi.score.scaled", ps);
        //pipwerks.SCORM.set("cmi.progress_measure", ps);

        if (ps >= minScore) {
            pipwerks.SCORM.set("cmi.completion_status", "completed");
            pipwerks.SCORM.set("cmi.success_status", "passed");
        }
        else {
            pipwerks.SCORM.set("cmi.completion_status", "passed");
            pipwerks.SCORM.set("cmi.success_status", "failed");
        }
        
    }
    else
    {
        pipwerks.SCORM.set("cmi.core.score.raw", ps*100);

        if (ps >= minScore) {
            pipwerks.SCORM.set("cmi.core.lesson_status", "completed");
        }
        else {
            pipwerks.SCORM.set("cmi.core.lesson_status", "failed");
        }
       
    }
    pipwerks.SCORM.save();
}


///работа с СКО завершена
function onFinish()
{
    if (!initScorm)
        return;
    if(is2004)
        pipwerks.SCORM.set("cmi.exit", "suspend");
    else
        pipwerks.SCORM.set("cmi.core.exit", "suspend");

    pipwerks.SCORM.save();
    pipwerks.SCORM.quit();
}