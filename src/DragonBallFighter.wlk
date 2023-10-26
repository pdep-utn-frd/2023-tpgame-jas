import wollok.game.*
import personajes.*
import huds.*
import powerUPS.*

//███████████████████████████████████████████████████████████████████████████████
//▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒CONFIGURACIÓN INICIAL▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
//███████████████████████████████████████████████████████████████████████████████

object pantalla{


	method iniciar(){
		self.configuracionDelTablero()
		self.visualesEnPantalla()
		self.programarTeclas()
		spawner.iniciar()
		goku.iniciar()
		vegeta.iniciar()
		hud.iniciar()
		game.boardGround("Fondo/transicion1.jpg")
		
	}
	
	
	method configuracionDelTablero(){
		game.width(18)
		game.height(10)
		game.cellSize(60)
		game.title("Dragon Ball Fighter")
		game.boardGround("color gris.png")
	}
	
	
	method visualesEnPantalla(){
		game.addVisual(goku)
		game.addVisual(vegeta)
	}
	
	
	method programarTeclas(){
        keyboard.d().onPressDo{goku.mover(der)}
        keyboard.a().onPressDo{goku.mover(izq)}
        keyboard.w().onPressDo{goku.mover(arriba)}
        keyboard.s().onPressDo{goku.golpear()}
        keyboard.right().onPressDo{vegeta.mover(der)}
        keyboard.left().onPressDo{vegeta.mover(izq)}
        keyboard.up().onPressDo{vegeta.mover(arriba)}
        keyboard.down().onPressDo{vegeta.golpear()}
        keyboard.shift().onPressDo{vegeta.ataqueEspecial()}
        keyboard.r().onPressDo{goku.ataqueEspecial()}
    }
	
}


object finalizarPartida{
	
	var property position = game.center()
	var property text ="¡Game Over!"
	
	
	method gameOver(){
		game.addVisual(self)
		game.schedule(10000,{game.stop()})
	}
}









// Objetos