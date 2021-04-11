var currentApp = null;
var previousPage = null;
var notificationClosed = false;

$('document').ready(function() {

    $('.collapsible').collapsible();

    window.addEventListener('message', function(event) {
        var item = event.data;

        if (item.type == "phone") {
            if (item.toggle) {
                $('.phone').fadeIn(250);
            } else {
                $('.phone').fadeOut(250);
            }
        }
        // if (item.type == "updateBankbalance") {
        //     $('.account-money').html(event.data.bank)
        // }

        // if (item.type == "setupPlayerContacts") {
        //     setupPlayerContacts(event.data.contacts)
        // }

        // if (item.type == "setupBankAccounts") {
        //     setupBankAccounts(event.data.accounts, event.data.totalbalance)
        // }

        // if (item.type == "updateTime") {

        //     $('#current-time1').html(item.time.hour + '<br>' + item.time.minute + ' ' + item.time.ampm)
        // }
        if (item.type == "updateTime") {

            if (item.time.hour < 10) {
                $('.current-time').html('0' + item.time.hour + ':' + item.time.minute + ' ' + item.time.ampm)
                $('#current-time1').html('0' + item.time.hour + '<br>' + item.time.minute + ' ' + item.time.ampm)

            } else {
                $('.current-time').html(item.time.hour + ':' + item.time.minute + ' ' + item.time.ampm)
                $('#current-time1').html(item.time.hour + '<br>' + item.time.minute + ' ' + item.time.ampm)

            }
        }
    });

    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post('http://palm-phone/exit', JSON.stringify({}));
            return
        }
    };
});





function setupBankAccounts(accounts, totalbalance) {
    $.each(accounts, function(index, account) {
        $(".app-bank-accounts").html("");
        setTimeout(function() {
            $(".app-bank-accounts").append('<div class="account"><span id="bank-name">' + account.name + '</span><br><span id="bank-type">' + account.type + '</span><br><span id="bank-banknumber">' + account.banknumber + '</span><br><i class="fas fa-piggy-bank" id="account-icon"></i><span id="bank-balance">€ ' + (account.balance).toFixed(2) + '</span><br></div>');
        }, 1)
    });
    setTimeout(function() {
        $(".app-bank-accounts").append('<div class="app-bank-total-balance"><p>Totaalsaldo</p><i class="material-icons">info</i><span id="total-accounts-balance">€ 0</span></div>');
        $('#total-accounts-balance').html("€ " + (totalbalance).toFixed(2));
    }, 2)
}

$(document).on('click', '#contact-call', function(e) {
    e.preventDefault();
    var parentId = $(this).parent().attr("id");
    var cData = $('#' + parentId).data("cData");
    phoneNotify("Oproep", "Contact Gegevens: </br> Contact: " + cData.name + ". </br> Tel: " + cData.number + "");
});

$('#phone-close').click(function(e) {
    e.preventDefault();
    $.post('http://palm-phone/exit', JSON.stringify({}));
    return
})

$('#information').click(function(e) {
    e.preventDefault();
    $('.phone-screen').css("display", "none");
    $('.app-information').css("display", "block");
    currentApp = $('.app-information');
    previousPage = $('.phone-screen');
});

// $('#banka-giris-ekrani').hide();

$('#bank').click(function(e) {
    e.preventDefault();
    $.post('http://palm-phone/idgetir', JSON.stringify({}));
    $.post('http://palm-phone/paragetir', JSON.stringify({}));
    $.post('http://palm-phone/isimgetir', JSON.stringify({}));
    $('.phone-screen').css("display", "none");
    $('.app-bank').css("display", "block");
    $('.banka-giris-ekrani').css("display", "block");
    $('.inside-of-bank').css("display", "none");
    // $('.banka-giris-ekrani').show();

    setTimeout(function() {

        $('.banka-giris-ekrani').css("display", "none");
        $('.inside-of-bank').css("display", "block");
    }, 1500)

    currentApp = $('.app-bank');
    previousPage = $('.phone-screen');

});

let durum = false;
let indirmehizi = 2000;
$('#saat').click(function() {

    if (durum === false) {
        $('#comment').css("display", "none");
        durum = true
    } else {
        setTimeout(function() {
            $('#comment').css("display", "flex");
            durum = false
        }, indirmehizi)
    }
    currentApp = $('.app-bank');
    previousPage = $('.phone-screen');
});

$('#settings').click(function(e) {
    e.preventDefault();
    $.post('http://palm-phone/ayarlar-isim-getir', JSON.stringify({}));
    $.post('http://palm-phone/ayarlar-resim-getir', JSON.stringify({}));
    $.post('http://palm-phone/ayarlar-numara-getir', JSON.stringify({}));
    $.post('http://palm-phone/ayarlar-paket-getir', JSON.stringify({}));
    $('.phone-screen').css("display", "none");
    $('.app-settings').css("display", "block");
    $('.ayarlar-giris-ekrani').css("display", "block");
    $('.inside-of-settings').css("display", "none");
    setTimeout(function() {
        $('.ayarlar-giris-ekrani').css("display", "none");
        $('.inside-of-settings').css("display", "block");
    }, 1500)
    currentApp = $('.app-settings');
    previousPage = $('.phone-screen');
});

