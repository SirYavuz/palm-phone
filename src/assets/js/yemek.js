$('#yemek-musteri-button').click(function() {
    $('#calisan-panel-id').hide();
    $('#musteri-panel-id').show();
    $('#yemek-calisan-button').removeClass('aktifheralde');
    $('#yemek-musteri-button').addClass('aktifheralde');
})

$('#yemek-calisan-button').click(function() {
    $('#calisan-panel-id').show();
    $('#musteri-panel-id').hide();
    $('#yemek-musteri-button').removeClass('aktifheralde');
    $('#yemek-calisan-button').addClass('aktifheralde');
})

$('#yemek-adres-gonder-button-id').click(function() {
    var adres = $('#yemek-girilen-adres').val();
    var siparis = $('#yemek-girilen-siparis').val();

    console.log(adres);
    console.log(siparis);

    $.post('http://palm-phone/gelenadres', JSON.stringify({
        gonderilenadres: adres,
        gonderilensiparis: siparis
    }))
})