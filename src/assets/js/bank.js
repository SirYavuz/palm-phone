// Banka uygulamasi

$('#bank-account-button').click(function() {
    $('#fatura-mekan').empty()
    $('#bank-billings').hide();
    $('#bank-billings-button').removeClass('aktifheralde');
    $('#bank-transfer').hide();
    $('#bank-transfer-button').removeClass('aktifheralde');
    $('#bank-account').show();
    $('#bank-account-button').addClass('aktifheralde');
})

$('#bank-transfer-button').click(function() {
    $('#fatura-mekan').empty()
    $('#bank-billings').hide();
    $('#bank-billings-button').removeClass('aktifheralde');
    $('#bank-account').hide();
    $('#bank-account-button').removeClass('aktifheralde');
    $('#bank-transfer').show();
    $('#bank-transfer-button').addClass('aktifheralde');
})

$('#bank-billings-button').click(function() {
    $('#fatura-mekan').empty()
    $('#bank-account').hide();
    $('#bank-account-button').removeClass('aktifheralde');
    $('#bank-transfer').hide();
    $('#bank-transfer-button').removeClass('aktifheralde');
    $('#bank-billings').show();
    $('#bank-billings-button').addClass('aktifheralde');
})

// TELSIZ UYGULAMASI \\

$('#telsiz-account-button').click(function() {
    $('#telsiz-billings').hide();
    $('#telsiz-billings-button').removeClass('aktifheralde');
    $('#telsiz-transfer').hide();
    $('#telsiz-transfer-button').removeClass('aktifheralde');
    $('#telsiz-account').show();
    $('#telsiz-account-button').addClass('aktifheralde');
})

$('#telsiz-transfer-button').click(function() {
    $('#telsiz-billings').hide();
    $('#telsiz-billings-button').removeClass('aktifheralde');
    $('#telsiz-account').hide();
    $('#telsiz-account-button').removeClass('aktifheralde');
    $('#telsiz-transfer').show();
    $('#telsiz-transfer-button').addClass('aktifheralde');
})

$('#telsiz-billings-button').click(function() {
    $('#telsiz-account').hide();
    $('#telsiz-account-button').removeClass('aktifheralde');
    $('#telsiz-transfer').hide();
    $('#telsiz-transfer-button').removeClass('aktifheralde');
    $('#telsiz-billings').show();
    $('#telsiz-billings-button').addClass('aktifheralde');
})

// $(function(){
//     window.addEventListener('message', function(event){
//         if (event.data.type === "updateName") {
//             const bankaccname = document.getElementById('bank-account-name');
//             bankaccname.textContent = event.data.name;
//         }
//     })
// })

$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type === "updateName") {
            $('.bank-account-name').html(event.data.isim);
        } else if (event.data.type === "updateId") {
            $('.account-id').html(event.data.id);
        } else if (event.data.type === "updateMoney") {
            $('.account-money').html(event.data.money + '$');
        }
    })
})


// Registration Form

$('.email').on("change keyup paste",
    function() {
        if ($(this).val()) {
            $('.icon-paper-plane').addClass("next");
        } else {
            $('.icon-paper-plane').removeClass("next");
        }
    }
);

$('.next-button').hover(
    function() {
        $(this).css('cursor', 'pointer');
    }
);

$('.next-button.email').click(
    function() {
        $('.email-section').addClass("fold-up");
        $('.password-section').removeClass("folded");
        console.log('first time');
    }
);

$('.password').on("change keyup paste",
    function() {
        if ($(this).val()) {
            $('.icon-lock').addClass("next");
        } else {
            $('.icon-lock').removeClass("next");
        }
    }
);

$('.next-button').hover(
    function() {
        $(this).css('cursor', 'pointer');
    }
);

$('.next-button.password').click(
    function() {
        console.log("second time");
        $('.password-section').addClass("fold-up");
        $('.repeat-password-section').removeClass("folded");
        $('.back-button').hover(function() {
            $(this).css('cursor', 'pointer');
        })
        var kesilecek = $('#bankMoneyValue').val();
        if (kesilecek >= 1000) {
            $('#kesilecek-para').html(parseFloat(kesilecek * 5 / 100));
        } else {
            $('#kesilecek-para').html('0');
        }
    }
);

$('.repeat-password').on("change keyup paste",
    function() {
        if ($(this).val()) {
            $('.icon-repeat-lock').addClass("next");
        } else {
            $('.icon-repeat-lock').removeClass("next");
        };
        // $('#bankOnaylamaFooter').show();
    }
);

$('.next-button.onaylama').click(
    function() {
        console.log("third time");
        $('.repeat-password-section').addClass("fold-up");
        $('.success').css("marginTop", 0);
    }
);

$('.back-button').click(function() {
    $('.email-section').removeClass("fold-up");
    $('.password-section').addClass("folded");
    $('.password-section').removeClass("fold-up");
    $('.repeat-password-section').addClass("folded");
})

$('#transfer-next').click(function() {
    $('.success').css('marginTop', '-75px');
    $('.email-section').removeClass('fold-up');
    $('.password-section').addClass("folded");
    $('.password-section').removeClass("fold-up");
    $('.repeat-password-section').addClass("folded");
    $('.repeat-password-section').removeClass("fold-up");
})

$('.fatura-kutu').click( e => {
    const divId = e.currentTarget.id
    const id = divId.substring(7)
    console.log('kutu idsi = '+id)
})