$('#pcell').click(function(e) {
    e.preventDefault();
    $.post('http://palm-phone/pcell-guncelle', JSON.stringify({}));
    $('.phone-screen').css("display", "none");
    $('.app-pcell').css("display", "block");
    $('.pcell-giris-ekrani').css("display", "block");
    $('.inside-of-pcell').css("display", "none");
    setTimeout(function() {
        $('.pcell-giris-ekrani').css("display", "none");
        $('.inside-of-pcell').css("display", "block");
    }, 1500)
    currentApp = $('.app-pcell');
    previousPage = $('.phone-screen');
});



$('#calculator').click(function(e) {
    e.preventDefault();
    $.post('http://palm-phone/getPlayerContacts', JSON.stringify({}));
    $('.phone-screen').css("display", "none");
    $('.app-hesap').css("display", "block");


    currentApp = $('.app-hesap');
    previousPage = $('.phone-screen');
});

$('#store').click(function(e) {
    e.preventDefault();
    $.post('http://palm-phone/getPlayerContacts', JSON.stringify({}));
    $('.phone-screen').css("display", "none");
    $('.app-store').css("display", "block");


    currentApp = $('.app-store');
    previousPage = $('.phone-screen');
});

$('#telsiz').click(function(e) {
    e.preventDefault();
    $.post('http://palm-phone/getBankAccounts', JSON.stringify({}));
    $('.phone-screen').css("display", "none");
    $('.app-telsiz').css("display", "block");
    currentApp = $('.app-telsiz');
    previousPage = $('.phone-screen');
});

$('#phone').click(function(e) {
    e.preventDefault();
    $.post('http://palm-phone/getBankAccounts', JSON.stringify({}));
    $('.phone-screen').css("display", "none");
    $('.app-arama').css("display", "block");
    currentApp = $('.app-arama');
    previousPage = $('.phone-screen');
});

$(".bank-transfer").click(function(e) {
    e.preventDefault();
    $('.app-bank').css("display", "none");
    $('.app-bank-transfer').css("display", "block");
    currentApp = $('.app-bank-transfer');
    previousPage = $('.app-bank');
})


$('#yemek').click(function(e) {
    e.preventDefault();
    $.post('http://palm-phone/getPlayerContacts', JSON.stringify({}));
    $('.phone-screen').css("display", "none");
    $('.app-yemek').css("display", "block");
    currentApp = $('.app-yemek');
    previousPage = $('.phone-screen');
});

$('#kisiler').click(function(e) {
    e.preventDefault();
    $('.phone-screen').css('display', 'none');
    $('.app-kisiler').css('display', 'block');
    currentApp = $('.app-kisiler');
    previousPage = $('.phone-screen');
})

$('#ihbar').click(function(e) {
    e.preventDefault();
    $.post('http://palm-phone/ihbar', JSON.stringify({}));
    // $('.phone-screen').css("display", "none");
});

$('#camera').click(function(e) {
    e.preventDefault();
    $.post('http://palm-phone/opencamera', JSON.stringify({}));
    // $('.phone-screen').css("display", "none");
});

$('#duty').click(function(e) {
    e.preventDefault();
    $.post('http://palm-phone/gorevapp', JSON.stringify({}));
    // $('.phone-screen').css("display", "none");
});



$('#cameraac').click(function(e) {
    e.preventDefault();
    $.post('http://palm-phone/opencamera', JSON.stringify({}));
    // $('.phone-screen').css("display", "none");
});

$('#phone-home').click(function(e) {
    e.preventDefault();
    if (currentApp !== null) {
        $(currentApp).css("display", "none");
        $('.phone-screen').css("display", "block");
    }
});

$('#bank-add-account').click(function(e) {
    e.preventDefault();
    phoneNotify("Maze Bank", "Er is zojuist $500 op uw betaalrekening bijgeschreven.")

    console.log('yeet')
});

$('#add-contact-page-button').click(function(e) {
    e.preventDefault();
    $('.add-contact-page').fadeIn(250);
})

$('#contact-save').click(function(e) {
    e.preventDefault();
    var contactname = $('.add-contact-name').val();
    var contactnr = $('.add-contact-nr').val();

    if (contactname !== "" && contactnr !== "") {
        if (isNaN(contactnr)) {
            phoneNotify("Error", "Een tel nr. bestaat uit cijfers")
        } else {
            console.log('Naam : ' + contactname + ' Tel nr. : ' + contactnr)
            $.post('http://palm-phone/addContact', JSON.stringify({
                name: contactname,
                nr: contactnr
            }))
            $('.add-contact-page').fadeOut(250);
        }
    } else {
        phoneNotify("Error", "U heeft geen naam of tel nr. opgegeven")
    }
})


$('#contact-cancel').click(function(e) {
    e.preventDefault();
    $('.add-contact-page').fadeOut(250);
})

