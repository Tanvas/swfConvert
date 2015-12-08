/*---LEFT BAR ACCORDION----*/
$(function() {
    $('#nav-accordion').dcAccordion({
        eventType: 'click',
        autoClose: true,
        saveState: true,
        disableLink: true,
        speed: 'slow',
        showCount: false,
        autoExpand: true,
//        cookie: 'dcjq-accordion-1',
        classExpand: 'dcjq-current-parent'
    });
});

var Script = function () {


//    sidebar dropdown menu auto scrolling

    jQuery('#sidebar .sub-menu > a').click(function () {
        var o = ($(this).offset());
        diff = 250 - o.top;
        if(diff>0)
            $("#sidebar").scrollTo("-="+Math.abs(diff),500);
        else
            $("#sidebar").scrollTo("+="+Math.abs(diff),500);
    });



//    sidebar toggle

    $(function() {
        function responsiveView() {
            var wSize = $(window).width();
            if (wSize <= 768) {
                $('#container').addClass('sidebar-close');
                $('#sidebar').hide();
                $('#main-content').css({
                    'margin-left': '0px'
                });
                $('.textframe').css({ 'height': '12%' });
                $('.navbar-fixed-bottom').css({ 'height': '16%' });
                $('.viewframe').css({ 'height': '83%' });
                if ($('#sidebar').is(":visible") === true)
                {
                    $('#btnList').addClass('top-btn-right');
                }
                else
                {
                    $('#btnList').removeClass('top-btn-right');
                }
            }

            if (wSize > 768) {
              
                $('#sidebar').css({ 'height': '100%' });
                $('#sidebar').show();
                $('#sidebar').css({
                    'margin-left': '0'
                });
                $('#sidebar').css({ 'width': '260px' });
                $("#container").removeClass("sidebar-closed");
                
                $('#btnList').removeClass('top-btn-right');
                $('#main-content').css({
                    'margin-left': '260px'
                });              
                
                
                $('.textframe').css({ 'height': '20%' });
                $('.navbar-fixed-bottom').css({ 'height': '24%' });
                $('.viewframe').css({ 'height': '75%' });
               
            }
            $('#sidebar').css({ 'height': '100%' });
        }
        $(window).on('load', responsiveView);
        $(window).on('resize', responsiveView);
    });

    $('.fa').click(function () {
        if ($('#sidebar').is(":visible") === true) {
            $('#main-content').css({
                'margin-left': '0px'
            });
            $('#sidebar').css({
                'margin-left': '-260px'
            });
            $('#sidebar').hide();
            $("#container").addClass("sidebar-closed");
            $('.textframe').css({ 'height': '12%' });
            $('.navbar-fixed-bottom').css({ 'height': '16%' });
            $('.viewframe').css({ 'height': '83%' });
            $('#btnList').removeClass('top-btn-right');
        } else {
            $('#main-content').css({
                'margin-left': '260px'
            });
            $('#sidebar').css({ 'height': '100%' });
            $('#sidebar').show();
            $('#sidebar').css({
                'margin-left': '0'
            });
            $("#container").removeClass("sidebar-closed");
            
            $('.textframe').css({ 'height': '20%' });
            $('.navbar-fixed-bottom').css({ 'height': '24%' });
            $('.viewframe').css({ 'height': '75%' });

            var wSize = $(window).width();
            if (wSize <= 768)
            {
                $('#sidebar').css({ 'width': '100%' });
                $('#main-content').css({
                    'margin-left': '100%'
                });
                $('#btnList').addClass('top-btn-right');
            }
        }
    });

    // custom scrollbar
    $("#sidebar").niceScroll("#nav-accordion", { styler: "fb", cursorcolor: "#4ECDC4", cursorwidth: '6', cursorborderradius: '10px', background: '#404040', spacebarenabled: false, cursorborder: '' });   
    $(".textframe").niceScroll({ styler: "fb", cursorcolor: "#4ECDC4", cursorwidth: '6', cursorborderradius: '10px', background: '#404040', spacebarenabled: false, cursorborder: '' });
    $("html").niceScroll({styler:"fb",cursorcolor:"#4ECDC4", cursorwidth: '6', cursorborderradius: '10px', background: '#404040', spacebarenabled:false,  cursorborder: '', zindex: '1000'});

// widget tools

    jQuery('.panel .tools .fa-chevron-down').click(function () {
        var el = jQuery(this).parents(".panel").children(".panel-body");
        if (jQuery(this).hasClass("fa-chevron-down")) {
            jQuery(this).removeClass("fa-chevron-down").addClass("fa-chevron-up");
            el.slideUp(200);
        } else {
            jQuery(this).removeClass("fa-chevron-up").addClass("fa-chevron-down");
            el.slideDown(200);
        }
    });

    jQuery('.panel .tools .fa-times').click(function () {
        jQuery(this).parents(".panel").parent().remove();
    });


//    tool tips

    $('.tooltips').tooltip();

//    popovers

    $('.popovers').popover();



// custom bar chart

    if ($(".custom-bar-chart")) {
        $(".bar").each(function () {
            var i = $(this).find(".value").html();
            $(this).find(".value").html("");
            $(this).find(".value").animate({
                height: i
            }, 2000)
        })
    }


}();
/*carousel*/

    $(window).resize(function () {
        var w = $(window).width();
        if(w<800)
            $(".logo").hide();
        else
            $(".logo").show();
    });
