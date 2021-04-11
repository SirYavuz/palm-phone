$(function () {
    var bar = $('#phone-open-bar'),
        animateTime = 800,
        topBar = $('.phone-header');
    topBar.click(function () {
        if (bar.height() === 0) {
            autoHeightAnimate(bar, animateTime);
            $('.top-bar').show();
        } else {
            bar.stop().animate({ height: '0' }, animateTime);
            setTimeout(function(){
                $('.top-bar').hide();
            },800);
        }
    });
})

function autoHeightAnimate(element, time) {
    var curHeight = element.height(),
        autoHeight = element.css('height', 'auto').height();
    element.height(curHeight); 
    element.stop().animate({ height: autoHeight }, time);
}