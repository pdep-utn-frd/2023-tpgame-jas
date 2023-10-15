import wollok.game.*

// Configuración de la pantalla y mecánicas de juego

object pantalla{
	
	method iniciar(){
		self.configuracionDelTablero()
		self.visualesEnPantalla()
		self.programarTeclas()
	}
	
	
	
	method configuracionDelTablero(){
		game.width(18)
		game.height(12)
		game.cellSize(52)
		game.title("Dragon Ball Fighter")
		game.boardGround("color gris.png")
	}
	
	method visualesEnPantalla(){
		game.addVisual(goku)
		game.addVisual(vegeta)
		game.addVisual(hud1)
		game.addVisual(hud2)
	}
	
	method programarTeclas(){
        keyboard.d().onPressDo{goku.mover(der)}
        keyboard.a().onPressDo{goku.mover(izq)}
        keyboard.w().onPressDo{goku.mover(arriba)}
        keyboard.s().onPressDo{goku.perderVida()}
        keyboard.f().onPressDo{goku.golpear()}
    }
	
}

object finalizarPartida{
	
	var property position = game.center()
	var property image = "vida.png"
	
	method gameOver(){
		game.addVisual(self)
	}
}

object hud1 {
    var property image = "barraDeVida/HUD2.png"
    method position() = game.at(1,10)
   // method actualizar (vida) {
     //   image = "img/HUD/HUD1-" + vida.min(50) + ".png"
   // }
}

object hud2 {
    var property image = "barraDeVida/HUD2_I.png"
    method position() = game.at(12,10)
   // method actualizar (vida) {
     //   image = "img/HUD/HUD1-" + vida.min(50) + ".png"
   // }
}

// Personajes

object goku{
	var enemigo = vegeta
	var property direccion = "D"
	
	var property image = "Goku_estatico_"+self.direccion()+".png"
	var property vida = 5
	var property position = game.at(1,0)
/* 
	method desplazarse(orientacion){
		orientacion.moverse(self)
	}*/
/* 	
	method cambioOrienation(){
		if(self.position().x() > enemigo.position().x()){
			self.image("Goku_estatico_izq.png")
		} else{
			self.image("Goku_estatico.png")
		}
	}*/
	
	method mover(direc){
        if (direc.x() != 0){
            direccion = direc.texto()
            self.position(self.position().right(direc.x()))
            self.image("Goku_estatico_"+direc.texto()+".png")
            self.direccion(direc.texto())
        }

        if (direc.y() > 0){
            if(position.y() >= 0 && position.y()<=2){
                self.position(self.position().up(direc.y()))
                game.schedule(0,{self.image("Goku_" +direc.texto()+ self.direccion() + ".png")})
                game.schedule(400,{self.position(self.position().down(2))})
                game.schedule(400,{self.image("Goku_estatico_" + self.direccion() + ".png")})
            }
        }
       }
/* 
	method saltar(){
		if(position.y() >= 0 && position.y()<=2){
			arriba.moverse(self)
			game.schedule(400,{abajo.moverse(self)})
		}
	}
*/	
	method perderVida(){
		self.vida(self.vida() - 1)
		game.say(self, "tengo " + vida + " de vida")
		if(self.vida() <= 0){
			finalizarPartida.gameOver()
		}
	}
	
	method golpear(){
        game.schedule(0,{self.image("Pegar_"+self.direccion()+".png")})
        game.schedule(300,{self.image("Goku_estatico_"+self.direccion()+".png")})
        if (((self.position().x())-enemigo.position().x())>=-1 && ((self.position().x())-enemigo.position().x())<=1 ){
            enemigo.perderVida()
        }
    }
}

object vegeta{
	var enemigo = goku
	var property direccion = "I"
	
	var property image = "Goku_estatico_I.png"
	var property vida = 5
	var property position = game.at(16,0)
	
	method desplazarse(orientacion){
		orientacion.moverse(self)
	}
	
	method mover(direc){
        if (direc.x() != 0){
            direccion = direc.texto()
            self.position(self.position().right(direc.x()))
            self.image("Gokuestatico"+direc.texto()+".png")
            self.direccion(direc.texto())
        }

        if (direc.y() > 0){
            if(position.y() >= 0 && position.y()<=2){
                self.position(self.position().up(direc.y()))
                game.schedule(0,{self.image("Goku_" +direc.texto()+ self.direccion() + ".png")})
                game.schedule(400,{self.position(self.position().down(2))})
                game.schedule(400,{self.image("Gokuestatico" + self.direccion() + ".png")})
            }
        }
       }
	
	/*method saltar(){
		if(position.y() == 0){
			arriba.moverse(self)
			game.schedule(400,{abajo.moverse(self)})
		}
	}*/
	
	method perderVida(){
		self.vida(self.vida() - 1)
		game.say(self, "tengo " + vida + " de vida")
		if(self.vida() <= 0){
			finalizarPartida.gameOver()
		}
	}
	
	method golpear(){
		game.schedule(0,{self.image("dasdas.png")})
		game.schedule(300,{self.image("Goku_estatico.png")})
		if ((self.position().x())+1 == enemigo.position()){
			enemigo.perderVida()
		}
	}
	
}
/* 
//Movimiento

object derecha{
	method moverse(personaje){
		personaje.direccion("D")
		personaje.image("Goku_estatico_"+personaje.direccion()+".png")
		personaje.position(personaje.position().right(1))
	}
}

object izquierda{
	method moverse(personaje){
		personaje.direccion("I")
		personaje.image("Goku_estatico_"+personaje.direccion()+".png")
		personaje.position(personaje.position().left(1))
	}
}

object arriba{
	var property direccion
	
	method moverse(personaje){
		direccion = personaje.image()
		personaje.position(personaje.position().up(2))
		game.schedule(0,{personaje.image("Goku_salto_"+personaje.direccion()+".png")})
	}
}

object abajo{
	
	var direccion
	method moverse(personaje){
		direccion = personaje.image()
		
		personaje.position(personaje.position().down(2))
		game.schedule(0,{personaje.image(arriba.direccion())})
	}
}
*/

class Movimiento {
    const property x
    const property y
    const property texto
}

const arriba = new Movimiento (x = 0, y = 2, texto = "salto_")
const der = new Movimiento (x = 1, y = 0, texto = "D")
const izq = new Movimiento (x = -1, y = 0, texto = "I")

// Objetos