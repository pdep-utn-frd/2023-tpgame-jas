import DragonBallFighter.*
import wollok.game.*
import personajes.*
import powerUPS.*

//███████████████████████████████████████████████████████████████████████████████
//▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒HUDS▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
//███████████████████████████████████████████████████████████████████████████████



object hud {
	const elementos = [hud1,hud2,hud3,hud4,hud1KI,hud2KI]
	method position() = game.at(0,11)
	method iniciar() {
		elementos.forEach({elemento => game.addVisual(elemento)})
	}
	method actualizar(nombre,vida) {
		nombre.actualizar(vida)
	}
	method terminar() {
		elementos.forEach({elemento => game.removeVisual(elemento)})
	}
	
	method reset(){
		elementos.forEach({elemento=>elemento.reset()})
	}
}



object hud1 {
	var property image = "img_vida_P1/vida_p1_10.png"
	method position() = game.at(0,8)
	method actualizar (vida) {
		image = "img_vida_P1/vida_p1_" + vida.max(0) +".png"}
	method reset(){
		image="img_vida_P1/vida_p1_10.png"
	}
}



object hud1KI {
	var property image= "img_vida_P1/hud_ki_p1_2.png"
	method position()=game.at(0,8)
	method actualizar (ki){
		image= "img_vida_P1/hud_ki_p1_" + ki.max(0) +".png"
	}
	method reset(){
		image= "img_vida_P1/hud_ki_p1_2.png"
	}
}



object hud2KI {
	var property image= "img_vida_P2/hud_ki_p2_2.png"
	method position()=game.at(13,8)
	method actualizar (ki){
		image= "img_vida_P2/hud_ki_p2_" + ki.max(0) +".png"
	}
	
	method reset(){
		image= "img_vida_P2/hud_ki_p2_2.png"
	}
}



object hud2 {
    var property image = "img_vida_P2/vida_p2_10.png"
    method position() = game.at(13,8)
   	method actualizar (vida) {
     	image = "img_vida_P2/vida_p2_" + vida.max(0) + ".png"
   }
   
   method reset(){
   		image = "img_vida_P2/vida_p2_10.png"
   }
}



object hud3 {
	var property image="img_vida_P1/hud_p1.png"
	method position()= game.at(0,8)
	method reset(){}
}



object hud4 {
	var property image="img_vida_P2/hud_p2.png"
	method position()= game.at(13,8)
	method reset(){}
}