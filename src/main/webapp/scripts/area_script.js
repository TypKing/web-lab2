let form = document.forms["myForm"];
let x = form.coordinateX;
let y = form.coordinateY;
let r = form.R;
let submitButton = form.elements.mySubmit;
let clearButton = form.elements.myClear;
function setR(value){
    r.value = value;
}
function validation() {
    return(validateR() && validateY(y,-5,3))

}

function validateY(value, bottom, top) {
    let element = value.value.replace(",",".");
    if (!element) {
       alert(`Введите данные в поле ${value.name}. ` + "\n");
        return false;
    }
    if (isNaN(+element)) {
        alert(`Неверный формат данных. Введите в поле ${value.name} дробное число. ` + "\n");
        return false;
    }
    if (!(!isNaN(+element) && +element >=bottom && +element <= top)) {
        alert(`Диапазон ${value.name} должен быть [${bottom}; ${top}]. ` + "\n");
        return false;
    } else {
        return true;
    }
}
function validateR() {
    if (!isNaN(Number(r.value))) return true;
    else {
        alert("Выберите значение R");
        return false;
    }
}

submitButton.onclick = function() {
    console.log("HUI")
    let a = validateY(y, -5, 3);
    let b = validateR();
    if (!(a && b)) {
        alert("Данные введены неверно!")
    } else form.submit();
};