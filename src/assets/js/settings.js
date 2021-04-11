const e = document.getElementById('bgs'); 
var value;
const button = document.getElementById('setbg');
const kilit = document.getElementById('howIenter');
const body = document.querySelector('.phone-screen');

e.addEventListener('change',function(){
    value = String(e.options[e.selectedIndex].value);
})

document.addEventListener('DOMContentLoaded',setBgOnLoad);

button.addEventListener('click',function(){
    // addBgToStorage();
    addBgToStorage(value);
    setBackground(value);
})

function getBgToStorage(){
    let bg;

    if (localStorage.getItem('bg') === null ) {
        bg = [];
    }else {
        bg = JSON.parse(localStorage.getItem('bg'));
    }
    return bg;
}

function addBgToStorage(newbg){
    localStorage.setItem('bg',JSON.stringify(newbg));
}

function setBackground(newbg) {
    body.style.backgroundImage = `url(${newbg})`;
    kilit.style.backgroundImage = `url(${newbg})`;
   
}

function setBgOnLoad(){
    let b = String(getBgToStorage());

    setBackground(b);
}