let header = document.getElementById('header')


const navigation = document.querySelector('nav')
document.querySelector('.menu').onclick = function (){
    this.classList.toggle('active');
    navigation.classList.toggle('active');
}