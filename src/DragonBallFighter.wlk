import wollok.game.*

// Configuración de la pantalla y mecánicas de juego

object pantalla{
	
	method iniciar(){
		self.configuracionDelTablero()
		self.visualesEnPantalla()
		self.programarTeclas()
	}
	
	method configuracionDelTablero(){
		game.width(12)
		game.height(12)
		game.title("Dragon Ball Fighter")
		game.boardGround("color gris.png")
	}
	
	method visualesEnPantalla(){
		game.addVisual(goku)
	}
	
	method programarTeclas(){
		keyboard.d().onPressDo{goku.derecha()}
		keyboard.a().onPressDo{goku.izquierda()}
		keyboard.w().onPressDo{goku.saltar()}
	}
	
}

// Personajes

object goku{
	
	var property image = "Goku_estatico.png"
	var property vida = 5
	var property position = game.at(0,0)
	
	method desplazarse(orientacion){
		orientacion.moverse(self)
	}
	
	method derecha(){
		position = position.right(1)
	}
	
	method izquierda(){
		position = position.left(1)
	}
	
	method subir(){
		position = position.up(2)
		game.schedule(0,{image = "Goku_salto2.png"})
	}
	
	method bajar(){
		position = position.down(2)
		game.schedule(0,{image = "Goku_estatico.png"})
	}
	
	method saltar(){
		if(position.y() == 0){
			self.subir()
			game.schedule(400,{self.bajar()})
		}
	}
	
}

/* Movimiento

object derecha{
	
	method moverse(personaje){
		personaje.position().right(1)
	}
}
*/ 

// Objetos