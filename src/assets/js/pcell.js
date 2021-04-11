$('document').ready(function() {
  let secilen_paket;

    $('#pcell-paket1-al').click(function() {
        $('.inside-of-pcell').css("display", "none");
        $('.pcell-paket-onaylama').css("display", "block");
        $('.paket-onay-seviye').html('Güncellenecek Paket : 1')
        $('.paket-onay-ucret').html('Yeni Fatura Ücreti : 100$')
        secilen_paket = 1;

    })
    $('#pcell-paket2-al').click(function() {
        $('.inside-of-pcell').css("display", "none");
        $('.pcell-paket-onaylama').css("display", "block");
        $('.paket-onay-seviye').html('Güncellenecek Paket : 2')
        $('.paket-onay-ucret').html('Yeni Fatura Ücreti : 200$')
        secilen_paket = 2;

    })
    $('#pcell-paket3-al').click(function() {
        $('.inside-of-pcell').css("display", "none");
        $('.pcell-paket-onaylama').css("display", "block");
        $('.paket-onay-seviye').html('Güncellenecek Paket : 3')
        $('.paket-onay-ucret').html('Yeni Fatura Ücreti : 300$')
        secilen_paket = 3;

    })

    $('.paket-geri-button').click(function() {
        $('.pcell-paket-onaylama').css("display", "none");
        $('.inside-of-pcell').css("display", "block");
    })

    $('.paket-onay-button').click(function() {
       
       
        $.post('http://palm-phone/pcell-paket-yukle', JSON.stringify({
            paket: secilen_paket
        }))

        setTimeout(function() {        
            $.post('http://palm-phone/pcell-guncelle', JSON.stringify({}));
            $('.pcell-paket-onaylama').css("display", "none");
            $('.inside-of-pcell').css("display", "block");
        }, 1000)
     
    })

    $(function() {
        window.addEventListener('message', function(event) {
            if (event.data.type === "pcell-guncelleme") {
                 $('.pcell-name').html(event.data.isim);
                $('.pcell-numara').html('Numara : ' + event.data.numara);
               

            }
        })
    })
   
    $(function() {
        window.addEventListener('message', function(event) {
            if (event.data.type === "pcell-guncelleme2") {
                $('.pcell-paket').html('Paket Seviyeniz : ' + event.data.paket);
                if (event.data.paket == 0) {
                    $('.pcell-fatura').html('Paket Seviyeniz : 0$');
                }
                if (event.data.paket == 1) {
                    $('.pcell-fatura').html('Paket Seviyeniz : ' + event.data.paket + '00.00$');
                }
                if (event.data.paket == 2) {
                    $('.pcell-fatura').html('Paket Seviyeniz : ' + event.data.paket + '00.00$');
                }
                if (event.data.paket == 3) {
                    $('.pcell-fatura').html('Paket Seviyeniz : ' + event.data.paket + '00.00$');
                }
               

            }
        })
    })
});