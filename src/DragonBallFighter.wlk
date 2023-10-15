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
		keyboard.d().onPressDo{goku.desplazarse(derecha)}
		keyboard.a().onPressDo{goku.desplazarse(izquierda)}
		keyboard.w().onPressDo{goku.saltar()}
		keyboard.s().onPressDo{goku.perderVida()}
		keyboard.f().onPressDo{goku.golpear()}
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
	
	method saltar(){
		if(position.y() == 0){
			arriba.moverse(self)
			game.schedule(400,{abajo.moverse(self)})
		}
	}
	
	method perderVida(){
		self.vida(self.vida() - 1)
		game.say(self, "tengo " + vida + " de vida")
	}
	
	method golpear(){
		game.schedule(0,{self.image("dasdas.png")})
		game.schedule(300,{self.image("Goku_estatico.png")})
	}
}

//Movimiento

object derecha{
	method moverse(personaje){
		personaje.position(personaje.position().right(1))
	}
}

object izquierda{
	method moverse(personaje){
		personaje.position(personaje.position().left(1))
	}
}

object arriba{
	method moverse(personaje){
		personaje.position(personaje.position().up(3))
		game.schedule(0,{personaje.image("Goku_salto2.png")})
	}
}

object abajo{
	method moverse(personaje){
		personaje.position(personaje.position().down(3))
		game.schedule(0,{personaje.image("Goku_estatico.png")})
	}
}


// Objetos