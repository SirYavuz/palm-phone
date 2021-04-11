let hesap_sonucu = 0;


$('document').ready(function() {


    $(document).on('click', '#toplama_button', function() {
        let deger = $('#hesap-sonucu').val();

        console.log('Toplama işlemi. Değer : ' + deger)
        console.log('Toplama işlemi. Yeni Değer : ' + yenideger)
        $("#hesap-sonucu").val("");
    });

});