$('#phone-back').click(function(e) {
    e.preventDefault();
    if (previousPage !== null) {
        $(currentApp).css("display", "none");
        $(previousPage).css("display", "block");
        currentApp = previousPage;
        previousPage = null;
    } else {
        if (currentApp !== null || $('.phone-screen').css("display") !== "block") {
            $(currentApp).css("display", "none");
            $('.phone-screen').css("display", "block");

        }
    }
});

function setupPlayerContacts(contacts) {
    $.each(contacts, function(index, contact) {
        $('.player-contacts').html("");
        setTimeout(function() {
            $('.player-contacts').append('<div class="contact" id="cData-' + index + '"><div class="first-letter" style="background-color: rgb(' + contact.color.r + ', ' + contact.color.g + ', ' + contact.color.b + ');">' + (contact.name).charAt(0).toUpperCase() + '</div><span id="name">' + contact.name + '</span><i class="material-icons waves-effect" id="contact-call">call</i><i class="material-icons" id="contact-sms">textsms</i><i class="material-icons" id="contact-edit">edit</i></div>');
            $('#cData-' + index).data("cData", contact);
        }, 100)
    })
}


$('#phone-notification-close').click(function(e) {
    e.preventDefault();
    $('.phone-notification').fadeOut(100);
    notificationClosed = true;
})

function phoneNotify(titel, text) {
    notificationClosed = false;
    $('#phone-notification-titel').html(titel);
    $('#phone-notification-content').html(text)
    $('.phone-notification').fadeIn(250);
    setTimeout(function() {
        if (!notificationClosed) {
            $('.phone-notification').fadeOut(250);
        }
    }, 3500)
}


$('#yolla').click(function(e) {
        e.preventDefault();
        $.post('http://palm-phone/transfer', JSON.stringify({
            to: $('#password').val(),
            amountt: $('#bankMoneyValue').val()

        }));
    })
    //telsize postlama
$('#telsizgir').click(function(e) {
    e.preventDefault();
    $.post('http://palm-phone/telsiz', JSON.stringify({
        channel: $('#telsizfrekans').val()

    }));
})

$('#telsizterket').click(function(e) {
    e.preventDefault();
    $.post('http://palm-phone/telsizterket', JSON.stringify({
        //channel: $('#telsizfrekans').val()

    }));
})

$('#aramagir').click(function(e) {
    e.preventDefault();
    $.post('http://palm-phone/aramayap', JSON.stringify({
        aranan: $('#aranan').val()
    }));
})

$('#aramaterket').click(function(e) {
    e.preventDefault();
    $.post('http://palm-phone/aramakapat', JSON.stringify({
        //channel: $('#telsizfrekans').val()

    }));
})

$('.ayarlar-resim-yukleme-button').click(function() {

    $.post('http://palm-phone/ayarlar-resim-yukle', JSON.stringify({
        resim_url: $('.ayarlar-resim-yukleme').val()

    }));

})

$('#bank-billings-button').click(function() {

    $.post('http://palm-phone/fatura_getir', JSON.stringify({

    }));

})

let ayarlar_resim_durumu = false;
$('#editid').click(function(e) {
    if (ayarlar_resim_durumu == false) {
        $('.ayarlar-resim-upload').css("display", "block");
        ayarlar_resim_durumu = true;
    } else {
        $('.ayarlar-resim-upload').css("display", "none");
        ayarlar_resim_durumu = false;
    }

})

$(function() {
    window.addEventListener('message',async function(event) {
        if (event.data.type === "updateNameSettings") {
            $('.ayarlar-info-isim').html(event.data.isim);
        } else if (event.data.type === "updateNumaraSettings") {
            $('.ayarlar-info-numara').html(event.data.numara);
        } else if (event.data.type === "updateResimSettings") {
            $('#settings-photo').attr('src', event.data.resim);
        } else if (event.data.type === "updatePaketSettings") {
            $('.ayarlar-info-palmcell-pack').html('Palmcell Paketi : ' + event.data.paket + '. Seviye');
        }
         else if (event.data.type === "fatura_yukle") {
            // console.log('Fatura js bildirim');
            // console.log(event.data.faturaid + ' ' + event.data.faturaaciklamasi + ' ' + event.data.faturafiyati );
            let faturaMekan = document.getElementById("fatura-mekan")

            let mainDiv = document.createElement("div")
            mainDiv.id === `${event.data.faturid}`
            mainDiv.className === 'fatura-kutu'

            let faturaAciklamaDiv = document.createElement('div')
            faturaAciklamaDiv.appendChild(document.createTextNode(event.data.faturaaciklamasi))

            faturaFiyatiDiv = document.createElement('div')
            faturaFiyatiDiv.appendChild(document.createTextNode(event.data.faturafiyati))

            mainDiv.appendChild(faturaAciklamaDiv)
            mainDiv.appendChild(faturaFiyatiDiv)

            faturaMekan.appendChild(mainDiv)
        }
    })
})

