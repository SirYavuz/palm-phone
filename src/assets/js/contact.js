$('.k-top-add').click(function() {
    $('.k-top-add-screen').show();
    $('.k-contacts').hide();
    $('.kisiler-footer').hide();
    $('.k-top-add').hide();
});

$('#k-add-screen-backb').click(function() {
    $('.k-top-add-screen').hide();
    $('.k-contacts').show();
    $('.kisiler-footer').show();
    $('.k-top-add').show();
});

$('.k-footer-right').click(function() {
    $('.k-numbers').show();
    $('.k-contacts').hide();
    $('.k-top-add').hide();
});

$('.k-footer-left').click(function() {
    $('.k-numbers').hide();
    $('.k-contacts').show();
    $('.k-top-add').show();
});

$('.call-with-numpad').click(function() {
    $('.app-kisiler').hide();
    $('.phone-on-call').show();
    $.post('http://palm-phone/aramayapanim', JSON.stringify({}));
    $.post('http://palm-phone/arama', JSON.stringify({}));
    var numara = $('#numpadValue').val();
    if (numara <= 0) {
        $('#aranan-numara').html('bilinmiyor');

    } else {
        $('#aranan-numara').html(numara);
        $.post('http://palm-phone/arananbildirim', JSON.stringify({
            number: $('#numpadValue').val()
        }));
    }
});

$('.phone-call-off-button').click(function() {
    $('.phone-on-call').hide();
    $('.app-kisiler').show();
    $.post('http://palm-phone/aramakapatanim', JSON.stringify({}));
    $.post('http://palm-phone/aramakapatmasesi', JSON.stringify({}));

});



window.addEventListener('message', function(event) {
    var item = event.data;

    if (item.type == "aramakapat") {
        if (item.toggle) {
            $('.phone-on-call').hide();
            $('.app-kisiler').show();
            $.post('http://palm-phone/aramakapatanim', JSON.stringify({}));
            $.post('http://palm-phone/aramakapatmasesi', JSON.stringify({}));
        } else {
            $('.phone-on-call').hide();
            $('.app-kisiler').show();
            $.post('http://palm-phone/aramakapatanim', JSON.stringify({}));
            $.post('http://palm-phone/aramakapatmasesi', JSON.stringify({}));
        }
    }

});